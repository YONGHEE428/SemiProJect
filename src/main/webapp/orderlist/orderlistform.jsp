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
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">	
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>주문 목록</title>
<style>
body {
    background: #f8f8f8;
}
.order-wrapper {
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    border: 1px solid #444;
    padding: 30px 25px;
}
.order-title-bar {
    background: #f5f5f5;
    border: 1px solid #aaa;
    border-radius: 4px;
    padding: 10px 20px;
    font-weight: bold;
    font-size: 1.15rem;
    margin-bottom: 22px;
    display: inline-block;
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
.order-list-section {
    margin-top: 14px;
}
.order-box {
    border: 2px solid #bbb;
    border-radius: 15px;
    padding: 19px 22px 14px 22px;
    margin-bottom: 22px;
    background: #fafafa;
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
    width: 92px; height: 92px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 6px;
    background: #fff;
    font-size: 0.97rem; color: #666;
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
@media (max-width: 700px) {
    .order-wrapper { padding: 12px 2px; }
    .order-content-row { flex-direction: column; gap: 8px; }
    .order-actions-col { flex-direction: row; gap: 7px; }
}
</style>
</head>
<%
String memberId = (String) session.getAttribute("myid");
String name = (String) session.getAttribute("name");

if (memberId == null) {
    response.sendRedirect("../login/loginform.jsp");
    return;
}

MemberDao memberDao = new MemberDao();
int memberNum = memberDao.getMemberNumById(memberId);

OrderListDao dao = new OrderListDao();
List<OrderListDto> orderList = dao.getOrdersByMember(memberNum);

String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
%>
<body>
<div class="order-wrapper">
    <!-- 상단 타이틀 -->
    <div class="order-title-bar"><%=name%>님의 주문목록</div>
    <!-- 검색창/버튼 row -->
    <form class="order-search-row" method="get">
        <input type="text" name="keyword" placeholder="주문 상품 검색창" value="<%=keyword%>">
        <button type="submit" class="btn btn-outline-secondary">검색</button>
        <a href="orderlistform.jsp" class="btn btn-outline-secondary">전체조회</a>
    </form>
    <!-- 기간 버튼 row -->
    <div class="order-period-row">
        <button class="btn btn-outline-secondary btn-sm">1개월</button>
        <button class="btn btn-outline-secondary btn-sm">3개월</button>
        <button class="btn btn-outline-secondary btn-sm">6개월</button>
        <button class="btn btn-outline-secondary btn-sm">1년</button>
    </div>
    <!-- 주문목록 반복영역 -->
    <div class="order-list-section">
    <%
    boolean hasResult = false;
    for (OrderListDto order : orderList) {
        boolean matchFound = false;
        // 검색어 있을 때 필터링 (상품명 기준)
        for (OrderListDto.OrderItem item : order.getItems()) {
            String productName = item.getProductName();
            if (productName != null && productName.contains(keyword)) {
                matchFound = true;
                break;
            }
        }
        if (!keyword.isEmpty() && !matchFound) continue;
        hasResult = true;
    %>
        <div class="order-box">
            <div class="order-header-bar">
                <span class="order-status-label">
                    배송완료 / <%= order.getOrderDate() %> 도착
                </span>
                <button class="order-delete-btn" onclick="alert('삭제 기능은 개발중!')">주문내역 삭제</button>
            </div>
            <!-- 주문상품 반복 출력 -->
            <%
            for (OrderListDto.OrderItem item : order.getItems()) {
            %>
            <div class="order-content-row">
                <div class="order-thumb-box">
                    <img src="<%= item.getProductImage() != null ? item.getProductImage() : "https://via.placeholder.com/90x90.png?text=이미지" %>"
                        alt="상품이미지" style="width: 80px; height: 80px; object-fit: cover;">
                </div>
                <div class="order-prod-info">
                    <div class="order-prod-title"><%= item.getProductName() %></div>
                    <div class="order-prod-desc"><%= item.getColor() %> / <%= item.getSize() %></div>
                    <div class="order-prod-price-row">
                        <span class="order-prod-price">
                            <%= NumberFormat.getInstance().format(item.getPrice()) %>원
                        </span>
                        <button class="cart-btn" onclick="alert('장바구니 담기 개발중!')">장바구니에 담기</button>
                    </div>
                </div>
                <div class="order-actions-col">
                    <button class="btn btn-outline-secondary btn-sm">주문상세</button>
                    <button class="btn btn-outline-secondary btn-sm">리뷰작성</button>
                    <button class="btn btn-outline-secondary btn-sm">교환/반품</button>
                </div>
            </div>
            <% } %>
        </div>
    <% } // for orderList
    if (!hasResult) { %>
        <div class="alert alert-warning">주문 내역이 없습니다.</div>
    <% } %>
    </div>
</div>
</body>
</html>
