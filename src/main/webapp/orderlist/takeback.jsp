<%@page import="data.dto.PaymentDto"%>
<%@page import="data.dto.OrderListDto"%>
<%@page import="data.dao.PaymentDao"%>
<%@page import="data.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반품 접수</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8f9fa;
}

.return-container {
	max-width: 520px;
	margin: 40px auto 50px auto;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 2px 16px rgba(0, 0, 0, 0.05);
	padding: 30px 28px 32px 28px;
}

.return-title {
	font-size: 1.4rem;
	font-weight: bold;
	margin-bottom: 23px;
	color: #222;
}

.section-title {
	font-size: 1.09rem;
	font-weight: 600;
	margin-top: 28px;
	margin-bottom: 12px;
	color: #252525;
}

.return-option-box {
	background: #fafafa;
	border: 1.5px solid #ececec;
	border-radius: 8px;
	padding: 16px 18px 13px 18px;
	margin-bottom: 14px;
}

.return-option-label {
	font-size: 1.02rem;
	font-weight: 500;
	margin-bottom: 8px;
	display: block;
	color: #666;
}

.form-check {
	margin-bottom: 7px;
}

.return-info-row {
	display: flex;
	gap: 10px;
	margin-bottom: 10px;
	align-items: center;
}

.return-info-row label {
	width: 90px;
	color: #777;
	font-size: 0.98rem;
	margin-bottom: 0;
}

.return-info-value {
	font-size: 1.04rem;
}

.return-summary-box {
	background: #f7f8fa;
	border-radius: 10px;
	padding: 18px 15px 10px 15px;
	margin-top: 32px;
	font-size: 1.02rem;
}

.return-summary-box table {
	width: 100%;
}

.return-summary-box td, .return-summary-box th {
	padding: 5px 0;
	font-size: 1.03rem;
}

.return-summary-box th {
	color: #555;
	font-weight: 500;
	width: 90px;
}

.return-summary-box .total-refund {
	color: #e04a2e;
	font-weight: bold;
	font-size: 1.15rem;
}

.return-summary-box .summary-title {
	font-weight: 600;
	color: #222;
	border-bottom: 1px solid #eee;
	padding-bottom: 5px;
	margin-bottom: 7px;
	font-size: 1.06rem;
}

.btn-primary {
	width: 100%;
	padding: 11px 0;
	font-size: 1.09rem;
	margin-top: 27px;
	border-radius: 7px;
	font-weight: 600;
}

.product-info-row {
	display: flex;
	align-items: center;
	gap: 18px;
	border: 1px solid #eee;
	border-radius: 10px;
	margin-bottom: 13px;
	background: #fff;
	padding: 8px 8px;
}

.product-info-row img {
	width: 80px;
	height: 80px;
	border-radius: 7px;
	object-fit: cover;
	border: 1px solid #ddd;
}
</style>
</head>
<%
String orderIdStr = request.getParameter("order_id");
String paymentIdxStr = request.getParameter("payment_idx");

int orderId = Integer.parseInt(orderIdStr);

OrderListDao orderDao = new OrderListDao();
PaymentDao paymentDao = new PaymentDao();

OrderListDto order = orderDao.getOrderDetailByOrderId(orderId);
PaymentDto payment = paymentDao.getPaymentByIdx(paymentIdxStr);

// 환불 예정 금액, 배송비 계산 예시
int amount = payment.getAmount();
int deliveryFee = (amount >= 100000) ? 0 : 3000;
int totalRefund = amount; // 필요시 -반품비 등 계산 추가
%>
<body>
	<div class="return-container">
		<div class="return-title">반품 접수</div>

		<form method="post" action="takebackaction.jsp">
			<input type="hidden" name="order_id" value="<%=orderId%>"> <input
				type="hidden" name="payment_idx" value="<%=payment.getIdx()%>">

			<!-- 상품 정보 표시 -->
			<div class="section-title">반품 상품 정보</div>
			<%
			for (OrderListDto.OrderItem item : order.getItems()) {
			%>
			<div class="product-info-row">
				<img
					src="<%=item.getProductImage() != null ? item.getProductImage()
		: "https://via.placeholder.com/80x80.png?text=No+Image"%>"
					alt="상품 이미지">
				<div>
					<div style="font-weight: bold; font-size: 1.07rem;"><%=item.getProductName()%></div>
					<div style="color: #888; font-size: 0.96rem;">
						옵션:
						<%=item.getColor()%>
						/
						<%=item.getSize()%>
						<span style="margin-left: 10px;">수량: <%=item.getCnt()%></span>
					</div>
					<div style="margin-top: 3px; color: #222;">
						가격:
						<%=String.format("%,d 원", item.getPrice())%>
					</div>
				</div>
			</div>
			<%
			}
			%>

			<!-- 회수, 환불 정보 -->
			<div class="section-title">회수, 환불 정보를 확인해 주세요</div>
			<div class="return-info-row">
				<label>상품 회수지</label> <span class="return-info-value"><%=payment.getAddr()%></span>
				<a href="#"
					style="font-size: 0.96em; margin-left: 10px; color: #247;"
					onclick="alert('주소 변경은 고객센터로 문의하세요'); return false;">변경</a>
			</div>
			<div class="return-info-row">
				<label>연락처</label> <span class="return-info-value"><%=payment.getHp()%></span>
			</div>
			<div class="return-info-row">
				<label>수령인</label> <span class="return-info-value"><%=request.getSession().getAttribute("name")%></span>
			</div>
			<!-- 나머지 폼 내용(회수일 등은 동일) -->

			<!-- 환불 안내 -->
			<div class="return-summary-box">
				<div class="summary-title">환불 안내</div>
				<table>
					<tr>
						<th>상품금액</th>
						<td><%=String.format("%,d 원", payment.getAmount())%></td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><%=String.format("%,d 원", deliveryFee)%></td>
					</tr>
					<tr>
						<th>반품비</th>
						<td>3000 원</td>
					</tr>
					<tr>
						<th style="border-top: 1.2px solid #eee; padding-top: 9px;"
							class="total-refund">환불 예정금액</th>
						<td
							style="color: #e04a2e; font-weight: bold; border-top: 1.2px solid #eee; padding-top: 9px;"
							class="total-refund"><%=String.format("%,d 원", totalRefund)%></td>
					</tr>
					<tr>
						<th>환불 수단</th>
						<td>신용카드</td>
					</tr>
				</table>
			</div>
			<button type="submit" class="btn btn-primary">반품 신청하기</button>
		</form>
	</div>
</body>
</html>
