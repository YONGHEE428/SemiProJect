package data.dao;

import java.sql.*;
import java.util.*;
import data.dto.ReviewDTO;
import db.copy.DBConnect;

public class ReviewDAO {

    private DBConnect db = new DBConnect();

    public int insertReview(ReviewDTO dto) {
        String sql = "INSERT INTO review (member_name, purchase_option, content, satisfaction_text, size_fit, size_comment, height, weight, usual_size, photo_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getMemberName());
            ps.setString(2, dto.getPurchaseOption());
            ps.setString(3, dto.getContent());
            ps.setString(4, dto.getSatisfactionText());
            ps.setString(5, dto.getSizeFit());
            ps.setString(6, dto.getSizeComment());
            ps.setString(7, dto.getHeight());
            ps.setString(8, dto.getWeight());
            ps.setString(9, dto.getUsualSize());
            ps.setString(10, dto.getPhotoPath());

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ReviewDTO> getAllReviews() {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM review ORDER BY review_id DESC";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                dto.setReviewId(rs.getInt("review_id"));
                dto.setMemberName(rs.getString("member_name"));
                dto.setPurchaseOption(rs.getString("purchase_option"));
                dto.setContent(rs.getString("content"));
                dto.setSatisfactionText(rs.getString("satisfaction_text"));
                dto.setSizeFit(rs.getString("size_fit"));
                dto.setSizeComment(rs.getString("size_comment"));
                dto.setHeight(rs.getString("height"));
                dto.setWeight(rs.getString("weight"));
                dto.setUsualSize(rs.getString("usual_size"));
                dto.setPhotoPath(rs.getString("photo_path"));
                dto.setRegdate(rs.getString("regdate"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
