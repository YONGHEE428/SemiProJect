package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import data.dto.Q_ADto;
import db.copy.DBConnect;

public class Q_ADao {
    private DBConnect db = new DBConnect();

    public int insertInquiry(Q_ADto dto) {
        String sql = "INSERT INTO product_inquiry (product_id, user_id, title, content, is_private, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (
            Connection conn = db.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, dto.getProductId());
            pstmt.setString(2, dto.getUserId());
            pstmt.setString(3, dto.getTitle());
            pstmt.setString(4, dto.getContent());
            pstmt.setBoolean(5, dto.isPrivate());
            pstmt.setString(6, dto.getPassword());

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public List<Q_ADto> getInquiriesByProductId(int productId) {
        List<Q_ADto> list = new ArrayList<>();
        String sql = "SELECT * FROM product_inquiry WHERE product_id = ? ORDER BY created_at DESC";

        try (
            Connection conn = db.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Q_ADto dto = new Q_ADto();
                dto.setInquiryId(rs.getInt("inquiry_id"));
                dto.setProductId(rs.getInt("product_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setPrivate(rs.getBoolean("is_private"));
                dto.setPassword(rs.getString("password"));
                dto.setCreatedAt(rs.getString("created_at"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}