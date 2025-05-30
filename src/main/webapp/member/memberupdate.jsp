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
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");
	String pass=request.getParameter("pass");
	String email=request.getParameter("email1")+"@"+request.getParameter("email2");
	String birth = request.getParameter("birth-year") + "-" + request.getParameter("birth-month") + "-" + request.getParameter("birth-date");
	
	MemberDto dto = new MemberDto();
	
	dto.setPass(pass);
	dto.setEmail(email);
	dto.setBirth(birth);
	
	MemberDao dao = new MemberDao();
	
	dao.updatemember(num, dto);
%>
<script type="text/javascript">
	alert("회원 정보가 성공적으로 수정되었습니다.");
	location.href = "../index.jsp?main=member/mypage.jsp"; 
</script>
</body>
</html>