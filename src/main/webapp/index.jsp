<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style>
  html, body {
    height: 100%;
    margin: 0;
    font-family: 'Nanum Myeongjo';
  }

  .wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }

  .backimg {
  display: none;  /* 기본 숨김 */
  /* 기존 스타일 */
  position: fixed;
  width: 100%;
  height: 954px;
  z-index: 1000;
  transition: opacity 0.5s ease;
  opacity: 1;
}
  .backimg > span{
  	position: fixed;
	width:100%;
	height:100%;
  	color: white;
  	z-index:1000;
  	
  	 display: flex;
  	 flex-direction: column;
  	justify-content: center; /* 가로 중앙 */
  	align-items: center;     /* 세로 중앙 */
  	font-size: 2rem;         
  	text-align: center;
  }
  .backimg img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    cursor: pointer;
  }

  .title {
    position: fixed;
    width: 100%;
    height: 100px;
    background-color: black;
    z-index: 999;
  }

  .menu {
    position: fixed;
    top: 50px; /* 기본 위치 */
    width: 100%;
    height: 100px;
    background-color: white;
    z-index: 999;
    text-align: center;
    font-size: 20pt;
    line-height: 80px;
    transition: top 0.3s ease;
  }

  .main {
    flex: 1;
    margin-top: 130px; /* 콘텐츠 아래로 밀기 */
    padding: 20px 0;
    font-size: 12pt;
    background-color: white;
    z-index: 997;
  }

  .info {
    width: 100%;
    height: 300px;
    line-height: 30px;
    font-size: 13pt;
    text-align: center;
    background-color: white;
    margin-top: 50px;
    z-index: 996;
  }

  a, a:hover {
    color: black;
    text-decoration: none;
  }
</style>

<script>

window.addEventListener("DOMContentLoaded", function () {
	  const backimg = document.querySelector(".backimg");

	  if (sessionStorage.getItem("backimgHidden") === "true") {
	    // 숨김 상태이면 계속 숨김
	    backimg.style.display = "none";
	  } else {
	    // 숨김 상태가 아니면 보이게 함
	    backimg.style.display = "block";
	  }

	  backimg.addEventListener("click", function () {
	    backimg.style.opacity = "0";
	    backimg.style.pointerEvents = "none";
	    // 투명해지는 transition 후 display:none으로 숨기기
	    setTimeout(() => {
	      backimg.style.display = "none";
	    }, 500);  // transition 시간과 맞춤
	    sessionStorage.setItem("backimgHidden", "true");
	  });
	});

  window.addEventListener("scroll", function () {
    const menu = document.querySelector(".menu");
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

    if (scrollTop > 50) {
      menu.style.top = "0";
    } else {
      menu.style.top = "50px";
    }
  });
  
</script>
</head>

<%
  String mainPage = "layout/main.jsp"; 
  if (request.getParameter("main") != null) {
    mainPage = request.getParameter("main");
  }
%>

<body>
  <div class="wrapper">
   <!--  <div class="backimg">
    	<video autoplay muted loop playsinline style="width: 100%;">
  		<source src="SemiImg/ADmain.mp4" type="video/mp4">
  		브라우저가 비디오 태그를 지원하지 않습니다.
		</video>
    </div> -->

    <div class="title">
      <jsp:include page="layout/title.jsp" />
    </div>

    <div class="menu">
      <jsp:include page="layout/menu.jsp" />
    </div>

    <div class="main">
      <jsp:include page="<%= mainPage %>" />
    </div>

    <div class="info">
      <jsp:include page="layout/bottominfo.jsp" />
    </div>
  </div>
</body>
</html>
