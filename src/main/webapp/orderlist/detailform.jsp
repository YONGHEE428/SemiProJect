<%@page import="java.util.TimeZone"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.OrderListDto"%>
<%@page import="data.dao.OrderListDao"%>
<%@page import="data.dto.PaymentDto"%>
<%@page import="data.dao.PaymentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String orderSangpumIdStr = request.getParameter("order_sangpum_id");
if (orderSangpumIdStr == null) {
    response.sendRedirect(request.getContextPath() + "/orderlist/orderlistform.jsp");
    return;
}
int orderSangpumId = Integer.parseInt(orderSangpumIdStr);

OrderListDao orderDao = new OrderListDao();
OrderListDto.OrderItem item = orderDao.getOrderItemDetailById(orderSangpumId);

if (item == null) {
    response.sendRedirect(request.getContextPath() + "/orderlist/orderlistform.jsp");
    return;
}

PaymentDao paymentDao = new PaymentDao();
PaymentDto payment = paymentDao.getPaymentByOrderCode(item.getOrderCode());

NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));

// 상태별 컬러
String status = item.getStatus();
String badgeClass = "bg-secondary";
if ("주문접수".equals(status)) badgeClass = "bg-info";
else if ("결제완료".equals(status)) badgeClass = "bg-success";
else if ("배송중".equals(status)) badgeClass = "bg-primary";
else if ("배송완료".equals(status)) badgeClass = "bg-secondary";
else if ("반품접수".equals(status)) badgeClass = "bg-danger";
else if ("구매확정".equals(status)) badgeClass = "bg-warning text-dark";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body { background: #f8f9fa; }
.order-container {
	max-width: 700px; margin: 40px auto;
	background: #fff; border-radius: 20px;
	box-shadow: 0 4px 16px rgba(0,0,0,0.07);
	padding: 30px;
}
.order-title { font-size: 2rem; font-weight: bold; }
.section-title { font-size: 1.2rem; font-weight: bold; margin-top: 30px; }
.table th, .table td { vertical-align: middle; }
</style>
</head>
<body>
<div class="order-container">
	<div class="mb-4 d-flex justify-content-between align-items-center">
		<span class="order-title"><i class="bi bi-receipt"></i> 주문 상세</span>
		<a href="javascript:window.history.back()" class="btn btn-outline-secondary btn-sm"><i class="bi bi-list"></i> 주문목록</a>
	</div>
	<!-- 주문 정보 -->
	<div>
		<div class="section-title">주문 정보</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">주문번호</div>
			<div class="col-8"><%=item.getOrderCode()%></div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">주문일시</div>
			<div class="col-8">
				<% if (item.getOrderDate() != null) { %>
					<%=sdf.format(item.getOrderDate())%>
				<% } else { %> - <% } %>
			</div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">주문자</div>
			<div class="col-8"><%=item.getMemberName()%></div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">주문상태</div>
			<div class="col-8">
				<span class="badge <%=badgeClass%>"><%=status%></span>
			</div>
		</div>
	</div>
	<!-- 주문 상품 상세 (1개) -->
	<div>
		<div class="section-title">주문 상품</div>
		<table class="table table-bordered">
			<tr>
				<th style="width: 90px;">이미지</th>
				<td><img src="<%=item.getProductImage()%>" style="width:70px;height:70px;object-fit:cover;"></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><%=item.getProductName()%></td>
			</tr>
			<tr>
				<th>색상/사이즈</th>
				<td><%=item.getColor()%> / <%=item.getSize()%></td>
			</tr>
			<tr>
				<th>수량</th>
				<td><%=item.getCnt()%></td>
			</tr>
			<tr>
				<th>단가</th>
				<td><%=nf.format(item.getPrice())%>원</td>
			</tr>
			<tr>
				<th>합계</th>
				<td><%=nf.format(item.getPrice() * item.getCnt())%>원</td>
			</tr>
			<tr>
				<th>상품상태</th>
				<td><span class="badge <%=badgeClass%>"><%=status%></span></td>
			</tr>
		</table>
	</div>
	<!-- 배송 정보 -->
	<div>
		<div class="section-title">배송 정보</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">수령인</div>
			<div class="col-8"><%=item.getMemberName()%></div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">연락처</div>
			<div class="col-8"><%=payment.getHp() %></div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">주소</div>
			<div class="col-8"><%=payment.getAddr()%></div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">배송메시지</div>
			<div class="col-8"><%=payment.getDelivery_msg()%></div>
		</div>
	</div>
	<!-- 결제 정보 -->
	<div>
		<div class="section-title">결제 정보</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">결제수단</div>
			<div class="col-8">신용카드</div>
		</div>
		<div class="row mb-2">
			<div class="col-4 text-secondary">결제상태</div>
			<div class="col-8">
				<span class="badge bg-success"><%=payment.getStatus()%></span>
			</div>
		</div>
	</div>
</div>
</body>
</html>
