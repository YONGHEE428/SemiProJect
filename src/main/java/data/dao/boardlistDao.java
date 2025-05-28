package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import data.dto.boardlistDto;
import db.copy.DBConnect;

public class boardlistDao {

	DBConnect db=new DBConnect();
	
	
	//insert
	public void insertBoardList(boardlistDto dto)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into semi_boardlist values(null,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getType());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getText());
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		
	}
	//update
	
	//delete
		

}
