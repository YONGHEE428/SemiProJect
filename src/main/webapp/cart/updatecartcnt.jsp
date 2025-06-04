
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="db.copy.DBConnect"%>

<%
    request.setCharacterEncoding("UTF-8");
    String idx = request.getParameter("idx");
    String cnt = request.getParameter("cnt");

    DBConnect db = new DBConnect();
    String sql = "UPDATE cartlist SET cnt = ? WHERE idx = ?";

    try (Connection conn = db.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, Integer.parseInt(cnt));
        pstmt.setInt(2, Integer.parseInt(idx));
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
