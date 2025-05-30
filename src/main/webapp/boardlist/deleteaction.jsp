<%@page import="data.dao.boardlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
%>
    <script>
        alert("관리자만 삭제할 수 있습니다.");
        window.close();
    </script>
<%
        return;
    }
%>
<%
    request.setCharacterEncoding("utf-8");
    String idx= request.getParameter("idx");
    
    boardlistDao dao=new boardlistDao();
    dao.deleteBoardList(idx);
%> 