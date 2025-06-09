
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="java.util.Base64"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>

<%@page import="java.util.ArrayList"%>
<%-- <%@page import="data.dao.ProductDao"%> --%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Main</title>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <style>

        /* Product grid */
        .product-card {
             border: 1px solid #ddd;
			    margin: 10px;
			    border-radius: 8px;
			    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			    border:none;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            cursor: pointer;
      		filter: brightness(70%);
      		transition: 0.3s ease;
      		 border: none; 
        }
        
        .product-image {
            height: 280px;  /* 원하는 높이 설정 (예: 200px) */
   			object-fit: cover;
            width: 100%;
        }
        
        .product-info {
            padding: 10px 0;
            margin-left: 10px;
            margin-right: 10px;
        }
        
        .product-title {
            font-size: 0.9rem;
            margin-bottom: 5px;
            padding:5px;
        }
        .product-company {
		    font-size: 12px;
		    color: #777;
		}
		
		.product-name {
		    font-size: 14px;
		    font-weight: bold;
		    margin: 5px 0;
		}
        .product-price {
            font-weight: bold;
            color: #333;
        }
        
        /* User menu */
        .user-menu .btn {
            margin: 0 5px;
            font-size: 0.9rem;
        }
        
   
        .main-category ul {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        .main-category li {
         position: relative;
            padding: 15px 30px;
        }
        
        .main-category a {
            text-decoration: none;
            color: black;
            font-size: 20px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .main-category a:hover
         {
            color: #fff;
        }

        .main-category .divider {
            width: 1px;
            margin: 15px 0;
            color: #fff;
        }
        .category-link {   			 
    			color: white;
    			text-shadow: 1px 1px 1px gray;
    			text-decoration: none;
		}
		
		.dropdown {
 		   position: relative;
		}
		.dropdown-menu {
  			 display: none;
    		 opacity: 0;
    		 visibility: hidden;
    		 transition: opacity 0.3s ease;
    		 position: absolute;
    		 top: 100%;
    		 left: 50%; 
		 	 transform: translateX(-50%);  /* 레이어 가운데 수평 정렬 */
		 	
    		 background-color: white;
    		 padding: 10px 20px;
    		 display: flex;
    	  	 flex-direction:column; /* 세로정렬 */
    		 gap: 10px;		/* 아이템간 간격 */
    		 z-index: 999;
    		 box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		}
		.dropdown-menu li {
    		list-style: none;
    		text-align: center;
		}
/* 호버 시 드롭다운 메뉴 보이기 */
		.dropdown:hover > .dropdown-menu {
  			  display: flex;
   			  opacity: 1;
    		  visibility: visible;
		}
		.dropdown-menu a {
   			 text-decoration: none;
    		 font-size: 20px;
    		 font-weight: bold;
    		 color: black;
    		 padding: 10px 20px;
    		 display: block;
    		 transition: background-color 0.2s, color 0.2s;
		}
		.dropdown-menu a:hover{
			background-color: #2c3e50;
			border-radius: 20px;
		}
   

    </style>
   
  <script type="text/javascript">
   <%
	String id=(String)session.getAttribute("myid");
   
	ProductDao pdao=new ProductDao();
	String categoryName=(String)session.getAttribute("categoryName");
	int productId=(Integer)session.getAttribute("productId");
	List<ProductDto> list=pdao.getProductsWithOptionsByCategory(categoryName);
	
	
	%> 
  $(function () {
	    // 하트 클릭 (동적 요소 대응)
	    $(document).on("click", ".heart", function () {
	    	const heartIcon=$(this);
	        const isFilled = heartIcon.hasClass("bi-suit-heart-fill");
	        const count = parseInt(heartIcon.text());
	        const productId = heartIcon.closest(".product-card").data("product-id");
			
	        if(id===""){
    			alert("로그인 후 이용해주세요.");
			    location.href="index.jsp?main=login/loginform.jsp";
			    return;
    		}
	        else{
	        	const action =isFilled?"unlike":"like";
	        	 $.ajax({
	        	        url: "likeAction.jsp",
	        	        type: "POST",
	        	        data: { productId: productId, action: action },
	        	        success: function () {
	        	            if (isFilled) {
	        	                heartIcon
	        	                    .removeClass("bi-suit-heart-fill")
	        	                    .addClass("bi-suit-heart")
	        	                    .css("color", "black")
	        	                    .text(count - 1);
	        	            } else {
	        	                heartIcon
	        	                    .removeClass("bi-suit-heart")
	        	                    .addClass("bi-suit-heart-fill")
	        	                    .css("color", "red")
	        	                    .text(count + 1);

	        	                document.querySelector("#liveToast .toast-body").innerText = "위시리스트에 추가되었습니다!";
	        	                const toast = bootstrap.Toast.getOrCreateInstance(document.getElementById('liveToast'));
	        	                toast.show();
	        	            }
	        	            
	        	        },
	        	        error: function () {
	        	            alert("좋아요 처리 중 오류가 발생했습니다.");
	        	        }
	        	    });
    		}
	    });
	 // 가격에 천 단위 콤마 추가
	    function formatPrice(price) {
	        return price.toLocaleString();  
	    }
	    // 무한스크롤
	let page = 2;  // 처음 16개 아이템을 이미 로드했으므로, 다음 페이지는 2부터 시작
let isLoading = false;  // 중복 요청을 방지하기 위한 플래그
function loadInitialItems() {
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/SemiProject/data/items.jsp?page=1",  // 페이지 1에서 16개 로드
        success: function(data) {
            // 데이터가 없으면 로딩 종료
            if (data.length === 0) {
                return;
            }

            // 상품 목록에 처음 16개 아이템 추가
            const container = document.getElementById("product-list");
            data.forEach(item => {
                const el = document.createElement("div");
                el.classList.add("col-3");  // 상품 카드 스타일을 위한 클래스 추가
                el.innerHTML =
                    "<div class='product-card' data-product-id='" + item.productId + "'>" +
                    "<div class='item'>" +
                    "<a href='/Semiproject/shop/sangpumpage.jsp'>" +
                    "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +  // 상품 이미지
                    "</a>" +
                    "</div>" +
                    "<div class='product-info'>" +
                    "<div class='product-company'>" + item.category + "</div>" +
                    "<div class='product-name'>" + item.productName + "</div>" +
                    "<div class='product-price'>" + formatPrice(item.price) + "원</div>" + // 가격 그대로 출력
                    "<div class='item-heart'>" +
                    "<i class='bi bi-suit-heart heart' style='cursor: pointer; color: black;'>" + 
                    (item.likeCount == null ? 0 : item.likeCount) + "</i>&nbsp;" +  // 좋아요 수
                    "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +  // 조회수
                    "</div>" +
                    "</div>" +
                    "</div>";
                container.appendChild(el);
            });


        },
        error: function(xhr, status, error) {
            console.error("불러오기 실패", error);
        }
    });
}
// 처음 로딩 시, 16개 상품을 표시
loadInitialItems();
// 스크롤이 끝까지 내려가면 더 많은 데이터를 불러오는 함수
function loadMoreItems() {
    if (isLoading) return;  // 로딩 중이면 중복 요청 방지
    isLoading = true;  // 로딩 중으로 상태 변경
    document.getElementById("loadingMessage").style.display = "block";  // 로딩 메시지 보이기

    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/SemiProject/data/items.jsp?page=" + page,  // page는 서버에서 다음 데이터를 요청하는 파라미터
        success: function(data) {
            setTimeout(() => {
                // 데이터가 없으면 로딩 종료
                if (data.length === 0) {
                    document.getElementById("loadingMessage").style.display = "none";  // 로딩 메시지 숨기기
                    return;
                }

                // 새 상품 추가
                const container = document.getElementById("product-list");
                data.forEach(item => {
                    const el = document.createElement("div");
                    el.classList.add("col-3");  // 상품 카드 스타일을 위한 클래스 추가
                    el.innerHTML =
                        "<div class='product-card' data-product-id='" + item.productId + "'>" +
                        "<div class='item'>" +
                        "<a href='/Semiproject/shop/sangpumpage.jsp'>" +
                        "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +  // 상품 이미지
                        "</a>" +
                        "</div>" +
                        "<div class='product-info'>" +
                        "<div class='product-company'>" + item.category + "</div>" +
                        "<div class='product-name'>" + item.productName + "</div>" +
                        "<div class='product-price'>" + formatPrice(item.price) + "원</div>" + // 가격 그대로 출력
                        "<div class='item-heart'>" +
                        "<i class='bi bi-suit-heart heart' style='cursor: pointer; color: black;'>" + 
                        (item.likeCount == null ? 0 : item.likeCount) + "</i>" +  // 좋아요 수
                        "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +  // 조회수
                        "</div>" +
                        "</div>" +
                        "</div>";

                    // 새로 생성한 상품 카드를 상품 목록에 추가
                    container.appendChild(el);
                });

                // 페이지 번호 증가
                page++;

                // 로딩 상태 해제
                isLoading = false;
                document.getElementById("loadingMessage").style.display = "none";  // 로딩 메시지 숨기기
            }, 500);  // 데이터를 추가하기 전에 500ms 지연
        },
        error: function(xhr, status, error) {
            console.error("불러오기 실패", error);
            isLoading = false;  // 에러 발생 시 로딩 상태 해제
            document.getElementById("loadingMessage").style.display = "none";  // 로딩 메시지 숨기기
        }
    });
}
// 스크롤 이벤트를 통해 끝까지 내리면 loadMoreItems() 호출
window.onscroll = function() {
    if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 100) {
        loadMoreItems();
    }
};

     	
	    <!-- location.href='index.jsp?main=category/catewish.jsp' -->
	});
 

</script>
    
</head>

<body>
<%
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div class="alldiv">
  <!-- 알림창 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="SemiImg/footerLogo.png" width="20px;" class="rounded me-2" alt="...">
      <strong class="me-auto">!알림</strong>
      <small>Now</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" 
      aria-label="Close"></button>
    </div>
    <div class="toast-body">
      
    </div>
  </div>
</div>
   
 
   <!-- 카테고리 -->
<div class="main-category" style="width: 100%; background-color: white; left: 0;">
<div id="selectedCategory" style="text-align:center; font-size: 24px; font-weight: bold; margin-top: 20px;"></div>

   		 <ul>
   		  <li class="dropdown" style="background-color:#2c3e50; border-radius: 20px;">
            <a href="index.jsp?main=category/category.jsp" class="category-link" style="color: white;">ALL</a>
        </li>
    <li class="divider"></li>  
  <li class="nav-item dropdown">
  <a class="category-link" href="index.jsp?main=category/top.jsp" role="button" >TOP</a>
  <!-- TOP에서 드랍다운 -->
  		<ul class="dropdown-menu">
    		<li><a class="dropdown-item" href="#">티셔츠</a></li>
    		<li><a class="dropdown-item" href="#">아우터</a></li>
    		
  		</ul>
 </li>

        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/bottom.jsp" class="category-link">BOTTOM</a>
            <ul class="dropdown-menu">
                <li><a href="#">팬츠</a></li>
                <li><a href="#">치마</a></li>
                
            </ul>
        </li>
        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/accesories.jsp" class="category-link">ACCESORIES</a>
           
        </li>
       
        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/shoes.jsp" class="category-link">SHOES</a>
        </li>
    </ul>
</div>
    <!-- Product Grid -->
     <div class="container my-5">
        <div id="product-list" class="row">
            <!-- Product Card Template - Repeated 16 times (4x4 grid) -->
           
        </div>
    </div> 
	
   <div class="alldiv">
   <!-- controller.jsp -->
   	<jsp:include page="controller.jsp"/>
   </div>
	
    <div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
 	<div id="observerTarget" style="width: 100%; height: 10px;" ></div>
    
   </div> 



</body>
</html>