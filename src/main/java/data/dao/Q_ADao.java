package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.Q_ADto;
import db.copy.DBConnect;

public class Q_ADao {
    private DBConnect db = new DBConnect();

    public boolean addInquiry(Q_ADto dto) {
    	  String sql = "INSERT INTO Q_A "
                  + "(product_id, user_id, title, content, is_private, password, created_at) "
                  + "VALUES (?,?,?,?,?,?,NOW())";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, dto.getProductId());
            ps.setString(2, dto.getUserId());
            ps.setString(3, dto.getTitle());
            ps.setString(4, dto.getContent());
            ps.setBoolean(5, dto.isPrivate());
            ps.setString(6, dto.getPassword());
            
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Q_ADto> getInquiriesByProductId(int productId) {
        String sql =
            "SELECT inquiry_id, product_id, user_id, title, content, is_private, password, created_at\n"
          + "  FROM Q_A\n"
          + " WHERE product_id = ?\n"
          + " ORDER BY created_at DESC";

        List<Q_ADto> list = new ArrayList<>();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
          ps.setInt(1, productId);
          ResultSet rs = ps.executeQuery();
          while (rs.next()) {
            Q_ADto dto = new Q_ADto();
            dto.setInquiryId(  rs.getInt("inquiry_id") );
            dto.setProductId(  rs.getInt("product_id") );
            dto.setUserId(     rs.getString("user_id") );
            dto.setTitle(      rs.getString("title") );
            dto.setContent(    rs.getString("content") );
            dto.setPrivate(    rs.getBoolean("is_private") );
            dto.setPassword(   rs.getString("password") );
            dto.setCreatedAt(  rs.getString("created_at") );  // 여기도 이름 변경
            list.add(dto);
          }
        } catch (SQLException e) {
          e.printStackTrace();  // 에러 로그 확인
        }
        return list;
    }


public boolean checkPassword(int inquiryId, String pw) {
    String sql = "SELECT password FROM Q_A WHERE inquiry_id = ?";
    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, inquiryId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return pw.equals(rs.getString("password"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
public Q_ADto getInquiryById(int inquiryId) {
    String sql = "SELECT * FROM Q_A WHERE inquiry_id = ?";
    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, inquiryId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Q_ADto dto = new Q_ADto();
            dto.setInquiryId(rs.getInt("inquiry_id"));
            dto.setProductId(rs.getInt("product_id"));
            dto.setUserId(rs.getString("user_id"));
            dto.setTitle(rs.getString("title"));
            dto.setContent(rs.getString("content"));
            dto.setPrivate(rs.getBoolean("is_private"));
            dto.setPassword(rs.getString("password"));
            dto.setCreatedAt(rs.getString("created_at"));
            return dto;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
}