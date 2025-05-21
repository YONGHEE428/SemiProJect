<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
   //프로젝트 경로구해기
   String root=request.getContextPath();
%>
<body>
   <a href="<%=root%>/">메인(홈)</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">로그인</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">회원가입</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">방명록</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">Q&A</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">고객게시판</a>&nbsp;&nbsp;&nbsp;
   <a href="<%=root%>/">Shop</a>&nbsp;&nbsp;&nbsp;
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="csstransforms no-csstransforms3d csstransitions"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<%
	
   //프로젝트 경로구해기
   String root=request.getContextPath();
%>
	<link rel="stylesheet" type="text/css" href="<%=root%>/menu/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/menu/css/menu.css?v=20240520">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<script type="text/javascript" src="<%=root %>/menu/js/jquery.js"></script>
	<script type="text/javascript" src="<%=root %>/menu/js/function.js"></script>
</head>
<script type="text/javascript">
	function logout(){
	alert("로그아웃 하셨습니다.");
	location.href = "login/logoutform.jsp";
	}

</script>
<body>

<div id="wrap">
	<header>
		<div class="inner relative">
			<div class="logoimg">
			<a href="<%=root%>/"><img src="<%=root%>/SemiImg/mainLogo.png" class="logo"></a>
			<div class="search">
			<input type="text" id="query" class="form-control textbox" name="" value="" placeholder="상품 검색">
			<i class="bi bi-search" onclick="submit"></i>
			</div>
			</div>
			<nav id="navigation">
				<ul id="main-menu">
					<li class="current-menu-item"><a href="<%=root%>/">Home</a></li>
					<li><a href="index.jsp?main=guest/guestform.jsp">방문인사</a></li>
					<li class="parent">
						<a href="#">게시판</a>
						<ul class="sub-menu">
							<li><a href="#">Q&A 게시판</a></li>
							<li><a href="<%=root%>/board/boardlist.jsp">고객게시판</a></li>
							<li><a href="#">Smart게시판</a></li>
						</ul>
					</li>
					<li><a href="<%=root%>/shop/shoplist.jsp">Shop</a></li>
							<%
							String loginok = (String)session.getAttribute("loginok");
						  	String name = (String)session.getAttribute("name");
							String role = (String)session.getAttribute("role");
							if(loginok == null){ %>
							<li><a href="index.jsp?main=member/memberform.jsp">회원가입</a></li>
							<%} %>
					<li>
					  <%
					    if(loginok != null && loginok.equals("yes")) {
					  %>
					  <a href="#"><%=name%>님 어서오세요!</a>
						<ul class="sub-menu">
						<%if(role !=null && role.equals("user")){%>
							<li><a href="index.jsp?main=member/mypage.jsp">마이페이지</a></li>
						<%}if(role !=null && role.equals("admin")){%>
							<li><a href="index.jsp?main=member/memberlist.jsp">회원목록</a></li>
						<%}%>
							<li><a href="#" onclick="logout()">로그아웃</a></li>
						</ul>
					  <%
					    } else {
					  %>
					    <a href="index.jsp?main=login/loginform.jsp">로그인</a>
					  <%
					    }
					  %>
					</li>
				</ul>
			</nav>
			<div class="clear"></div>
		</div>
	</header>	
</div>    
</body></html>