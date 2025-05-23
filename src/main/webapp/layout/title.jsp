<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.title-main{
		width:100%;
		height:100%;
		background-color: black;
		display:flex;
		justify-content: center;
	}
	.marquee-content >a> p{
		font-family: "Jua";
		margin-top:12px;
		color : white;
		font-size:1.2em;
		z-index:999;
	}
	.marquee {
	  width: 100%;
	  overflow: hidden;
	  white-space: nowrap;
	  box-sizing: border-box;
	}

	.marquee-content {
	  display: inline-block;
	  padding-left: 5%;
	  animation: scroll-left 25s linear infinite;
	}
	@keyframes scroll-left {
	  	0% {
	    	transform: translateX(0px); /* 오른쪽 밖에서 시작 */
	  	}
	  	100% {
	    	transform: translateX(-50%); /* 왼쪽 밖으로 사라짐 */
  	}
}
</style>
</head>
<%
   //프로젝트 경로구해기
   String root=request.getContextPath();
%>
<body>
<div class="title-main">
	<div class="marquee">
	  <div class="marquee-content">
	   <a href="index.jsp?main=member/memberform.jsp"><p>회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;
	   회원가입시 첫 구매 20%할인 쿠폰 증정 #즉시사용 가능 #중복할인 불가 &nbsp;&nbsp;&nbsp;;</p></a>
	  </div>
	</div>
</div>
</body>
</html>