package data.dao;

import java.sql.*;
import java.util.*;

import org.apache.jasper.tagplugins.jstl.core.Catch;

import data.dto.ReviewDTO;
import db.copy.DBConnect;

public class ReviewDAO {

    private DBConnect db = new DBConnect();
    public void insertReview(ReviewDTO dto) {
        String sql = "INSERT INTO reviews (product_id, member_name, regdate, purchase_option, satisfaction_text, content, size_fit, height, weight, usual_size, size_comment, photo_path) " +
                     "VALUES (?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getProductId());
            pstmt.setString(2, dto.getMemberName());
            pstmt.setString(3, dto.getPurchaseOption());
            pstmt.setString(4, dto.getSatisfactionText());
            pstmt.setString(5, dto.getContent());
            pstmt.setString(6, dto.getSizeFit());
            pstmt.setInt(7, dto.getHeight());
            pstmt.setInt(8, dto.getWeight());
            pstmt.setString(9, dto.getUsualSize());
            pstmt.setString(10, dto.getSizeComment());
            pstmt.setString(11, dto.getPhotoPath());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<ReviewDTO> getReviewsByProductId(int productId) {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE product_id = ? ORDER BY regdate DESC";

        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReviewDTO dto = new ReviewDTO();
                    dto.setId(rs.getInt("id"));
                    dto.setProductId(rs.getInt("product_id"));
                    dto.setMemberName(rs.getString("member_name"));
                    dto.setRegdate(rs.getString("regdate"));
                    dto.setPurchaseOption(rs.getString("purchase_option"));
                    dto.setSatisfactionText(rs.getString("satisfaction_text"));
                    dto.setContent(rs.getString("content"));
                    dto.setSizeFit(rs.getString("size_fit"));
                    dto.setHeight(rs.getInt("height"));
                    dto.setWeight(rs.getInt("weight"));
                    dto.setUsualSize(rs.getString("usual_size"));
                    dto.setSizeComment(rs.getString("size_comment"));
                    dto.setPhotoPath(rs.getString("photo_path"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public double getAverageRatingByProductId(int productId) {
        double avg = 0.0;
        String sql = """
            SELECT AVG(
                CASE satisfaction_text
                    WHEN '최고예요' THEN 5
                    WHEN '좋아요' THEN 4
                    WHEN '괜찮아요' THEN 3
                    WHEN '그저 그래요' THEN 2
                    WHEN '별로예요' THEN 1
                    ELSE 0
                END
            ) AS avg_rating
            FROM reviews
            WHERE product_id = ?
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble("avg_rating");
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return avg;
    }

    public String getReviewMemberName(String reviewId) {
        String memberName = null;
        String sql = "SELECT member_name FROM reviews WHERE id = ?";
        
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, reviewId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    memberName = rs.getString("member_name");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return memberName;
    }
    
    public boolean deleteReview(String reviewId) {
        boolean success = false;
        String sql = "DELETE FROM reviews WHERE id = ?";
        
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, reviewId);
            int result = pstmt.executeUpdate();
            success = result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return success;
    }
}