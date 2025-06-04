package data.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.dto.ReviewsDto;
import db.copy.DBConnect;

public class ReviewsDao {

	
	
	//리뷰 등록
	


	    DBConnect db = new DBConnect();

	    public void insertReview(ReviewsDto dto) {
	        String sql = "INSERT INTO reviews (review_num, product_num, member_num, member_id, rating, content, height, weight, usual_size, size_fit, size_comment, created_at) " +
	                     "VALUES (seq_reviews.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
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
	            pstmt.setString(9, dto.getSize_fit());      // size_fit 추가
	            pstmt.setString(10, dto.getSize_comment()); // size_comment 추가

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

