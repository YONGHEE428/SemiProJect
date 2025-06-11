package data.dao;

import db.copy.DBConnect;
import data.dto.ProductDto;
import data.dto.ProductOptionDto;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal; // BigDecimal import 추가

public class ProductDao {

    DBConnect db = new DBConnect(); // DB 연결 객체

    // 상품 및 옵션 저장 메서드 (isTemporary 매개변수 제거)
    public void saveProduct(ProductDto productDto, List<ProductOptionDto> optionList) {
        Connection conn = null;
        PreparedStatement pstmtProduct = null;
        PreparedStatement pstmtOption = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            String sqlProduct = "";
            int generatedProductId = productDto.getProductId(); // 초기값으로 DTO의 productId 사용

            if (productDto.getProductId() > 0) { // 기존 상품 업데이트
                // updated_at 필드를 자동으로 업데이트하는 경우, SQL에서 NOW() 또는 CURRENT_TIMESTAMP 사용
                sqlProduct = "UPDATE product SET product_name=?, price=?, main_image_url=?, description=?, category=?, updated_at=NOW() WHERE product_id=?";
                pstmtProduct = conn.prepareStatement(sqlProduct);
                pstmtProduct.setString(1, productDto.getProductName());
                pstmtProduct.setBigDecimal(2, productDto.getPrice());
                pstmtProduct.setString(3, productDto.getMainImageUrl());
                pstmtProduct.setString(4, productDto.getDescription());
                pstmtProduct.setString(5, productDto.getCategory());
                pstmtProduct.setInt(6, productDto.getProductId());
            } else { // 새로운 상품 삽입
                // registered_at, updated_at 필드를 자동으로 설정하는 경우, SQL에서 NOW() 사용
                sqlProduct = "INSERT INTO product (product_name, price, main_image_url, description, category, registered_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
                pstmtProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS);
                pstmtProduct.setString(1, productDto.getProductName());
                pstmtProduct.setBigDecimal(2, productDto.getPrice());
                pstmtProduct.setString(3, productDto.getMainImageUrl());
                pstmtProduct.setString(4, productDto.getDescription());
                pstmtProduct.setString(5, productDto.getCategory());
            }

            int affectedRows = pstmtProduct.executeUpdate();

            if (productDto.getProductId() == 0 && affectedRows > 0) { // 새로 삽입된 경우에만 generated keys를 가져옴
                rs = pstmtProduct.getGeneratedKeys();
                if (rs.next()) {
                    generatedProductId = rs.getInt(1);
                }
            }

            if (generatedProductId <= 0) { // 상품 ID를 가져오지 못했거나 유효하지 않은 경우
                throw new SQLException("상품 ID를 가져오는 데 실패했습니다.");
            }
            productDto.setProductId(generatedProductId); // DTO에 최종 ID 설정

            // 기존 옵션 삭제 후 새로 삽입 (상품 ID가 있는 경우에만)
            // 상품 수정 시 기존 옵션을 삭제하는 방식은 FOREIGN KEY 제약 조건 위반 가능성 있음
            // 이 부분은 향후 옵션 업데이트 로직으로 변경 필요
            // if (productDto.getProductId() > 0) {
            //     String deleteOptionsSql = "DELETE FROM product_option WHERE product_id = ?";
            //     try (PreparedStatement pstmtDelete = conn.prepareStatement(deleteOptionsSql)) {
            //         pstmtDelete.setInt(1, productDto.getProductId());
            //         pstmtDelete.executeUpdate();
            //     }
            // }

            if (optionList != null && !optionList.isEmpty()) {
                // 기존: String sqlOption = "INSERT INTO product_option (product_id, color, size, stock_quantity) VALUES (?, ?, ?, ?)";
                // 변경: ON DUPLICATE KEY UPDATE를 사용하여 중복 시 업데이트, 없으면 삽입
                String sqlOption = "INSERT INTO product_option (product_id, color, size, stock_quantity) " +
                                   "VALUES (?, ?, ?, ?) " +
                                   "ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity), color = VALUES(color), size = VALUES(size)";
                // Note: color와 size는 ON DUPLICATE KEY UPDATE 절에 포함되지 않아도 됩니다. (unique key의 일부이므로 변경되지 않음)
                // 그러나 명시적으로 포함해도 문제 없습니다. 주된 목적은 stock_quantity 업데이트.

                pstmtOption = conn.prepareStatement(sqlOption);

                for (ProductOptionDto option : optionList) {
                    pstmtOption.setInt(1, productDto.getProductId());
                    pstmtOption.setString(2, option.getColor());
                    pstmtOption.setString(3, option.getSize());
                    pstmtOption.setInt(4, option.getStockQuantity());
                    pstmtOption.addBatch();
                }
                pstmtOption.executeBatch();
            }

            conn.commit(); // 트랜잭션 커밋
            System.out.println("상품 및 옵션 정보가 성공적으로 " + (productDto.getProductId() > 0 && productDto.getProductId() == generatedProductId ? "업데이트" : "등록") + "되었습니다. Product ID: " + productDto.getProductId());


        } catch (SQLException e) {
            System.err.println("상품 및 옵션 저장 중 오류 발생: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            throw new RuntimeException("상품 등록/업데이트 실패", e);
        } finally {
            db.dbClose(rs, pstmtProduct, conn);
            if (pstmtOption != null) { try { pstmtOption.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }

    // 상품 ID로 상품 전체 정보를 조회하는 메서드
    public ProductDto getProductById(int productId) { // ⭐️ 새로 추가된 메서드
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductDto productDto = null;

        try {
            conn = db.getConnection();
            String sql = "select * from product where product_id =?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                productDto = new ProductDto();
                productDto.setProductId(rs.getInt("product_id"));
                productDto.setProductName(rs.getString("product_name"));
                productDto.setPrice(rs.getBigDecimal("price"));
                productDto.setMainImageUrl(rs.getString("main_image_url"));
                productDto.setDescription(rs.getString("description"));
                productDto.setCategory(rs.getString("category"));
                productDto.setRegisteredAt(rs.getTimestamp("registered_at"));
                productDto.setLikeCout(rs.getString("like_count"));
                productDto.setViewCount(rs.getString("view_count"));
                productDto.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (SQLException e) {
            System.err.println("getProductById 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return productDto;
    }

    // 상품 ID로 해당 상품의 모든 옵션을 조회하는 메서드
    public List<ProductOptionDto> getProductOptionsByProductId(int productId) { // ⭐️ 기존 메서드, ProductDto에 옵션 List를 설정하는 용도로 활용됨
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductOptionDto> optionList = new ArrayList<>();

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM product_option WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductOptionDto option = new ProductOptionDto();
                option.setOptionId(rs.getInt("option_id"));
                option.setProductId(rs.getInt("product_id"));
                option.setColor(rs.getString("color"));
                option.setSize(rs.getString("size"));
                option.setStockQuantity(rs.getInt("stock_quantity"));
                optionList.add(option);
            }
        } catch (SQLException e) {
            System.err.println("getProductOptionsByProductId 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return optionList;
    }

    // 카테고리별 상품 및 옵션 조회 메서드 (기존과 동일)
    public List<ProductDto> getProductsWithOptionsByCategory(String categoryName) {
        Map<Integer, ProductDto> productMap = new LinkedHashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder(
            "SELECT p.product_id, p.product_name, p.price, p.category, p.main_image_url, p.description, p.registered_at, p.updated_at, " +
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
                    product.setMainImageUrl(rs.getString("main_image_url"));
                    product.setDescription(rs.getString("description"));
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
            System.err.println("카테고리별 상품 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return new ArrayList<>(productMap.values());
    }
    
    public int option_num(String color, String size, int productId) {
    	int option_num = 0;
    	Connection cn = db.getConnection();
    	PreparedStatement pst = null;
    	ResultSet rs = null;
    	
    	String sql = "selcet option_id from product_option where color = ? and size = ? and product_id = ?";
    	
    	try {
			pst=cn.prepareStatement(sql);
			
			pst.setString(1, color);
			pst.setString(2, size);
			pst.setInt(3, productId);
			
			rs = pst.executeQuery();
			if(rs.next()) {
				option_num = rs.getInt("option_id");
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}finally {
			db.dbClose(rs, pst, cn);
		}
    	return option_num;
    }
    
    //상위 6개 좋아요 기준으로출력
    public List<ProductDto> getTopLikedProducts() {
        Map<Integer, ProductDto> productMap = new LinkedHashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT p.product_id, p.product_name, p.price, p.category, p.main_image_url, p.description, " +
                "p.view_count, p.like_count, p.registered_at, p.updated_at " +
                "FROM product p ORDER BY p.like_count DESC LIMIT 6";


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
                    product.setMainImageUrl(rs.getString("main_image_url"));
                    product.setDescription(rs.getString("description"));
                    product.setViewCount(rs.getString("view_count"));  
                    product.setLikeCout(rs.getString("like_count"));   
                    product.setRegisteredAt(rs.getTimestamp("registered_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setOptions(new ArrayList<>());
                    productMap.put(productId, product);
                }
            }
        } catch (SQLException e) {
            System.err.println("상위 좋아요 상품 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
           db.dbClose(rs, pstmt, conn);
        }

        return new ArrayList<>(productMap.values());
    }


    // 상품 이미지 URL을 가져오는 메서드 (기존과 동일)
    public String getProductImageUrl(int productId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String imageUrl = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT main_image_url FROM product WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                imageUrl = rs.getString("main_image_url");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return imageUrl;
    }

    // 상품 옵션 삭제 메서드 (기존과 동일)
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

    // 상품 삭제 메서드 (기존과 동일)
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
                try { conn.rollback(); } catch (SQLException ex) { System.err.println("롤백 중 오류: " + ex.getMessage()); }
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
			pstmt.setInt(1, productId);
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
	
	// 페이징 처리된 상품 목록을 가져오는 메서드 (JSON 생성용)
	public List<ProductDto> getProductsByPage(int page, int pageSize) {
	    List<ProductDto> productList = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    int offset = (page - 1) * pageSize;

	    String sql = "SELECT product_id, product_name, price, main_image_url, category, like_count, view_count FROM product ORDER BY product_id DESC LIMIT ?, ?";

	    try {
	        conn = db.getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, offset);
	        pstmt.setInt(2, pageSize);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ProductDto dto = new ProductDto();
	            dto.setProductId(rs.getInt("product_id"));
	            dto.setProductName(rs.getString("product_name"));
	            dto.setPrice(rs.getBigDecimal("price"));
	            dto.setMainImageUrl(rs.getString("main_image_url"));
	            dto.setCategory(rs.getString("category"));
	            dto.setLikeCout(rs.getString("like_count"));
	            dto.setViewCount(rs.getString("view_count"));
	            productList.add(dto);
	        }
	    } catch (SQLException e) {
	        System.err.println("페이징 상품 조회 오류: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return productList;
	}

	public List<ProductDto> getProductsByCategory(String category1, String catgory2, int page, int pageSize) {
	    List<ProductDto> productList = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    int offset = (page - 1) * pageSize;

	    String sql = "SELECT product_id, product_name, price, main_image_url, category, like_count, view_count FROM product WHERE category IN (?, ?) ORDER BY product_id DESC LIMIT ?, ?";

	    try {
	        conn = db.getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, category1);
	        pstmt.setString(2, catgory2);
	        pstmt.setInt(3, offset);
	        pstmt.setInt(4, pageSize);
	       
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ProductDto dto = new ProductDto();
	            dto.setProductId(rs.getInt("product_id"));
	            dto.setProductName(rs.getString("product_name"));
	            dto.setPrice(rs.getBigDecimal("price"));
	            dto.setMainImageUrl(rs.getString("main_image_url"));
	            dto.setCategory(rs.getString("category"));
	            dto.setLikeCout(rs.getString("like_count"));
	            dto.setViewCount(rs.getString("view_count"));
	            productList.add(dto);
	        }
	    } catch (SQLException e) {
	        System.err.println("페이징 상품 조회 오류: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return productList;
	}

}