<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="csstransforms no-csstransforms3d csstransitions"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<%//프로젝트 경로구하기 
 
   String root=request.getContextPath();
%>
	<link rel="stylesheet" type="text/css" href="<%=root%>/menu/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/menu/css/menu.css?v=20240610">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<script type="text/javascript" src="<%=root %>/menu/js/jquery.js"></script>
	<script type="text/javascript" src="<%=root %>/menu/js/function.js"></script>
</head>
<script type="text/javascript">
	function logout(){
	alert("로그아웃 하셨습니다.");
	location.href = "login/logoutform.jsp";
	}
	
	
	$(function(){
		$(".searchpage").hide();
		const originalText = $("#logouting span").text(); // 원래 텍스트 저장
		
		  $("#searchbar").click(function() {
			  $(".overlay").fadeIn();
			  $(".searchpage").fadeIn();
			  $("body").css("overflow", "hidden");
			});
		  	$("#logouting").click(function(){
				console.log($(this).text());
				if($(this).text().trim() == "관리자님"){
					alert("로그아웃 하셨습니다.");
					location.href = "login/logoutform.jsp";
				}
		  	});
			// 배경 클릭 시 닫기
			$(".overlay").click(function() {
			  $(".overlay").fadeOut();
			  $(".searchpage").fadeOut();
			  $("body").css("overflow", "auto"); // 스크롤 복원
			});

			// 닫기 버튼 클릭 시 닫기
			$(".close-btn").click(function() {
			  $(".overlay").fadeOut();
			  $(".searchpage").fadeOut();
			  $("body").css("overflow", "auto"); // 스크롤 복원
			});

			// ESC 키 누르면 닫기
			$(document).on("keydown", function(e) {
			  if (e.key === "Escape") {
			    $(".overlay").fadeOut();
			    $(".searchpage").fadeOut();
			    $("body").css("overflow", "auto"); // 스크롤 복원
			  }
			});
			$(".logo").click(function(){
				sessionStorage.setItem("backimgHidden", "false");
			})
			
			$("#input-search").keypress(function(e) {
				if (e.which === 13) { // 엔터키가 눌렸을 때
					e.preventDefault();
					let searchText = $(this).val();
					if(searchText.trim() !== "") {
						location.href = "<%=root%>/index.jsp?main=search/searchResult.jsp&keyword=" + encodeURIComponent(searchText);
					}
				}
			});
			
	});
	
	
</script>
<body>
<div id="wrap">
	<header>
		<div class="inner relative">
			<div class="logoimg">
			<a href="<%=root%>/"><img src="<%=root%>/SemiImg/mainLogo.png" class="logo"></a>
			<div class="search">
			<input type="text" id="searchbar" class="form-control textbox" name="" value="" placeholder="상품 검색" readonly style="cursor: pointer;">
			<i class="bi bi-search" onclick="submit"></i>
			
			</div>
			</div>
			<nav id="navigation">
				<ul id="main-menu">
					<li class="current-menu-item"><a href="<%=root%>/">Home</a></li>
					<li><a href="index.jsp?main=boardlist/boardlist.jsp">고객센터</a></li>
					<li><a href="index.jsp?main=category/category.jsp">Shop</a></li>
					<%
					String loginok = (String)session.getAttribute("loginok");
					String name = (String)session.getAttribute("name");
					String role = (String)session.getAttribute("role");
					if(loginok == null){ %>
						<li><a href="index.jsp?main=member/memberform.jsp">회원가입</a></li>
					<%}else{ %>
						<%if(role !=null && role.equals("user")){%>
							<li><a href="index.jsp?main=member/mypage.jsp">마이페이지</a></li>
							
					<%}if(role !=null && role.equals("admin")){%>
							<li><a href="sangpumRegist/adminMain.jsp" target="_blank">매장관리</a>
					<%} 
					}%>
					<li>
					  <%
					    if(loginok != null && loginok.equals("yes")) {
					  %>
					  <a href="#" id="logouting"><span><%=name%>님</span></a>
						<!-- <ul class="sub-menu">
						
							<li><a href="#" onclick="logout()">로그아웃</a></li>
						</ul> -->
					  <%
					    } else {
					  %>
					  <%
					  	
						    String currentURL = request.getRequestURI(); //현재 위치
						    String query = request.getQueryString(); // ? 뒤에 붙는 파라미터 문자열 전체
						    if (query != null) {
						        currentURL += "?" + query;
						    }
					  %>  
					    <a href="<%=root%>/index.jsp?main=login/loginform.jsp&redirect=<%=currentURL %>">로그인</a>
																			<!-- redirect 파라미터값 전달 -->
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
<!-- 배경 어둡게 -->
<div class="overlay"></div>

<!-- 검색창 팝업 -->
<div class="searchpage">
  <button class="close-btn" style="margin-top: -3px; margin-right: 3px;"><i class="bi bi-x-lg" style="font-size: 25px;"></i></button>
  <input type="text" class="form-control" id="input-search" placeholder="예: 가방, 신발 등" style="width: 95%;">
  <div class="search-title">
  <label style="font-size: 0.8em;"><strong>인기 검색어</strong></label>
  </div>
  <div class="search-content">
  	<div class="search-content-item">
  		<ol>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=반팔"><strong>1 &nbsp;&nbsp;반팔</strong><span class="arrow" style="color: #E0E0E0;">▬</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=버뮤다팬츠"><strong>2 &nbsp;&nbsp;버뮤다팬츠</strong><span class="arrow" style="color: #E0E0E0;">▬</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=모자"><strong>3 &nbsp;&nbsp;모자</strong><span class="arrow" style="color: red;">▲</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=샌들"><strong>4 &nbsp;&nbsp;샌들</strong><span class="arrow" style="color: blue;">▼</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=반바지"><strong>5 &nbsp;&nbsp;반바지</strong><span class="arrow" style="color: #E0E0E0;">▬</span></a></li>
  		</ol>
  		<ol>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=바람막이"><strong>6 &nbsp;&nbsp;바람막이</strong><span class="arrow" style="color: #E0E0E0;">▬</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=아디다스"><strong>7 &nbsp;&nbsp;아디다스</strong><span class="arrow" style="color: red;">▲</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=청바지"><strong>8 &nbsp;&nbsp;청바지</strong><span class="arrow" style="color: red;">▲</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=트레이닝바지"><strong>9 &nbsp;&nbsp;트레이닝바지</strong><span class="arrow" style="color: blue;">▼</span></a></li>
  		<li><a href="index.jsp?main=search/searchResult.jsp&keyword=레인부츠"><strong>10 &nbsp;&nbsp;레인부츠</strong><span class="arrow" style="color: blue;">▼</span></a></li>
  		</ol>
  	</div>
  </div>
  <div class="search-Ad">
	<%if(loginok != null && loginok.equals("yes")){ %>
		<a href="index.jsp?main=category/category.jsp"><img src="<%=root%>/SemiImg/SScoupon2.jpg"></a>
	<%}else{ %>
  		<a href="index.jsp?main=member/memberform.jsp"><img src="<%=root%>/SemiImg/coupon_b.png"></a>
  	<%} %>
  </div>
</div>

</body>
<style>
	.search-content{
		padding: 0 50px 0 20px;
		width: 100%;
		height: 40%;
		
	}
	.search-content-item{
		font-size: 0.5em;
		 display: flex;
 		 gap: 10px; 
	}
	.search-content-item >ol{
		width: 200px;

			
	}
	.search-content-item > ol >li{
	display: flex;
    align-items: left;
    height: 2.25rem;
    font-size: .75rem;
    line-height: 1rem;
    letter-spacing: -.0125rem;
    font-weight: 350;
    color: #000;
    width: 200px;
	}
	.search-content-item a {
	  position: relative;
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  width: 100%;
	  padding-right: 10px;
	}
	
	.search-content-item .arrow {
	  position: static;
	  margin-left: auto;
	}
	
	li > a:hover{
	text-decoration: none;
	}
	.search-title{
	width: 100%;
	height: 100px;
	line-height: 100px;}
	.search-Ad{
		padding:20px 30px 0px 30px;
		width: 100%;
		height: 150px;
	}
	.search-Ad > a >img{
	border: 0.5px solid #f2f2f2;
	width: 100%;
	height: 100px;
	}

</style>
</html>