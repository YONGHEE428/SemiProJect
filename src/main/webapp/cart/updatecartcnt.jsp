<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="db.copy.DBConnect"%>

<%
	
    request.setCharacterEncoding("UTF-8");
    String idx = request.getParameter("idx");
    String cnt = request.getParameter("cnt");
    System.out.println("idx: " + idx + ", cnt: " + cnt); // ★ 로그 찍기

    DBConnect db = new DBConnect();
    String sql = "UPDATE shop.cartlist SET cnt = ? WHERE idx = ?";

    try (Connection conn = db.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, Integer.parseInt(cnt));
        pstmt.setInt(2, Integer.parseInt(idx));
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.print("OK"); // 성공 시
        } else {
            response.setStatus(500); // 실패 시 error 콜백
            out.print("fail");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500); // 에러 콜백
        out.print("fail");
    }
%>

