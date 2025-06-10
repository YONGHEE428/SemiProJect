<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.WishListDto"%>
<%@page import="data.dao.WishListDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="java.util.Base64"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.ArrayList"%>
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
        margin: 10px;
        border-radius: 8px;
        border:none;
    }
    .product-card:hover {
        transform: translateY(-5px);
        cursor: pointer;
        filter: brightness(70%);
        transition: 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
    .product-company {
        font-size: 12px;
        color: #777;
    }
    .product-name {
        font-size: 14px;
        font-weight: bold;
        margin: 5px 0;
        white-space: nowrap;           /* 줄바꿈 방지 */
        overflow: hidden;              /* 넘친 텍스트 숨김 */
        text-overflow: ellipsis;       /* 말줄임 (...) 처리 */
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
    .main-category a:hover {
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
	WishListDao wdao=new WishListDao();
	MemberDao mdao=new MemberDao();
	String id=(String)session.getAttribute("myid");
	if(id!=null&&!id.isEmpty()){
		int memberId=mdao.getMemberNumById(id);
		System.out.println(memberId);
		List<WishListDto> wishProductIds=wdao.getWishList(memberId);
		List<Integer> productIds = new ArrayList<>();
		
		 for (WishListDto dto : wishProductIds) {
		        productIds.add(dto.getProductId()); // getProductId() 메서드는 실제 DTO에 맞게 변경
		    }
		    request.setAttribute("productIds", productIds);
	}
		
		
	ProductDao pdao=new ProductDao();
	String categoryName=(String)session.getAttribute("categoryName");
	int productId=(Integer)session.getAttribute("productId");
	List<ProductDto> list=pdao.getProductsWithOptionsByCategory(categoryName);
	
%>
$(function () {
    // 하트 클릭 (동적 요소 대응)
     var productIds = <%= new com.google.gson.Gson().toJson(request.getAttribute("productIds")) %>;
     console.log('Product IDs:', productIds);
     
     // 각 상품에 대해 하트 아이콘 상태를 확인하여 채웁니다.
    
     
    $(document).on("click", ".heart", function () {
    	const heartIcon=$(this);
        const isFilled = heartIcon.hasClass("bi-heart-fill");
        const count = parseInt(heartIcon.text());
        const productId = heartIcon.closest(".product-card").data("product-id");
        const optionId = heartIcon.closest(".product-card").data("option-id");
        
        if(id===""){
            alert("로그인 후 이용해주세요.");
            location.href="index.jsp?main=login/loginform.jsp";
            return;
        } else {
            const action =isFilled?"unlike":"like";
            $.ajax({
                url: "category/likeupdate.jsp",
                type: "POST",
                data: { productId: productId,
                        optionId:optionId,
                        action: action},
                success: function () {
                    if (isFilled) {
                        heartIcon
                            .removeClass("bi-heart-fill")
                            .addClass("bi-heart")
                            .css("color", "black")
                            .html("&nbsp;" + (count - 1));
                        document.querySelector("#liveToast .toast-body").innerText = "위시리스트에서 삭제되었습니다!";
                        const toast = bootstrap.Toast.getOrCreateInstance(document.getElementById('liveToast'));
                        toast.show();
                    } else {
                        heartIcon
                            .removeClass("bi-heart")
                            .addClass("bi-heart-fill")
                            .css("color", "red")
                            .html("&nbsp;" + (count + 1));
                        document.querySelector("#liveToast .toast-body").innerText = "위시리스트에 추가되었습니다!";
                        const toast = bootstrap.Toast.getOrCreateInstance(document.getElementById('liveToast'));
                        toast.show();
                    }
                },
                error: function () {
                    alert("좋아요 처리 중 오류가 발생했습니다."+productId);
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
            	 console.log(data); 
                // 데이터가 없으면 로딩 종료
                if (data.length === 0) {
                    return;
                }
                // 상품 첫페이지(16종)
                const container = document.getElementById("product-list");
                data.forEach(item => {
                    const productOptionId = (item.options && item.options.length > 0) ? item.options[0].optionId : 0; // 또는 null
                    const el = document.createElement("div");
                    el.classList.add("col-3");  // 상품 카드 스타일을 위한 클래스 추가
                    el.innerHTML =
                        "<div class='product-card' data-product-id='"+item.productId +"' data-option-id='"+productOptionId+"'>" +
                        "<div class='item'>" +
                        "<a href='/SemiProject/index.jsp?main=shop/sangpumpage.jsp'>" +
                        "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +  // 상품 이미지
                        "</a>" +
                        "</div>" +
                        "<div class='product-info'>" +
                        "<div class='product-company'>" + item.category + "</div>" +
                        "<div class='product-name' title='"+item.productName+"'>" + item.productName + "</div>" +
                        "<div class='product-price'>" + formatPrice(item.price) + "원</div>" + // 가격 그대로 출력
                        "<div class='item-heart'>" +
                        "<i class='bi bi-heart heart' style='cursor: pointer; color: black; font-style: normal; font-size: 15px;'>&nbsp; " +
                        (item.likeCount == null ? 0 : item.likeCount) + "</i>&nbsp;" +  // 좋아요 수
                        "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +  // 조회수
                        "</div>" +
                        "</div>" +
                        "</div>";
                        if (productIds.includes(item.productId)) {
                            const heartIcon = el.querySelector(".heart");
                            if (heartIcon) {
                                heartIcon.classList.remove("bi-heart");
                                heartIcon.classList.add("bi-heart-fill");
                                heartIcon.style.color = "red";  // 빨간색으로 하트 색상 변경
                            }
                        }
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
                        const productOptionId = (item.options && item.options.length > 0) ? item.options[0].optionId : 0; // 또는 null

                        const el = document.createElement("div");
                        el.classList.add("col-3");  // 상품 카드 스타일을 위한 클래스 추가
                        el.innerHTML =
                            "<div class='product-card' data-product-id='" + item.productId + "' data-option-id='"+productOptionId+"'>" +
                            "<div class='item'>" +
                            "<a href='/Semiproject/shop/sangpumpage.jsp'>" +
                            "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +  // 상품 이미지
                            "</a>" +
                            "</div>" +
                            "<div class='product-info'>" +
                            "<div class='product-company'>" + item.category + "</div>" +
                            "<div class='product-name' title='"+item.productName+"'>" + item.productName + "</div>" +
                            "<div class='product-price'>" + formatPrice(item.price) + "원</div>" + // 가격 그대로 출력
                            "<div class='item-heart'>" +
                            "<i class='bi bi-heart heart' style='cursor: pointer; color: black;'>" +
                            (item.likeCount == null ? 0 : item.likeCount) + "</i>&nbsp;" +  // 좋아요 수
                            "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +  // 조회수
                            "</div>" +
                            "</div>" +
                            "</div>";
                            if (productIds.includes(item.productId)) {
                                const heartIcon = el.querySelector(".heart");
                                if (heartIcon) {
                                    heartIcon.classList.remove("bi-heart");
                                    heartIcon.classList.add("bi-heart-fill");
                                    heartIcon.style.color = "red";  // 빨간색으로 하트 색상 변경
                                }
                            }
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
});
</script>
</head>

<body>
<%
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div class="alldiv">
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

    <div class="main-category" style="width: 100%; background-color: white; left: 0;">
        <div id="selectedCategory" style="text-align:center; font-size: 24px; font-weight: bold; margin-top: 20px;"></div>
        <ul>
            <li class="dropdown" style="background-color:#2c3e50; border-radius: 20px;">
                <a href="index.jsp?main=category/category.jsp" class="category-link" style="color: white;">ALL</a>
            </li>
            <li class="divider"></li>
            <li class="nav-item dropdown">
            <a class="category-link" href="index.jsp?main=category/top.jsp&category1=티셔츠&category2=아우터" role="button">TOP</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="index.jsp?main=category/top.jsp&category1=티셔츠">티셔츠</a></li>
                    <li><a class="dropdown-item" href="index.jsp?main=category/top.jsp&category1=아우터">아우터</a></li>
                </ul>
            </li>
            <li class="divider"></li>
            <li class="dropdown">
                <a href="index.jsp?main=category/bottom.jsp&category1=팬츠&category2=치마" class="category-link">BOTTOM</a>
                <ul class="dropdown-menu">
                    <li><a href="index.jsp?main=category/bottom.jsp&category1=팬츠">팬츠</a></li>
                    <li><a href="index.jsp?main=category/bottom.jsp&category1=치마">치마</a></li>
                </ul>
            </li>
            <li class="divider"></li>
            <li class="dropdown">
                <a href="index.jsp?main=category/accesories.jsp&category1=악세서리" class="category-link">ACCESORIES</a>
            </li>
            <li class="divider"></li>
            <li class="dropdown">
                <a href="index.jsp?main=category/shoes.jsp&category1=신발" class="category-link">SHOES</a>
            </li>
        </ul>
    </div>
    <div class="container my-5">
        <div id="product-list" class="row">
            </div>
    </div>
    <div class="alldiv">
        <jsp:include page="controller.jsp"/>
    </div>
    <div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
    <div id="observerTarget" style="width: 100%; height: 10px;" ></div>
</div>
</body>
</html>