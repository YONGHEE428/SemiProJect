package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.xdevapi.Result;

import data.dto.ProductDto;
import data.dto.WishListDto;
import db.copy.DBConnect;

public class WishListDao {
	DBConnect db= new DBConnect();
	
	public boolean insertWishList(int memberId,int productId) {
	Connection conn=db.getConnection();
	PreparedStatement pstmt=null;
	boolean result=false;
	
	String sql="insert into wishlist values(null,?,?)";
	try {
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, memberId);
		pstmt.setInt(2, productId);
		
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
	
	public List<WishListDto> getWishList(int memberId) {
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<WishListDto> list = new ArrayList<WishListDto>();
	    
	    String sql = "SELECT w.num, p.product_id, p.product_name, p.price, p.main_image_url, p.category "
	               + "FROM wishlist w "
	               + "JOIN product p ON w.product_id = p.product_id "
	               + "WHERE w.member_id = ?";
	    
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, memberId);
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            WishListDto wdto = new WishListDto();  // WishListDto 객체를 생성
	            ProductDto pdto = new ProductDto();  // ProductDto 객체를 생성
	            
	            wdto.setNum(rs.getString("num"));  // 위시리스트 항목의 num 값을 설정
	            wdto.setProductId(rs.getInt("product_id"));  // 상품 ID 값을 설정
	            
	            // ProductDto의 필드 값 설정
	            pdto.setProductId(rs.getInt("product_id"));
	            pdto.setProductName(rs.getString("product_name"));
	            pdto.setPrice(rs.getBigDecimal("price"));
	            pdto.setMainImageUrl(rs.getString("main_image_url"));
	            pdto.setCategory(rs.getString("category"));
	            wdto.setProduct(pdto);  // WishListDto에 ProductDto 객체 설정
	            
	            list.add(wdto);  // WishListDto 객체를 리스트에 추가
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }
	    return list;
	}
	public boolean deleteWishList(int num) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		boolean result=false;
		
		String sql="delete from wishlist where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			int rowsAffected=pstmt.executeUpdate();
			if(rowsAffected>0) {
				result=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		return result;
	}
}
