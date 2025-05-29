package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.boardlistDto;
import db.copy.DBConnect;

public class boardlistDao {

	DBConnect db=new DBConnect();
	
	
	//insert
	public void insertBoardList(boardlistDto dto)
	{
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    String sql = "insert into coffee.semi_boardlist (idx, type, title, text, regdate) values (null, ?, ?, ?, now())";
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, dto.getType());
	        pstmt.setString(2, dto.getTitle());
	        pstmt.setString(3, dto.getText());
	        pstmt.execute();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(pstmt, conn);
	    }
	}
	
	//Type별 리스트 조회
	public List<boardlistDto> getListByType(String type)
	{
		List<boardlistDto> list=new ArrayList<boardlistDto>();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from semi_boardlist where type=? order by idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, type);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				boardlistDto dto=new boardlistDto();
				dto.setTitle(rs.getString("title"));
				dto.setText(rs.getString("text"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	}
	//update
	
	//delete
	public void deleteBoardList(String idx)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from semi_boardlist where idx=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		
	}

}
