<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위시리스트</title>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
    body {
        background-color: #f8f9fa;
    }
    
    .wishlist-header {
        background-color: white;
        padding: 20px 0;
        margin-bottom: 30px;
        border-bottom: 1px solid #e5e5e5;
    }
    
    .wishlist-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin: 0;
        padding: 0 20px;
        background-color: 
    }
    
    .breadcrumb {
        font-size: 14px;
        color: #666;
        margin: 10px 20px 0;
    }
    
    .product-container {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        margin: 20px;
        padding: 20px;
    }
     .product-type {
        display: grid;
        grid-template-columns: 120px 2fr 1fr 1fr 150px;
        padding: 15px;
        background-color: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
        font-weight: bold;
        color: #495057;
        margin-bottom: 10px;
        font-size: 14px;
        border-radius: 4px;
    }
      .product-type-item {
        text-align: center;
        padding: 0 10px;
    }
    .product-type-item:first-child {
        flex: 0 0 120px;
    }
    
    .product-type-item:last-child {
        flex: 0 0 150px;
    }
    #product-list {
        border: 1px solid #dee2e6;
        border-radius: 4px;
    }
    .product-row {
        display: grid;
        grid-template-columns: 120px 2fr 1fr 1fr 150px;
        align-items: center;
        padding: 15px;
        border-bottom: 1px solid #eee;
        transition: all 0.3s ease;
    }
    
      .product-image {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 4px;
    }
    
  .product-info {
        text-align: left;
        padding: 0 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .product-company {
        color: #000;
        font-size: 14px;
        margin-bottom: 5px;
    }
    
     .product-name {
        font-size: 16px;
        font-weight: 500;
        margin-bottom: 5px;
    }
    
    .product-price {
        font-size: 16px;
        font-weight: bold;
        color: #333;
    }
    
    .product-size,
    .product-color {
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .product-actions {
        display: flex;
        gap: 10px;
    }
    
    .heart {
        font-size: 20px;
        cursor: pointer;
        transition: all 0.2s ease;
    }
    
    .heart:hover {
        transform: scale(1.1);
    }
    
    .heart.bi-suit-heart-fill {
        color: #dc3545;
    }
    
    .empty-wishlist {
        text-align: center;
        padding: 50px 20px;
        color: #666;
    }
    
    .toast-container {
        z-index: 1050;
    }
</style>
</head>
<body>
<%

	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String referer = request.getHeader("referer");
	boolean fromMypage = (referer != null && referer.contains("mypage.jsp")); // 또는 마이페이지의 실제 URL 경로

%>

    <!-- Category Navigation -->
   <!-- 카테고리 -->
<div class="main-category" style="width: 100%; background-color: white; left: 0;">
<div id="selectedCategory" style="text-align:left; font-size: 24px; font-weight: bold; margin-top: 20px;">
   		  <ul style="<%= fromMypage ? "gap:250px; margin-left:-510px;" : "" %>">
   		 <% if(fromMypage) { %>
		    <li style="font-weight: normal; font-size: 15px; color: gray;">
		        <span>홈 > 마이페이지 > <strong>위시리스트</strong></span>
		    </li>
		<% }%>
   		  <li class="dropdown" style="background-color: ; border-radius: 20px;">
            <span class="category-link" style="font-size: 30px; color: black;">
            위시리스트</span>
            <hr>
        </li>
 		</ul>
   </div>
</div>

<!-- 상품 목록 -->
<div class="container">
    <div class="product-container">
        <div class="product-type">
            <div class="product-type-item">이미지</div>
            <div class="product-type-item">기본정보</div>
            <div class="product-type-item">사이즈</div>
            <div class="product-type-item">컬러</div>
            <div class="product-type-item">선택</div>
        </div>
        <div id="product-list">
            <!-- 상품 행 템플릿 -->
            <% for(int i = 0; i < 5; i++) { %>
            <div class="product-row">
                <div class="product-type-item">
                    <img src="SemiImg/footerLogo.png" alt="Product Image" class="product-image">
                </div>
                <div class="product-info product-type-item" style="text-align: center;">
                    <div class="product-company"><b>아우터</b></div>
                    <div class="product-name">상품명</div>
                    <div class="product-price">99,000원</div>
                </div>
                <div class="product-type-item">
                    <span>S, M, L</span>
                </div>
                <div class="product-type-item">
                    <span>블랙, 화이트</span>
                </div>
                <div class="product-type-item">
                    <button class="btn btn-sm btn-outline-dark" style="font-size: 11px; margin-bottom: 15px;">장바구니 추가</button>
                    <button class="btn btn-sm btn-outline-danger" style="font-size: 11px;">위시리스트에서 제거</button>
                </div>
            </div>
            <%}
            %>
        
        <!-- 빈 위시리스트 메시지 -->
        <div class="empty-wishlist" style="display: none;">
            <i class="bi bi-heart" style="font-size: 48px; margin-bottom: 20px;"></i>
            <h4>위시리스트가 비어있습니다</h4>
            <p>마음에 드는 상품을 하트 아이콘을 눌러 추가해보세요!</p>
        </div>
    </div>
</div>
</div>

<div>
    <jsp:include page="controller.jsp"/>
</div>

<div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
<div id="observerTarget"></div>

<script>
$(function () {
    
    
    // 위시리스트 비어있는지 체크
    function checkEmptyWishlist() {
        if ($('.product-row').length === 0) {
            $('.empty-wishlist').fadeIn();
        } else {
            $('.empty-wishlist').fadeOut();
        }
    }
    
    // 초기 체크
    checkEmptyWishlist();
});
</script>
</body>
</html>