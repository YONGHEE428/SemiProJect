<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<body>
 <% request.setCharacterEncoding("UTF-8");
 	String pass = request.getParameter("pass");
 	String num = request.getParameter("num");

 	
 	MemberDao dao = new MemberDao();
	boolean passcheck = dao.isEqualPass(num, pass);
	
	if(passcheck==true){
		response.sendRedirect("../index.jsp?main=member/updateform.jsp?num="+num);
	} else {
        // 비밀번호 틀림 → 다시 마이페이지로 리다이렉트 + 메시지
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
</script>
<%
    }
%>
 
</body>
</html>