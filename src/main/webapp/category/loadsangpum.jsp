<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    int PerPage = 12;
    int start = (currentPage - 1) * PerPage;
    int end = start + currentPage;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar calendar = Calendar.getInstance();
    calendar.add(Calendar.DATE, -7);
    Date oneWeekAgo = calendar.getTime();

    for (int i = start; i < end; i++) {
        Date regDate = sdf.parse("2025-05-2" + (i % 9 + 1)); // 임시 날짜
        boolean isNew = regDate.after(oneWeekAgo);
%>
    <div class="col-3">
        <div class="product-card">
            <img src="SemiImg/footerLogo.png" class="product-image" style="width: 100%; height: 100%;">
            <div class="product-info">
                <div class="product-company"><b>SSY</b></div>
                <div class="product-name">상품명 <%= i + 1 %></div>
                <% if (isNew) { %>
                    <div class="badge bg-danger">새상품</div>
                <% } %>
                <div class="product-price"><b>99,000원</b></div>
                <i class="bi bi-suit-heart">0</i>
            </div>
        </div>
    </div>
<% } %>
