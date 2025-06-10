<%@page import="data.dto.WishListDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.WishListDao"%>
<%@page import="data.dao.MemberDao"%>
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
     	    display: flex; /* Flexbox로 가로로 정렬 */
	    justify-content: space-between; /* 항목들 간 간격을 균등하게 배분 */
	    align-items: center; /* 세로로 가운데 정렬 */
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
		
	}
   .product-type-item:first-child {
        flex: 0 0 150px; /* 120px에서 200px로 변경 */
    }

    /* 헤더의 '기본정보' 항목: flex 비율 유지 */
    .product-type-item:nth-child(2) {
        flex: 3 1 60%;
        text-align: center;
    }

    /* 헤더의 '선택' 항목: 고정 너비 150px 유지 */
    .product-type-item:last-child {
        flex: 0 0 150px;
        text-align: center;
    }

    #product-list {
        border: 1px solid #dee2e6;
        border-radius: 4px;
    }
	 .product-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #eee;
    transition: all 0.3s ease;
}

     .product-image {
	    width: 150px; /* 이미지 너비를 더 크게 */
	    height: 150px; /* 이미지 높이를 더 크게 */
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

    	/* 상단바 */
    .mypage-content{
    	height:60px;
    	line-height:60px;
    	top:150px;
    	position:fixed;
		width:100%;
		min-height: 5px;
		font-weight: bold;
		text-align: center;
		background-color: white;
		transition: top 0.3s ease;

	}
	.content-title > ul{
	display: flex;
	justify-content: center;
	gap : 170px;
	}
	.content-title > ul > li >a{
		color:gray;
		text-decoration: none;
	}
	.content-title > ul > li > a:hover{
		color:black;
		border-bottom: 3px solid black;
	}

    /* 상품 줄의 각 항목에 대한 정렬 규칙 추가 */
    .product-row > .product-type-item:first-child {
    flex: 0 0 150px; /* 이미지 크기 고정 */
    display: flex;
    justify-content: center;
    align-items: center;
}


    .product-row > .product-info.product-type-item {
        flex: 3 1 60%; /* 헤더의 두 번째 항목과 동일 */
        text-align: left; /* 텍스트는 왼쪽 정렬 유지 */
    }

    /* 선택(버튼) 영역 정렬 */
.product-row > .product-type-item:last-child {
    flex: 0 0 150px; /* 선택 항목 고정 */
    display: flex;
    justify-content: center;
    align-items: center;
}

</style>
</head>
<body>
<%

	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String referer = request.getHeader("referer");
	String name = (String)session.getAttribute("name");
	boolean fromMypage = (referer != null && referer.contains("mypage.jsp")); // 또는 마이페이지의 실제 URL 경로
	
	MemberDao mdao=new MemberDao();
	int memberId=mdao.getMemberNumById((String)session.getAttribute("myid"));
	WishListDao wdao=new WishListDao();
	
	List<WishListDto> list=wdao.getWishList(memberId);
%>
<div class="mypage-content">
        <div class="content-title">
            <ul>
                <li><a onclick="location.href='index.jsp?main=cart/cartform.jsp'">장바구니</a></li>
                <li><a onclick="location.href='index.jsp?main=orderlist/orderlistform.jsp'">구매내역</a></li>
                <li><a onclick="location.href='index.jsp?main=category/catewish.jsp'" style="color: black; border-bottom: 3px solid black;">위시리스트</a></li>            
            </ul>
        </div>
    </div>
    <!-- Category Navigation -->
   <!-- 카테고리 -->
<div class="main-category" style="width: 100%; background-color: white; left: 0;">
<div class="container mt-5" style="margin-top: 5rem !important;">
      <div class="mb-3 text-secondary">
         홈 &gt; 마이페이지 &gt; <b>위시리스트 (<%=name%>&nbsp;님)
         </b>
      </div>
      <h2 class="mb-4">
         위시리스트 <span style="font-size: 16px; color: #aaa;">ⓘ</span>
      </h2>
   </div>
</div>

<!-- 상품 목록 -->
<div class="container">
    <div class="product-container">
        <div class="product-type">
            <div class="product-type-item">이미지</div>
            <div class="product-type-item">기본정보</div>
            <div class="product-type-item">선택</div>
        </div>
        <div id="product-list">
            <!-- 상품 행 템플릿 -->
            <%  
            	if(list.size()==0){%>
            		 <!-- 빈 위시리스트 메시지 -->
			        <div class="empty-wishlist" style="display: none;">
			            <i class="bi bi-heart" style="font-size: 48px; margin-bottom: 20px;"></i>
			            <h4>위시리스트가 비어있습니다</h4>
			            <p>마음에 드는 상품을 하트 아이콘을 눌러 추가해보세요!</p>
			        </div>
            	<%}else{
            	for(int i = 0; i < list.size(); i++) {
            		WishListDto wdto=list.get(i);
            		ProductDto pdto=wdto.getProduct();
            	%>
            		 <div class="product-row">
            		 
					    <div class="product-type-item">
					        <img src="<%=pdto.getMainImageUrl() %>" alt="Product Image" class="product-image">
					    </div>
					    <div class="product-info product-type-item" style="text-align: center;">
					    	
					        <div class="product-company"><b><%=pdto.getCategory() %></b></div>
					        <div class="product-name"><%=pdto.getProductName() %></div>
					        <div class="product-price">
					        <%
							    BigDecimal price = pdto.getPrice();
							    DecimalFormat df = new DecimalFormat("#,###");
							    String formattedPrice = df.format(price.setScale(0, BigDecimal.ROUND_DOWN)); // 천 단위 콤마 추가 및 소수점 이하 내림 처리
							%>
					        <%=formattedPrice %>원
					        </div>
					    </div>
					    <div class="product-type-item">
					   
					        <button class="btn btn-sm btn-outline-danger" style="font-size: 11px;"
					         onclick="funcdel(<%=wdto.getProductId()%>)">
					        위시리스트에서 제거
					        </button>
					        
					    </div>
					</div>
            		
            	<%}
            %>
            <%}
            %>        
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


window.addEventListener("scroll", function () {
    const mypage = document.querySelector(".mypage-content");
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

    if (scrollTop > 50) {
      mypage.style.top = "100px";
    } else {
      mypage.style.top = "150px";
    }
  });


const memberId = <%= memberId %>;

function funcdel(num){
  if(confirm("위시리스트에서 삭제하시겠습니까?")){
    $.ajax({
      url:'category/deletewish.jsp',
      type:'POST',
      data:{
        productId: num,
        memberId: memberId
      },
      success:function(response){
        alert("삭제되었습니다");
        location.reload();
      },
      error:function(xhr, status, error){
        alert("오류 발생했다");
      }
    });
  }
}


</script>
</body>
</html>