package db.copy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnect {

	static final String URL = "jdbc:mysql://shop.c9a8cage4o0m.ap-northeast-2.rds.amazonaws.com:3306/shop?serverTimezone=Asia/Seoul";
	static final String MySqlDriver = "com.mysql.cj.jdbc.Driver";
	
	//오라클 계정 연결 메서드
	public Connection getConnection() {
		
		Connection cn = null;
		
		try {
			Class.forName(MySqlDriver);
			cn = DriverManager.getConnection(URL, "admindyd", "dydgml428!");
			
			Statement stmt = cn.createStatement();
	        stmt.execute("SET time_zone = 'Asia/Seoul'");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("mysql 연결 실패" + e.getMessage());
		}
		
		return cn;
	}
	
	//오라클 계정 닫는 메서드 총4개
	public void dbClose(ResultSet rs , Statement st, Connection cn) { //select , insert,create,update
		try {
			if(rs!=null)rs.close();
			if(st!=null)st.close();
			if(cn!=null)cn.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	public void dbClose(Statement st, Connection cn) { //insert,create, update
		try {
			if(st!=null)st.close();
			if(cn!=null)cn.close();
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
	}
	public void dbClose(ResultSet rs , PreparedStatement pst, Connection cn) { // insert,update, select, create
		try {
			if(rs!=null)rs.close();
			if(pst!=null)pst.close();
			if(cn!=null)cn.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	public void dbClose(PreparedStatement pst, Connection cn) { // insert, create , update
		try {
			if(pst!=null)pst.close();
			if(cn!=null)cn.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
