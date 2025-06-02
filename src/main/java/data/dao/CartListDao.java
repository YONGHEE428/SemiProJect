package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.CartListDto;
import db.copy.DBConnect;

public class CartListDao {
	DBConnect db = new DBConnect();

	

	public void addCart(CartListDto dto) {
	    String sql = "INSERT INTO cart (product_id, member_id, option_id, size, color, cnt, writeday, buyok) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, now(), 0)";
	    
	    try (Connection conn = db.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, dto.getProduct_id());
	        pstmt.setString(2, dto.getMember_id());
	        pstmt.setString(3, dto.getOption_id());
	        pstmt.setString(4, dto.getSize());
	        pstmt.setString(5, dto.getColor());
	        pstmt.setString(6, dto.getCnt());

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
    // 장바구니에 상품 추가 (option_id 포함)
    public void insertCart(CartListDto dto) {
        String sql = "INSERT INTO cartlist (product_id, option_id, member_id, cnt, writeday, BUYOK) VALUES (?, ?, ?, ?, now(), 0)";
        try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getProduct_id());
            pstmt.setString(2, dto.getOption_id());
            pstmt.setString(3, dto.getMember_id());
            pstmt.setString(4, dto.getCnt());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 회원별 장바구니 목록 (product, product_option 조인)
    public List<CartListDto> getCartListByMember(String member_id) {
        List<CartListDto> list = new ArrayList<>();
        String sql = "SELECT c.*, p.product_name, p.price, p.main_image, p.description, p.category, o.color, o.size " +
                "FROM cartlist c " +
                "JOIN product p ON c.product_id = p.product_id " +
                "JOIN product_option o ON c.option_id = o.option_id " +
                "WHERE c.member_id = ? ORDER BY c.idx DESC";
        try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member_id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                CartListDto dto = new CartListDto();
                dto.setIdx(rs.getString("idx"));
                dto.setProduct_id(rs.getString("product_id"));
                dto.setOption_id(rs.getString("option_id"));
                dto.setMember_id(rs.getString("member_id"));
                dto.setCnt(rs.getString("cnt"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setBuyok(rs.getInt("BUYOK"));
                dto.setProduct_name(rs.getString("product_name"));
                dto.setPrice(rs.getInt("price"));
                dto.setMain_image(rs.getString("main_image"));
                dto.setDescription(rs.getString("description"));
                dto.setCategory(rs.getString("category"));
                dto.setColor(rs.getString("color"));
                dto.setSize(rs.getString("size"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 수량 변경 (option_id 포함)
    public void updateCnt(int idx, int cnt) {
        String sql = "UPDATE cartlist SET cnt = ? WHERE idx = ?";
        try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cnt);
            pstmt.setInt(2, idx);
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 장바구니 항목 삭제
    public void deleteCart(int idx) {
        String sql = "DELETE FROM cartlist WHERE idx = ?";
        try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //구매하기 버튼 누르면 buyok=1로 바뀜.
    public CartListDto getAllDatas(int buyok)
    {
    	CartListDto dto=new CartListDto();
    	
    	
    	return dto;
    }
    
    
} 


