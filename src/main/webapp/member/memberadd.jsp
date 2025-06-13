<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.MemberDto"%>
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
   
   request.setCharacterEncoding("utf-8");
   
   //데이타 읽어서 dto넣기
   MemberDto dto=new MemberDto();
   String id=request.getParameter("id");
   String name=request.getParameter("name");
   String pass=request.getParameter("pass");
   String hp = request.getParameter("hp");
   String birth = request.getParameter("birth-year") + "-" + request.getParameter("birth-month") + "-" + request.getParameter("birth-date");
   String email=request.getParameter("email1")+"@"+request.getParameter("email2");
   
   dto.setId(id);
   dto.setName(name);
   dto.setPass(pass);
   dto.setHp(hp);
   dto.setBirth(birth);
   dto.setEmail(email);
   
   //dao_insert
   MemberDao dao=new MemberDao();
   dao.insertMember(dto);
  
   //가입성공페이지로 이동 %>
   <script>
   		alert("<%=name%>님의 " + "회원가입을 환영합니다.");
   		location.href = "../index.jsp";
   </script>
<body>

</body>
</html>