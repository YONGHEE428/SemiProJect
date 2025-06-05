package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import db.copy.DBConnect;

public class WishListDao {
	DBConnect db= new DBConnect();
	
	public boolean insertWishList(int productId, int optionId, String memberId) {
	Connection conn=db.getConnection();
	PreparedStatement pstmt=null;
	
	String sql="";
			
		
		
		
		//데이터가 추가되면 true 반환
		return (Boolean) null;
	}
}
