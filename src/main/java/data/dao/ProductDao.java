package data.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import db.copy.DBConnect;
import data.dto.ProductDto;
import data.dto.ProductOptionDto;

public class ProductDao {

    DBConnect db = new DBConnect();

    public void insertProduct(ProductDto productDto, List<ProductOptionDto> optionList) {
        int generatedProductId = -1;
        Connection conn = null;

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            String sqlProduct = "INSERT INTO product (product_name, price, main_image, description, category) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmtProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS)) {
                pstmtProduct.setString(1, productDto.getProductName());
                pstmtProduct.setBigDecimal(2, productDto.getPrice());
                // getMainImage()가 byte[]를 반환한다고 가정 (DB에 byte[]로 저장)
                pstmtProduct.setBytes(3, (byte[]) productDto.getMainImage());
                pstmtProduct.setString(4, productDto.getDescription());
                pstmtProduct.setString(5, productDto.getCategory());

                int affectedRows = pstmtProduct.executeUpdate();

                if (affectedRows > 0) {
                    try (ResultSet rs = pstmtProduct.getGeneratedKeys()) {
                        if (rs.next()) {
                            generatedProductId = rs.getInt(1);
                            productDto.setProductId(generatedProductId);
                        }
                    }
                }

                if (generatedProductId == -1) {
                    if (conn != null) conn.rollback();
                    throw new SQLException("Failed to retrieve generated product_id.");
                }
            }

            if (optionList != null && !optionList.isEmpty()) {
                String sqlOption = "INSERT INTO product_option (product_id, color, size, stock_quantity) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmtOption = conn.prepareStatement(sqlOption)) {
                    for (ProductOptionDto option : optionList) {
                        pstmtOption.setInt(1, generatedProductId);
                        pstmtOption.setString(2, option.getColor());
                        pstmtOption.setString(3, option.getSize());
                        pstmtOption.setInt(4, option.getStockQuantity());
                        pstmtOption.addBatch();
                    }
                    pstmtOption.executeBatch();
                }
            }

            conn.commit();
            System.out.println("상품 및 옵션 정보 저장 성공. Product ID: " + generatedProductId);

        } catch (SQLException e) {
            System.err.println("상품 및 옵션 저장 중 오류: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); System.err.println("트랜잭션 롤백 완료."); }
                catch (SQLException ex) { System.err.println("롤백 중 오류: " + ex.getMessage()); }
            }
            e.printStackTrace();
            throw new RuntimeException("상품 등록 실패", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    public List<ProductDto> getProductsWithOptionsByCategory(String categoryName) {
        Map<Integer, ProductDto> productMap = new LinkedHashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder(
            "SELECT p.product_id, p.product_name, p.price, p.category, p.main_image, p.description, " +
            "po.option_id, po.color, po.size, po.stock_quantity " +
            "FROM product p " +
            "LEFT JOIN product_option po ON p.product_id = po.product_id "
        );

        boolean hasCategoryFilter = (categoryName != null && !categoryName.trim().isEmpty() && !"전체".equalsIgnoreCase(categoryName));
        if (hasCategoryFilter) {
            sql.append("WHERE p.category = ? ");
        }
        sql.append("ORDER BY p.product_id, po.option_id");

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            if (hasCategoryFilter) {
                pstmt.setString(1, categoryName);
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                ProductDto product = productMap.get(productId);
                if (product == null) {
                    product = new ProductDto();
                    product.setProductId(productId);
                    product.setProductName(rs.getString("product_name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setCategory(rs.getString("category"));
                    // main_image를 byte[]로 가져오기
                    product.setMainImage(rs.getBytes("main_image"));
                    product.setDescription(rs.getString("description"));
                    product.setOptions(new ArrayList<>());
                    productMap.put(productId, product);
                }

                if (rs.getObject("option_id") != null) {
                    ProductOptionDto option = new ProductOptionDto();
                    option.setOptionId(rs.getInt("option_id"));
                    option.setProductId(productId);
                    option.setColor(rs.getString("color"));
                    option.setSize(rs.getString("size"));
                    option.setStockQuantity(rs.getInt("stock_quantity"));
                    product.getOptions().add(option);
                }
            }
        } catch (SQLException e) {
            System.err.println("카테고리별 상품 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return new ArrayList<>(productMap.values());
    }
    
    //상위 6개 좋아요 기준으로출력
    public List<ProductDto> getTopLikedProducts() {
        Map<Integer, ProductDto> productMap = new LinkedHashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql =
            "SELECT p.product_id, p.product_name, p.price, p.category, p.main_image, p.description, " +
            "p.view_count, p.like_count, p.registered_at, p.updated_at, " +
            "po.option_id, po.color, po.size, po.stock_quantity " +
            "FROM product p " +
            "LEFT JOIN product_option po ON p.product_id = po.product_id " +
            "ORDER BY p.like_count DESC " +
            "LIMIT 6";

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                ProductDto product = productMap.get(productId);

                if (product == null) {
                    product = new ProductDto();
                    product.setProductId(productId);
                    product.setProductName(rs.getString("product_name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setCategory(rs.getString("category"));
                    product.setMainImage(rs.getBytes("main_image"));
                    product.setDescription(rs.getString("description"));
                    product.setViewCount(rs.getString("view_count"));  
                    product.setLikeCout(rs.getString("like_count"));   
                    product.setRegisteredAt(rs.getTimestamp("registered_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setOptions(new ArrayList<>());
                    productMap.put(productId, product);
                }

                if (rs.getObject("option_id") != null) {
                    ProductOptionDto option = new ProductOptionDto();
                    option.setOptionId(rs.getInt("option_id"));
                    option.setProductId(productId);
                    option.setColor(rs.getString("color"));
                    option.setSize(rs.getString("size"));
                    option.setStockQuantity(rs.getInt("stock_quantity"));
                    product.getOptions().add(option);
                }
            }
        } catch (SQLException e) {
            System.err.println("상위 좋아요 상품 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return new ArrayList<>(productMap.values());
    }


    public boolean deleteProductOption(int optionId) {
        String sql = "DELETE FROM product_option WHERE option_id = ?";
        boolean success = false;
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, optionId);
            int affectedRows = pstmt.executeUpdate();
            success = (affectedRows > 0);
        } catch (SQLException e) {
            System.err.println("상품 옵션 삭제 중 오류 (option_id: " + optionId + "): " + e.getMessage());
            e.printStackTrace();
        }
        return success;
    }

    public boolean deleteProduct(int productId) {
        Connection conn = null;
        String sqlDeleteOptions = "DELETE FROM product_option WHERE product_id = ?";
        String sqlDeleteProduct = "DELETE FROM product WHERE product_id = ?";
        boolean success = false;

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement pstmtOptions = conn.prepareStatement(sqlDeleteOptions)) {
                pstmtOptions.setInt(1, productId);
                pstmtOptions.executeUpdate();
            }

            try (PreparedStatement pstmtProduct = conn.prepareStatement(sqlDeleteProduct)) {
                pstmtProduct.setInt(1, productId);
                int affectedRows = pstmtProduct.executeUpdate();
                if (affectedRows > 0) {
                    success = true;
                }
            }
            
            if (success) {
                conn.commit();
            } else {
                conn.rollback();
                System.err.println("상품(ID: " + productId + ") 삭제 실패로 트랜잭션 롤백됨.");
            }
        } catch (SQLException e) {
            System.err.println("상품 삭제 트랜잭션 중 오류 (product_id: " + productId + "): " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { System.err.println("롤백 중 오류: " + ex.getMessage());}
            }
            e.printStackTrace();
            success = false;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return success;
    }
    //조회수 증가
	public void updateReadCount(int productId) {
		String sql="update product set view_count=view_count+1 where product_id=?";
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	//좋아요 증가
	public void updateLikeCount(int productId) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		String sql="update product set like_count=like_count+1 where product_id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	public void decreaseLikeCount(int productId) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		String sql="update product set like_count=like_count-1 where product_id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}