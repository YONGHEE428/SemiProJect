<%@page import="data.dto.PaymentDto"%>
<%@page import="data.dto.OrderListDto"%>
<%@page import="data.dao.PaymentDao"%>
<%@page import="data.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반품 접수</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
	background: #f8f9fa;
}
.return-container {
	max-width: 660px;
	margin: 40px auto 50px auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 18px rgba(0, 0, 0, 0.06);
	padding: 38px 40px 38px 40px;
}
.return-title {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 26px;
	color: #1e2227;
}
.section-title {
	font-size: 1.13rem;
	font-weight: 700;
	margin-top: 34px;
	margin-bottom: 16px;
	color: #2b2b2b;
}
.product-info-row {
	display: flex;
	align-items: center;
	gap: 24px;
	border: 1px solid #f2f2f2;
	border-radius: 11px;
	margin-bottom: 19px;
	background: #fafbfc;
	padding: 13px 15px;
}
.product-info-row img {
	width: 96px;
	height: 96px;
	border-radius: 8px;
	object-fit: cover;
	border: 1.5px solid #e3e3e3;
}
.product-info-detail {
	flex: 1;
	min-width: 0;
}
.product-info-detail .name {
	font-weight: bold;
	font-size: 1.13rem;
	color: #1d1d1d;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.product-info-detail .option {
	color: #8b8b8b;
	font-size: 1rem;
	margin-top: 3px;
}
.product-info-detail .price {
	margin-top: 5px;
	color: #2b2b2b;
	font-size: 1.06rem;
}
.return-info-row {
	display: flex;
	align-items: center;
	gap: 16px;
	margin-bottom: 15px;
}
.return-info-row label {
	flex: 0 0 96px;
	color: #777;
	font-size: 1rem;
	margin-bottom: 0;
	font-weight: 500;
}
.return-info-value {
	font-size: 1.07rem;
	flex: 1;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.change-link {
	font-size: 0.99em;
	color: #3576d0;
	margin-left: 14px;
	cursor: pointer;
}
.return-summary-box {
	background: #f8fafc;
	border-radius: 13px;
	padding: 24px 21px 13px 21px;
	margin-top: 36px;
	font-size: 1.09rem;
}
.return-summary-box table {
	width: 100%;
}
.return-summary-box td, .return-summary-box th {
	padding: 6px 0;
	font-size: 1.09rem;
}
.return-summary-box th {
	color: #545454;
	font-weight: 600;
	width: 110px;
}
.return-summary-box .total-refund {
	color: #e04a2e;
	font-weight: bold;
	font-size: 1.2rem;
}
.return-summary-box .summary-title {
	font-weight: 700;
	color: #1d1d1d;
	border-bottom: 1px solid #e6e6e6;
	padding-bottom: 7px;
	margin-bottom: 10px;
	font-size: 1.12rem;
}
.btn-primary {
	width: 100%;
	padding: 13px 0;
	font-size: 1.12rem;
	margin-top: 32px;
	border-radius: 8px;
	font-weight: 700;
}
@media (max-width: 700px) {
	.return-container { max-width: 98vw; padding: 16px 4vw; }
	.product-info-row { flex-direction: column; gap: 8px; align-items: flex-start;}
	.return-info-row { flex-direction: column; align-items: flex-start; gap: 2px;}
	.return-info-row label { width: auto; }
}
.return-summary-box td, .return-summary-box th {
	padding: 6px 0;
	font-size: 1.09rem;
}
.return-summary-box td {
	text-align: right;  /* 금액 오른쪽 정렬 */
}

</style>
</head>
<%
System.out.println("[페이지명.jsp] session member_num = " + session.getAttribute("member_num"));
String orderSangpumIdStr = request.getParameter("order_sangpum_id");
String orderIdStr = request.getParameter("order_id");
String paymentIdxStr = request.getParameter("payment_idx");
if (orderSangpumIdStr == null || orderIdStr == null || paymentIdxStr == null) {
	out.print("<script>alert('잘못된 접근입니다.');history.back();</script>");
	return;
}
int orderSangpumId = Integer.parseInt(orderSangpumIdStr);
int orderId = Integer.parseInt(orderIdStr);
OrderListDao orderDao = new OrderListDao();
PaymentDao paymentDao = new PaymentDao();
OrderListDto order = orderDao.getOrderDetailByOrderId(orderId);
PaymentDto payment = paymentDao.getPaymentByIdx(paymentIdxStr);
// 주문상품 한 건만 추출
OrderListDto.OrderItem orderItem = null;
for (OrderListDto.OrderItem item : order.getItems()) {
	if (item.getOrderSangpumId() == orderSangpumId) {
		orderItem = item;
		break;
	}
}
if (orderItem == null) {
	out.print("<script>alert('상품 정보가 없습니다.');history.back();</script>");
	return;
}
int amount = orderItem.getPrice(); // 상품 1개 가격(수량*단가)
int deliveryFee = (payment.getAmount() >= 100000) ? 0 : 3000;
int totalRefund = Math.max(amount - deliveryFee, 0);
%>
<body>
	<div class="return-container">
		<div class="return-title">반품 접수</div>
		<form method="post" action="takebackaction.jsp">
			<input type="hidden" name="order_id" value="<%=orderId%>"> 
			<input type="hidden" name="payment_idx" value="<%=payment.getIdx()%>">
			<input type="hidden" name="order_sangpum_id" value="<%=orderSangpumId%>">
			<input type="hidden" name="refund_amount" value="<%=totalRefund%>">
			<input type="hidden" name="pickup_date" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
			<input type="hidden" name="pickup_place" value="<%=payment.getAddr()%>">
			<input type="hidden" name="receiver_hp" value="<%=payment.getHp()%>">
			<input type="hidden" name="receiver_addr" value="<%=payment.getAddr()%>">
			<!-- 상품 정보 표시 -->
			<div class="section-title">반품 상품 정보</div>
			<div class="product-info-row">
				<img src="<%=orderItem.getProductImage() != null ? orderItem.getProductImage() : "https://via.placeholder.com/96x96.png?text=No+Image"%>" alt="상품 이미지">
				<div class="product-info-detail">
					<div class="name"><%=orderItem.getProductName()%></div>
					<div class="option">
						옵션: <%=orderItem.getColor()%> / <%=orderItem.getSize()%>
						<span style="margin-left: 13px;">수량: <%=orderItem.getCnt()%></span>
					</div>
					<div class="price">가격: <%=String.format("%,d 원", orderItem.getPrice())%></div>
				</div>
			</div>
			<!-- 회수, 환불 정보 -->
			<div class="section-title">회수 · 환불 정보</div>
			<div class="return-info-row">
				<label>상품 회수지</label>
				<span class="return-info-value"><%=payment.getAddr()%></span>
				<a href="#" class="change-link" onclick="alert('주소 변경은 고객센터로 문의하세요'); return false;">변경</a>
			</div>
			<div class="return-info-row">
				<label>연락처</label>
				<span class="return-info-value"><%=payment.getHp()%></span>
			</div>
			<div class="return-info-row">
				<label>수령인</label>
				<span class="return-info-value"><%=request.getSession().getAttribute("name")%></span>
			</div>
			<!-- 환불 안내 -->
			<div class="return-summary-box">
				<div class="summary-title">환불 안내</div>
				<table>
					<tr>
						<th>상품금액</th>
						<td><%=String.format("%,d 원", amount)%></td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><%=String.format("%,d 원", deliveryFee)%></td>
					</tr>
					<tr>
						<th style="border-top: 1.2px solid #eee; padding-top: 11px; width: 150px;" class="total-refund">환불 예정금액</th>
						<td style="color: #e04a2e; font-weight: bold; border-top: 1.2px solid #eee; padding-top: 11px;" class="total-refund">
							<%=String.format("%,d 원", totalRefund)%>
						</td>
					</tr>
				</table>
			</div>
			<button type="submit" class="btn btn-primary">반품 신청하기</button>
		</form>
	</div>
</body>
</html>
