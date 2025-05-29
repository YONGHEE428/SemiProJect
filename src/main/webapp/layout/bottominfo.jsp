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
<style >
	.main-footer{
		padding: 0 220px;
	}
	.footer-border{
		border-top: 1px solid gray;
		width: 100%;
		height: 50px;
	}
	.footer-menu{
		display:flex;
		justify-content: center;
		width:100%;
		height: 50px;
		text-align: center;
		gap:20px;
		font-weight: bold;
		font-size:0.8em;
	}
	a{
		color : black;
		text-decoration: none;
		
	}
	a:hover{
		text-decoration: underline;
	}
	.footer-content{
		color:gray;
		font-size:0.8em;
	}
	p > b{
		color : #595959;
	}
	.footerlogo{
		width: 100px;
		height: 50px;
		filter: grayscale(100%);
</style>
<script type="text/javascript">

	function openTermsWindow() {
	    window.open(
	        'footer-category/TermsOfService.jsp',       // 새로 열릴 페이지
	        '이용약관',               // 창 이름
	        'width=600,height=500,top=100,left=200,resizable=yes,scrollbars=yes'
	    );
	}
	function openPrivacy(){
		window.open(
			'footer-category/Privacy.jsp',
			'개인정보방침',
			'width=600,height=500,top=100,left=200,resizable=yes,scrollbars=yes'
		)
		
	}

</script>
</head>
<body>
<footer class="main-footer">
<div class="footer-border"></div>
<div class="footer-body">
	<ul class="footer-menu">
   		<li><a class="Footer-link" href="#" rel="noopener noreferrer" onclick="openTermsWindow()"><b>이용약관</b></a></li>
		<li><a class="Footer-link" href="#" rel="noopener noreferrer" onclick="openPrivacy()">개인정보방침</a></li>
		<li><a class="Footer-link" href="#" rel="noopener noreferrer" target="_blank">회사소개</a></li>		
		<li><a class="Footer-link" href="index.jsp?main=footer-category/Guide.jsp">이용안내</a></li>
  </ul>
<div class="footer-content">
	<p><b>(주)쌍용빈티지·대표이사</b> 김쌍용 / <b>소재지</b> 서울특별시 강남구 테헤란로 132 8층 / <b>사업자 등록번호</b> 000-00-0000 / <b>고객센터</b> 000-1111-1111 / <b>이메일</b> ssangyong@gmail.com</p>
	<p>© 2025 Team 1, Room 4, SsangYong Education Center — Created for development purposes only. No copyright claimed.</p>
	
	<%String root=request.getContextPath();%>
	<a href=<%=root %>><img src = "<%=root%>/SemiImg/mainLogo2.png" alt="XX" class="footerlogo"></a>
	
</div>
</div>
</footer>
</body>
</html>