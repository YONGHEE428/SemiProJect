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
<script>
  window.addEventListener("scroll", function () {
    const menu = document.querySelector(".menu");
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

    if (scrollTop > 50) {
      // 스크롤이 50px 넘으면 menu를 맨 위로 올림
      menu.style.top = "0";
    } else {
      // 그 전까진 title 밑에 위치
      menu.style.top = "50px";
    }
  });
</script>
<style>
  html, body {
    height: 100%;
    margin: 0;
  }

  body {
    font-family: 'Nanum Myeongjo';
  }

  .wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }
  .title{
  	position: fixed;
  	width: 100%;
  	height: 100px;
  	background-color: black;
  	z-index: 999;
  }
  .menu {
  position: fixed;
  top: 50px; /* 처음엔 title 밑에 위치 */
  width: 100%;
  height: 100px;
  background-color: white;
  z-index: 999;
  text-align: center;
  font-size: 20pt;
  line-height: 80px;
  transition: top 0.3s ease; /* 부드럽게 이동 */
  
}
  .main {
    flex: 1;
    margin-top: 150px; /* 메뉴 높이만큼 띄움 */
    padding: 20 0px;
    font-size: 12pt;
    background-color: white;
  }

  .info {
    width: 100%;
    height: 300px;
    line-height: 30px;
    font-size: 13pt;
	text-align:center;
    background-color: white;
    margin-top: 50px;
  }

  a, a:hover {
    color: black;
    text-decoration: none;
  }

</style>

</head>
<%
   String mainPage = "layout/main.jsp"; 
   if(request.getParameter("main") != null) {
     mainPage = request.getParameter("main");
   }
%>
<body>
  <div class="wrapper">
	<div class="title">
		<jsp:include page="layout/title.jsp"/>
  	</div>
    <div class="menu">
      <jsp:include page="layout/menu.jsp"/>
    </div>

    <div class="main">
      <jsp:include page="<%=mainPage %>"/>
    </div>

    <div class="info">
      <jsp:include page="layout/bottominfo.jsp"/>
    </div>

</body>
</html>
