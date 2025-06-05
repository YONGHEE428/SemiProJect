package data.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import data.dto.CartListDto;
import db.copy.DBConnect;

public class CartListDao {

   DBConnect db = new DBConnect();

   // 1. 장바구니 목록 조회 (회원 이름 포함)
   public List<CartListDto> getCartListByMember(String member_id) {
      List<CartListDto> list = new ArrayList<>();

      String sql = "SELECT c.*, p.product_name, p.price, p.main_image_url, o.color, o.size, m.name AS member_name "
            + "FROM cartlist c " + "JOIN product p ON c.product_id = p.product_id "
            + "JOIN product_option o ON c.option_id = o.option_id " + "JOIN member m ON c.member_id = m.id "
            + "WHERE c.member_id = ? AND c.buyok = 0 ORDER BY c.idx DESC";

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
            dto.setMain_image_url(rs.getString("main_image_url")); 
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
      try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

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
      try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

         pstmt.setInt(1, idx);
         int result = pstmt.executeUpdate();
         return result > 0;

      } catch (SQLException e) {
         e.printStackTrace();
         return false;
      }
   }

   // 4. 구매 처리: buyok=1로 변경 (추가로 구현 필요 시 확장)
   public void markAsPurchased(int idx) {
      String sql = "UPDATE shop.cartlist SET buyok = 1 WHERE idx = ?";
      try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

         pstmt.setInt(1, idx);
         pstmt.executeUpdate();

      } catch (SQLException e) {
         e.printStackTrace();
      }
   }

   // CartListDao.java
   public void markAsPurchased(List<Integer> idxList) {
      String sql = "UPDATE shop.cartlist SET buyok = 1 WHERE idx = ?";
      try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

         for (int idx : idxList) {
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();
         }

      } catch (SQLException e) {
         e.printStackTrace();
      }
   }

   // 또는 전체상품 주문 처리 (member_id로 처리)
   public void markAllAsPurchased(String memberId) {
      String sql = "UPDATE shop.cartlist SET buyok = 1 WHERE member_id = ?";
      try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

         pstmt.setString(1, memberId);
         pstmt.executeUpdate();

      } catch (SQLException e) {
         e.printStackTrace();
      }
   }

   // 선택한 cart idx 들로 항목 리스트 가져오기
   public List<CartListDto> getCartItemsByIdxs(String[] idxs) {
       List<CartListDto> list = new ArrayList<>();
       if (idxs == null) return list;

       String sql = "SELECT c.*, p.price FROM cartlist c " +
                    "JOIN product p ON c.product_id = p.product_id " +
                    "WHERE c.idx = ?";

       try (Connection conn = db.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

           for (String idxStr : idxs) {
               ps.setInt(1, Integer.parseInt(idxStr));
               ResultSet rs = ps.executeQuery();
               if (rs.next()) {
                   CartListDto dto = new CartListDto();
                   dto.setIdx(rs.getString("idx"));
                   dto.setProduct_id(rs.getString("product_id"));
                   dto.setOption_id(rs.getString("option_id"));
                   dto.setCnt(rs.getString("cnt"));
                   dto.setPrice(rs.getInt("price"));
                   list.add(dto);
               }
               rs.close();
           }
       } catch (Exception e) {
           e.printStackTrace();
       }

       return list;
   }
   // 단일 장바구니 항목을 idx로 가져오기 (주문 처리 등에서 필요)
   public CartListDto getCartItemByIdx(int idx) {
       CartListDto dto = null;
       String sql = "SELECT c.*, p.product_name, p.price, p.main_image_url, o.color, o.size " +
                    "FROM cartlist c " +
                    "JOIN product p ON c.product_id = p.product_id " +
                    "JOIN product_option o ON c.option_id = o.option_id " +
                    "WHERE c.idx = ?";
       try (Connection conn = db.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
           pstmt.setInt(1, idx);
           ResultSet rs = pstmt.executeQuery();
           if (rs.next()) {
               dto = new CartListDto();
               dto.setIdx(rs.getString("idx"));
               dto.setProduct_id(rs.getString("product_id"));
               dto.setOption_id(rs.getString("option_id"));
               dto.setMember_id(rs.getString("member_id"));
               dto.setCnt(rs.getString("cnt"));
               dto.setWriteday(rs.getTimestamp("writeday"));
               dto.setBuyok(rs.getInt("BUYOK"));
               dto.setProduct_name(rs.getString("product_name"));
               dto.setPrice(rs.getInt("price"));
               dto.setMain_image_url(rs.getString("main_image_url"));
               dto.setColor(rs.getString("color"));
               dto.setSize(rs.getString("size"));
           }
           rs.close();
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return dto;
   }

}
