<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nanum+Myeongjo&family=Sunflower:wght@300&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <title>결제하기</title>
    <link rel="stylesheet" href="payment.css">
<style type="text/css">
	/* 전역 스타일 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', sans-serif;
    line-height: 1.6;
    color: #333;
}

/* 헤더 스타일 */
header {
    width: 100%;
}

.top-header {
    background-color: #fff;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
}

.left-section {
    display: flex;
    align-items: center;
    gap: 20px;
}

.slide-menu-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px;
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.slide-menu-btn span {
    display: block;
    width: 20px;
    height: 2px;
    background-color: #333;
}

.shop-name {
    font-size: 1.5rem;
    font-weight: bold;
    cursor: pointer;
}

.user-menu {
    display: flex;
    gap: 20px;
    align-items: center;
}

.user-menu a {
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
}

.user-info {
    font-size: 0.9rem;
}

.main-menu {
    background-color: #fff;
    padding: 10px 20px;
    display: flex;
    justify-content: center;
    gap: 40px;
    border-bottom: 1px solid #eee;
}

.main-menu a {
    text-decoration: none;
    color: #333;
    font-weight: 500;
}

/* 주문 섹션 스타일 */
.order-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
}

.order-section h2 {
    font-size: 30px;
    margin-bottom: 20px;
}

.order-list {
    border: 1px solid #eee;
    padding: 20px;
    min-height: 200px;
}

/* 주문자 정보 섹션 스타일 */
.customer-info-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
    display: flex;
    gap: 20px;
}

.info-container {
    flex: 1;
}

.customer-form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.form-group {
    display: flex;
    gap: 10px;
}

.form-group input,
.form-group textarea {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.address-search-btn {
    padding: 10px 20px;
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}

.message-box textarea {
    width: 100%;
    resize: none;
}

.ad-container {
    width: 200px;
}

.ad-space {
    width: 100%;
    height: 320px;
    background-color: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #ddd;
}

/* 결제 섹션 스타일 */
.payment-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
}

.payment-container {
    border: 1px solid #eee;
    padding: 20px;
}

.payment-methods {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.payment-method-btn {
    padding: 10px 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}

.payment-method-btn:hover {
    background-color: #f8f8f8;
}

.payment-details {
    min-height: 100px;
    margin-bottom: 20px;
}

.payment-submit-btn {
    display: block;
    width: 200px;
    padding: 15px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-left: auto;
}

.payment-submit-btn:hover {
    background-color: #444;
}
</style>
<script type="text/javascript">
	$(function(){
		/* 주문자정보 감추기 */
		/* $(".customer-form").hide(); */
		/* 결제정보 감추기 */
		 $(".form-select").change(function(){
	            var m = $(".form-select option:selected").text();
	            if(m==="직접 입력"){
	            	alert("hi");
	            }
	        });
    
	});
</script>
<%
   //프로젝트 경로구해기
   String root=request.getContextPath();
%>
</head>
<body>
    <!-- 헤더 영역 -->
    <header>
        <div class="top-header">
            <div class="left-section">
                <button class="slide-menu-btn">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
                <h1 class="shop-name">
                <img src="<%=root%>/SemiImg/mainLogo.png" class="y_mainlogo" 
                	style="width: 150px;">
				</h1>
            </div>
            <div class="right-section">
                <nav class="user-menu">
                    <a href="#">매장찾기</a>
                    <a href="#">고객센터</a>
                    <span class="user-info">이름(아이디)님</span>
                    <a href="#">장바구니</a>
                    <a href="#">마이페이지</a>
                    <a href="#">로그아웃</a>
                </nav>
            </div>
        </div>
        
    </header>

    <!-- 주문 섹션 -->
    <section class="order-section">
        <h2>주문목록</h2>
        <div class="order-list">
            <!-- 주문 상품 목록이 여기에 들어갑니다 -->
        </div>
    </section>

    <!-- 주문자 정보 섹션 -->
    <section class="customer-info-section">
        <div class="info-container">
            <h2 class="orderer">주문자 정보</h2>
            <form class="customer-form">
                <div class="form-group">
                    <input type="text" placeholder="주문자명">
                </div>
                <div class="form-group">
                    <input type="tel" placeholder="번호">
                </div>
                <div class="form-group address-group">
                    <input type="text" placeholder="주소" readonly>
                    <button type="button" class="address-search-btn">주소찾기</button>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="상세주소">
                </div>
                <div class="form-group">
                    <input type="email" placeholder="이메일">
                </div>
                <div class="form-group">
                	<span>배송 전 메세지</span>
                </div>
                <div class="form-group">
                    <select class="form-select">
                    	<option class="msg" id="message1">부재 시 경비실에 맡겨주세요.</option>
                    	<option class="msg" id="message2">문 앞에 놔두고 가세요.</option>
                    	<option class="msg" id="message3">배송 전 연락주세요.</option>
                    	<option class="msg" id="message4">직접 입력</option>
                    </select>
                    
                    <input type="text">
                </div>
                
                		
                <div class="form-group message-box" id="custom-message" style="display: none;"
                	>
                    <textarea rows="3" placeholder="메세지 입력"></textarea>
                </div>
            </form>
        </div>
        <div class="ad-container">
            <div class="ad-space">광고</div>
        </div>
    </section>

    <!-- 결제 섹션 -->
    <section class="payment-section">
        <h2>결제</h2>
        <div class="payment-container">
            <div class="payment-methods">
                <button class="payment-method-btn">카드결제</button>
                <button class="payment-method-btn">네이버페이</button>
                <button class="payment-method-btn">카카오페이</button>
            </div>
            <div class="payment-details">
                <!-- 결제 상세 정보가 여기에 들어갑니다 -->
            </div>
            <button class="payment-submit-btn">결제요청</button>
        </div>
    </section>
</body>
</html> 