
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<%
  String id=request.getParameter("id");
  MemberDao dao=new MemberDao();
  String name=dao.getName(id);
%>
<body>
<div style="margin: 200px 200px;">
   <img alt="" src="image/avata/b7.png"><br>
   <b><%=name %>님의 회원가입을 축하합니다</b>
   <br><br>
   <button type="button" class="btn btn-success"onclick="location.href='index.jsp?main=login/loginform.jsp'">로그인</button>
   <button type="button" class="btn btn-success" onclick="location.href='index.jsp'">메인</button>
</div>
</body>
</html>