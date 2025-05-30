package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import data.dto.ReviewsDto;
import db.copy.DBConnect;

public class ReviewsDao {

	
	
	//리뷰 등록
	DBConnect db = new DBConnect();

    public void insertReview(ReviewsDto dto) {
        String sql = "INSERT INTO reviews (review_num, product_num, member_num, member_id, rating, content, height, weight, usual_size, created_at) " +
                     "VALUES (seq_reviews.nextval, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getProduct_num());
            pstmt.setString(2, dto.getMember_num());
            pstmt.setString(3, dto.getMember_id());
            pstmt.setString(4, dto.getRating());
            pstmt.setString(5, dto.getContent());
            pstmt.setString(6, dto.getHeight());
            pstmt.setString(7, dto.getWeight());
            pstmt.setString(8, dto.getUsual_size());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }
}
	
   //리뷰 수정
	
	
   //리뷰 삭제	

