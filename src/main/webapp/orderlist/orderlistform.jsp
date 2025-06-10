<%@page import="java.util.ArrayList"%>
<%@page import="data.dto.OrderListDto"%>
<%@page import="data.dao.OrderListDao"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>주문 목록</title>
<style>
body {
	background: #f8f8f8;
}

.order-wrapper {
	max-width: 900px;
	margin: 70px auto;
	background: #fff;
	border: 1px solid #444;
	padding: 30px 25px;
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding-bottom: 20px;
	border-bottom: 1px solid #ddd;
}

.order-header h2 {
	font-size: 24px;
	font-weight: 600;
	margin: 0;
}

.order-header .order-count {
	color: #666;
	font-size: 14px;
}

.order-search-row {
	display: flex;
	gap: 8px;
	margin-bottom: 13px;
}

.order-search-row input[type=text] {
	flex: 1 1 0;
	border: 1px solid #aaa;
	border-radius: 4px;
	padding: 7px 12px;
}

.order-search-row button, .order-search-row a.btn {
	min-width: 72px;
	padding: 7px 0;
	font-size: 0.97rem;
	border-radius: 4px;
}

.order-period-row {
	display: flex;
	gap: 9px;
	margin-bottom: 20px;
}

.order-period-row button {
	flex: none;
	min-width: 66px;
	border-radius: 4px;
	font-size: 0.97rem;
}

.order-box {
	border: 1.5px solid #e0e0e0;
	border-radius: 13px;
	padding: 22px 24px 18px 24px;
	margin-bottom: 32px;
	background: #fafbfc;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	transition: box-shadow .18s;
}

.order-box:hover {
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.order-item-box {
	border: 1px solid #f0f0f0; /* 아주 연한 구분선 */
	border-radius: 10px;
	background: #fff;
	margin-bottom: 12px; /* 상품들끼리 사이 간격 */
	padding: 13px 12px 11px 12px;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04); /* 부드러운 그림자, 원하면 생략 */
}

.order-header-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 14px;
}

.order-status-label {
	font-weight: bold;
	font-size: 1.04rem;
}

.order-delete-btn {
	border: 1px solid #d66;
	background: #fff;
	color: #c44;
	border-radius: 5px;
	font-size: 0.97rem;
	padding: 4px 13px;
	transition: background .2s;
}

.order-delete-btn:hover {
	background: #ffe7e7;
}

.order-content-row {
	display: flex;
	align-items: flex-start;
	gap: 20px;
}

.order-thumb-box {
	border: 1px solid #aaa;
	width: 92px;
	height: 92px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 6px;
	background: #fff;
	font-size: 0.97rem;
	color: #666;
}

.order-prod-info {
	flex: 1;
	min-width: 0;
}

.order-prod-title {
	font-weight: bold;
	font-size: 1.07rem;
	margin-bottom: 7px;
}

.order-prod-desc {
	font-size: 0.97rem;
	color: #555;
	margin-bottom: 7px;
}

.order-prod-price-row {
	display: flex;
	align-items: center;
	gap: 17px;
	margin-bottom: 5px;
}

.order-prod-price {
	font-size: 0.99rem;
	border: 1px solid #bbb;
	background: #fff;
	border-radius: 4px;
	padding: 4px 16px;
	margin-right: 6px;
}

.cart-btn {
	font-size: 0.98rem;
	padding: 3px 16px;
	border-radius: 4px;
	background: #eee;
	border: 1px solid #bbb;
}

.order-actions-col {
	display: flex;
	flex-direction: column;
	gap: 5px;
	min-width: 87px;
}

.order-actions-col .btn {
	font-size: 0.96rem;
	border-radius: 4px;
	padding: 3px 0;
	border: 1px solid #bbb;
	background: #fff;
}

.order-actions-col .btn:hover {
	background: #e7e7e7;
}

.empty-order {
	text-align: center;
	padding: 50px 0;
	color: #666;
}

.empty-order i {
	font-size: 48px;
	margin-bottom: 20px;
	color: #ddd;
}

.empty-order p {
	font-size: 16px;
	margin: 10px 0;
}

.empty-order .continue-shopping {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background: #000;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
	transition: all 0.3s ease;
}

.empty-order .continue-shopping:hover {
	background: #333;
}
/* 상단바 */
.mypage-content {
	height: 60px;
	line-height: 60px;
	top: 150px;
	position: fixed;
	width: 100%;
	min-height: 5px;
	font-weight: bold;
	text-align: center;
	background-color: white;
	transition: top 0.3s ease;
}

.content-title>ul {
	display: flex;
	justify-content: center;
	gap: 170px;
}

.content-title>ul>li>a {
	color: gray;
	text-decoration: none;
}

.content-title>ul>li>a:hover {
	color: black;
	border-bottom: 3px solid black;
}
body {
    background: #f8f8f8;
}
.order-wrapper { max-width: 900px; margin: 70px auto; background: #fff; border: 1px solid #444; padding: 30px 25px; }

</style>
</head>
<%
String memberId = (String) session.getAttribute("myid");
String name = (String) session.getAttribute("name");

if (memberId == null) {
    String orderListPageUrl = request.getContextPath() + "/index.jsp?main=orderlist/orderlistform.jsp";
    response.sendRedirect(request.getContextPath() + "/index.jsp?main=login/loginform.jsp&redirect="
    + java.net.URLEncoder.encode(orderListPageUrl, "UTF-8"));
    return;
}

MemberDao memberDao = new MemberDao();
int memberNum = memberDao.getMemberNumById(memberId);

OrderListDao dao = new OrderListDao();
List<OrderListDto> orderList = dao.getOrdersByMember(memberNum);

String keyword = request.getParameter("keyword");
if (keyword == null)
    keyword = "";
keyword = keyword.trim(); // <-- 공백 제거 꼭 추가!
%>
<body>
    <!-- 상단바 -->
    <div class="mypage-content">
        <div class="content-title">
            <ul>
                <li><a onclick="location.href='index.jsp?main=cart/cartform.jsp'">장바구니</a></li>
                <li><a onclick="location.href='index.jsp?main=orderlist/orderlistform.jsp'" style="color: black; border-bottom: 3px solid black;">구매내역</a></li>
                <li><a onclick="location.href='index.jsp?main=category/catewish.jsp'">위시리스트</a></li>
            </ul>
        </div>
    </div>

    <div class="container mt-5" style="margin-top: 5rem !important;">
        <div class="mb-3 text-secondary">
            홈 &gt; 마이페이지 &gt; <b>구매내역 (<%=name%>&nbsp;님)
            </b>
        </div>
        <h2 class="mb-4">
            구매내역 <span style="font-size: 16px; color: #aaa;">ⓘ</span>
        </h2>
    </div>

    <div class="order-wrapper">
        <div class="order-header">
            <h2><%=name%>님의 주문목록
            </h2>
            <span class="order-count"><%=orderList.size()%>개의 주문</span>
        </div>

        <form class="order-search-row" method="get" action="orderlistform.jsp">
            <input type="text" name="keyword" placeholder="주문 상품 검색창"
                value="<%=keyword%>">
            <button type="submit" class="btn btn-outline-secondary">검색</button>
            <a href="orderlistform.jsp" class="btn btn-outline-secondary">전체보기</a>
        </form>

        <div class="order-period-row">
            <button class="btn btn-outline-secondary btn-sm">1개월</button>
            <button class="btn btn-outline-secondary btn-sm">3개월</button>
            <button class="btn btn-outline-secondary btn-sm">6개월</button>
            <button class="btn btn-outline-secondary btn-sm">1년</button>
        </div>

        <div class="order-list-section">
<%
boolean hasResult = false;
for (OrderListDto order : orderList) {
    // 키워드 필터링(상품명 소문자, 키워드 소문자 비교)
    List<OrderListDto.OrderItem> filteredItems = new ArrayList<>();
    for (OrderListDto.OrderItem item : order.getItems()) {
        String productName = item.getProductName();
        if (keyword.isEmpty() ||
            (productName != null && productName.toLowerCase().contains(keyword.toLowerCase()))
        ) {
            filteredItems.add(item);
        }
    }
    if(filteredItems.size() == 0) continue; // 이 주문카드에 노출될 상품이 없으면 skip

    hasResult = true;
%>
    <div class="order-box">
        <div class="order-header-bar">
            <span class="order-status-label"> <%=order.getOrderStatus()%>
                / <%=order.getOrderDate()%>
            </span>
            <button class="order-delete-btn"
                onclick="if(confirm('정말로 이 주문을 삭제하시겠습니까?')) { location.href='deleteorder.jsp?order_code=<%=order.getOrderCode()%>' }">주문내역
                삭제</button>
        </div>
        <%
        for (OrderListDto.OrderItem item : filteredItems) {
        %>
        <div class="order-item-box">
            <div class="order-content-row">
                <div class="order-thumb-box">
                    <img
                        src="<%=item.getProductImage() != null ? item.getProductImage() : "https://via.placeholder.com/90x90.png?text=이미지"%>"
                        alt="상품이미지" style="width: 80px; height: 80px; object-fit: cover;">
                </div>
                <div class="order-prod-info">
                    <div class="order-prod-title"><%=item.getProductName()%></div>
                    <div class="order-prod-desc"><%=item.getColor()%>
                        /
                        <%=item.getSize()%></div>
                    <div class="order-prod-price-row">
                        <span class="order-prod-price"> <%=NumberFormat.getInstance().format(item.getPrice())%>원
                        </span>
                        <button class="cart-btn" onclick="alert('장바구니 담기 개발중!')">장바구니에
                            담기</button>
                    </div>
                </div>
                <div class="order-actions-col">
                    <button class="btn btn-outline-secondary btn-sm">주문상세</button>
                    <button class="btn btn-outline-secondary btn-sm">리뷰작성</button>
                    <button class="btn btn-outline-secondary btn-sm">교환/반품</button>
                </div>
            </div>
        </div>
        <%
        }
        %>
    </div>
<%
}
if (!hasResult) { %>
    <div class="empty-order">
        <i class="bi bi-box"></i>
        <p>주문 내역이 없습니다.</p>
        <p>새로운 상품을 구매해보세요.</p>
        <a href="../../index.jsp?main=product/productlist.jsp"
            class="continue-shopping">쇼핑 계속하기</a>
    </div>
<% } %>
        </div>
    </div>
</body>
</html>
