package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.copy.DBConnect;

public class WishListDao {
	DBConnect db= new DBConnect();
	
	public boolean insertWishList(int memberId,int productId, int optionId) {
	Connection conn=db.getConnection();
	PreparedStatement pstmt=null;
	boolean result=false;
	
	String sql="insert into wishlist values(null,?,?,?)";
	try {
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, memberId);
		pstmt.setInt(2, productId);
		pstmt.setInt(3, optionId);
		
		int affectedRows=pstmt.executeUpdate();
		if(affectedRows>0) {
			result=true;
		}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		db.dbClose(pstmt, conn);
	}
		//데이터가 추가되면 true 반환
		return result;
	}
	
	
}
