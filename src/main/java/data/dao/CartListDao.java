package data.dao;

import java.sql.*;
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


    // 1. 장바구니 목록 조회 (회원 이름 포함)
    public List<CartListDto> getCartListByMember(String member_id) {
        List<CartListDto> list = new ArrayList<>();

        String sql = "SELECT c.*, p.product_name, p.price, p.main_image, o.color, o.size, m.name AS member_name " +
                     "FROM cartlist c " +
                     "JOIN product p ON c.product_id = p.product_id " +
                     "JOIN product_option o ON c.option_id = o.option_id " +
                     "JOIN member m ON c.member_id = m.id " +
                     "WHERE c.member_id = ? ORDER BY c.idx DESC";

        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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
                dto.setColor(rs.getString("color"));
                dto.setSize(rs.getString("size"));
                dto.setName(rs.getString("member_name")); 

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 수량 변경
    public void updateCnt(int idx, int cnt) {
        String sql = "UPDATE shop.cartlist SET cnt = ? WHERE idx = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, cnt);
            pstmt.setInt(2, idx);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 3. 장바구니 항목 삭제
    public boolean deleteCartItem(int idx) {
        String sql = "DELETE FROM shop.cartlist WHERE idx = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idx);
            int result = pstmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //구매하기 버튼 누르면 buyok=1로 바뀜.
    public CartListDto getAllDatas(int buyok)
    {
    	CartListDto dto=new CartListDto();
    	
    	
    	return dto;
    }
    
    
} 


    // 4. 구매 처리: buyok=1로 변경 (추가로 구현 필요 시 확장)
    public void markAsPurchased(int idx) {
        String sql = "UPDATE shop.cartlist SET buyok = 1 WHERE idx = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idx);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
