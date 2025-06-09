<%@page import="data.dto.MemberDto"%>
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
<body>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String cbsave=request.getParameter("savechk");
	
	/* 리다이렉트 */
	String redirectPage = request.getParameter("redirect");
	if (redirectPage == null || redirectPage.trim().equals("")) {
	    redirectPage = "../index.jsp"; // 기본값
	}
	
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.loginmember(id, pass);
	String name = dao.getName(id);
	
	if(dao.login(id, pass)==true){
		session.setMaxInactiveInterval(60*60*8); //8시간,생략시 30분
		
		session.setAttribute("loginok", "yes");
		session.setAttribute("num", dto.getNum());
		session.setAttribute("myid", id);
		session.setAttribute("name", name);
		session.setAttribute("email", dto.getEmail());
		session.setAttribute("hp", dto.getHp());
		session.setAttribute("birth", dto.getBirth());
		session.setAttribute("saveok", cbsave==null?null:"yes");
		if(dto.getRole().equals("admin")){
			session.setAttribute("role", "admin");
		}else{
			session.setAttribute("role", "user");
		}

		response.sendRedirect(redirectPage);
	} else {
	    // 로그인 실패 시 메시지와 함께 로그인폼으로 이동
	    out.println("<script>");
	    out.println("alert('아이디 또는 비밀번호를 다시 확인해주세요');");
	    out.println("history.back();");  // 이전 페이지로 돌아가기
	    out.println("</script>");
	}
	
	%>
</body>
</html>