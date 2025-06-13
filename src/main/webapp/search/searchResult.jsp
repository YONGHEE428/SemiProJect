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
<title>검색 결과</title>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
    /* Product grid */
    .product-card {
        margin: 10px;
        border-radius: 8px;
        border: none;
        transition: transform 0.2s;
    }
    
    .product-card:hover {
        transform: translateY(-5px);
    }
    
    .product-image {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-radius: 8px;
    }
    
    .product-info {
        padding: 15px;
    }
    
    .product-company {
        color: #666;
        font-size: 0.9em;
    }
    
    .product-name {
        margin: 5px 0;
        font-weight: bold;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .product-price {
        font-weight: bold;
        color: #000;
    }
    
    .item-heart {
        margin-top: 10px;
        color: #666;
    }
    
    #loadingMessage {
        text-align: center;
        padding: 20px;
        display: none;
    }
    
    .search-header {
        padding: 20px 0;
        border-bottom: 1px solid #eee;
        margin-bottom: 30px;
    }
    
    .search-keyword {
        font-weight: bold;
        color: #2c3e50;
    }
    
    .no-results {
        text-align: center;
        padding: 50px 0;
    }
    
    .related-search {
        font-size: 0.9em;
    }
    
    .related-link {
        color: #0d6efd;
        text-decoration: underline;
        cursor: pointer;
    }
    
    .related-link:hover {
        color: #0a58ca;
    }
</style>
</head>
<body>
<%
    String keyword = request.getParameter("keyword");
    
    // 로그인 정보 확인
    WishListDao wdao = new WishListDao();
    MemberDao mdao = new MemberDao();
    String id = (String)session.getAttribute("myid");
    List<Integer> productIds = new ArrayList<>();
    
    if(id != null && !id.isEmpty()) {
        int memberId = mdao.getMemberNumById(id);
        List<WishListDto> wishProductIds = wdao.getWishList(memberId);
        
        for (WishListDto dto : wishProductIds) {
            productIds.add(dto.getProductId());
        }
        request.setAttribute("productIds", productIds);
    }
%>

<div class="container">
    <div class="search-header">
        <div class="d-flex align-items-center">
            <h3>"<span class="search-keyword"><%=keyword%></span>" 검색 결과</h3>
            <%
            String relatedKeyword = null;
            String relatedText = null;
            
            if(keyword != null) {
                if(keyword.contains("반팔") || keyword.contains("반소매") || keyword.contains("긴팔") || keyword.contains("맨투")) {
                    relatedKeyword = "티셔츠";
                    relatedText = "티셔츠 검색결과 보기";
                } else if(keyword.contains("바지") || keyword.contains("버뮤다")) {
                    relatedKeyword = "팬츠";
                    relatedText = "팬츠 검색결과 보기";
                } else if(keyword.contains("목걸이") || keyword.contains("모자") || keyword.contains("키링")) {
                    relatedKeyword = "악세서리";
                    relatedText = "악세서리 검색결과 보기";
                }else if(keyword.contains("샌들") || keyword.contains("운동화") || keyword.contains("축구화") || keyword.contains("부츠")) {
                    relatedKeyword = "신발";
                    relatedText = "신발 검색결과 보기";
                }else if(keyword.contains("티셔츠")){
                	relatedKeyword = "티셔츠";
                }else if(keyword.contains("팬츠")){
                	relatedKeyword = "팬츠";
                }else if(keyword.contains("악세서리")){
                	relatedKeyword = "악세서리";
                }else if(keyword.contains("신발")){
                	relatedKeyword = "신발";
                }
                
                if(!relatedKeyword != null) {
            %>
            <div class="related-search ms-4">
                <span class="text-muted">이것을 찾으셨나요?</span>
                <a href="index.jsp?main=search/searchResult.jsp&keyword=<%=relatedKeyword%>" class="related-link ms-2">
                    <%=relatedText%>
                </a>
            </div>
            <%
                
            }
            %>
        </div>
    </div>
    
    <div id="product-list" class="row">
        <!-- 제품 목록이 여기에 동적으로 로드됩니다 -->
    </div>
    
    <div id="loadingMessage">로딩중...</div>
    <div id="observerTarget" style="width: 100%; height: 10px;"></div>
</div>

<script>
$(function() {
    let page = 2;
    let isLoading = false;
    
    // 가격 포맷팅 함수
    function formatPrice(price) {
        return price.toLocaleString();
    }
    
    // 초기 아이템 로드
    function loadInitialItems() {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/SemiProject/data/searchItems.jsp",
            data: {
                page: 1,
                keyword: "<%=keyword%>"
            },
            success: function(data) {
                if (data.length === 0) {
                    $("#product-list").html(
                        '<div class="no-results">' +
                        '<i class="bi bi-search" style="font-size: 48px; margin-bottom: 20px;"></i>' +
                        '<h4>검색 결과가 없습니다</h4>' +
                        '<p>다른 검색어로 시도해보세요.</p>' +
                        '</div>'
                    );
                    return;
                }
                
                const container = document.getElementById("product-list");
                data.forEach(item => {
                    const el = document.createElement("div");
                    el.classList.add("col-3");
                    
                    const isWished = item.wish === true;
                    const heartClass = isWished ? "bi-heart-fill" : "bi-heart";
                    const heartColor = isWished ? "red" : "black";
                    
                    el.innerHTML =
                        "<div class='product-card' data-product-id='" + item.productId + "'>" +
                        "<div class='item'>" +
                        "<a href='/SemiProject/index.jsp?main=shop/sangpumpage.jsp&product_id=" + item.productId + "'>" +
                        "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +
                        "</a>" +
                        "</div>" +
                        "<div class='product-info'>" +
                        "<div class='product-company'>" + item.category + "</div>" +
                        "<div class='product-name' title='" + item.productName + "'>" + item.productName + "</div>" +
                        "<div class='product-price'>" + formatPrice(item.price) + "원</div>" +
                        "<div class='item-heart'>" +
                        "<i class='bi " + heartClass + " heart' " +
                        "style='cursor: pointer; color: " + heartColor + "; font-style:normal; font-size:15px;'" +
                        "data-product-id='" + item.productId + "'>&nbsp;" +
                        (item.likeCount == null ? 0 : item.likeCount) + "</i>&nbsp; " +
                        "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +
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
    
    // 스크롤 시 추가 아이템 로드
    function loadMoreItems() {
        if (isLoading) return;
        isLoading = true;
        $("#loadingMessage").show();
        
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/SemiProject/data/searchItems.jsp",
            data: {
                page: page,
                keyword: "<%=relatedKeyword%>"
            },
            success: function(data) {
                setTimeout(() => {
                    if (data.length === 0) {
                        $("#loadingMessage").hide();
                        return;
                    }
                    
                    const container = document.getElementById("product-list");
                    data.forEach(item => {
                        const el = document.createElement("div");
                        el.classList.add("col-3");
                        
                        const isWished = item.wish === true;
                        const heartClass = isWished ? "bi-heart-fill" : "bi-heart";
                        const heartColor = isWished ? "red" : "black";
                        
                        el.innerHTML =
                            "<div class='product-card' data-product-id='" + item.productId + "'>" +
                            "<div class='item'>" +
                            "<a href='/SemiProject/index.jsp?main=shop/sangpumpage.jsp&product_id=" + item.productId + "'>" +
                            "<img src='" + item.mainImageUrl + "' alt='' class='product-image'>" +
                            "</a>" +
                            "</div>" +
                            "<div class='product-info'>" +
                            "<div class='product-company'>" + item.category + "</div>" +
                            "<div class='product-name' title='" + item.productName + "'>" + item.productName + "</div>" +
                            "<div class='product-price'>" + formatPrice(item.price) + "원</div>" +
                            "<div class='item-heart'>" +
                            "<i class='bi " + heartClass + " heart' " +
                            "style='cursor: pointer; color: " + heartColor + "; font-style:normal; font-size:15px;'" +
                            "data-product-id='" + item.productId + "'>&nbsp;" +
                            (item.likeCount == null ? 0 : item.likeCount) + "</i>&nbsp; " +
                            "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +
                            "</div>" +
                            "</div>" +
                            "</div>";
                        container.appendChild(el);
                    });
                    
                    page++;
                    isLoading = false;
                    $("#loadingMessage").hide();
                }, 500);
            },
            error: function(xhr, status, error) {
                console.error("불러오기 실패", error);
                isLoading = false;
                $("#loadingMessage").hide();
            }
        });
    }
    
    // 초기 로드
    loadInitialItems();
    
    // 무한 스크롤
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                loadMoreItems();
            }
        });
    });
    
    observer.observe(document.getElementById("observerTarget"));
    
    // 위시리스트 토글
    $(document).on("click", ".heart", function() {
        const productId = $(this).data("product-id");
        const $heart = $(this);
        
        $.ajax({
            type: "POST",
            url: "/SemiProject/data/wishlist_proc.jsp",
            data: { productId: productId },
            success: function(response) {
                if(response.trim() === "login") {
                    alert("로그인이 필요한 서비스입니다.");
                    location.href = "index.jsp?main=login/loginform.jsp";
                } else if(response.trim() === "add") {
                    $heart.removeClass("bi-heart").addClass("bi-heart-fill").css("color", "red");
                } else if(response.trim() === "remove") {
                    $heart.removeClass("bi-heart-fill").addClass("bi-heart").css("color", "black");
                }
            }
        });
    });
    
    // 검색창에 검색어 표시
    $("#searchbar").val("<%=keyword%>");
    $("#input-search").val("<%=keyword%>");
});
</script>
</body>
</html>