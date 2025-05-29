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
	    String sql = "insert into shop.boardlist (idx, type, title, text, regdate) values (null, ?, ?, ?, now())";
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
		
		String sql="select * from shop.boardlist where type=? order by idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, type);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				boardlistDto dto=new boardlistDto();
				dto.setTitle(rs.getString("title"));
				dto.setText(rs.getString("text"));
				dto.setIdx(rs.getString("idx"));
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
	
	public boardlistDto getBoardByIdx(String idx) {
	    boardlistDto dto = null;
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "select * from shop.boardlist where idx=?";
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, idx);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            dto = new boardlistDto();
	            dto.setIdx(rs.getString("idx"));
	            dto.setTitle(rs.getString("title"));
	            dto.setText(rs.getString("text"));
	            dto.setType(rs.getString("type"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }
	    return dto;
	}
	//update
	public void updateBoardList(boardlistDto dto)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="update shop.boardlist set title=? , text=? where idx=?";
	
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getText());
			pstmt.setString(3, dto.getIdx());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}db.dbClose(pstmt, conn);
		
	}
	
	//delete
	public void deleteBoardList(String idx)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from shop.boardlist where idx=?";
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
