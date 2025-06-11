<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.OrderListDto"%>
<%@page import="data.dao.OrderListDao"%>
<%@page import="data.dto.PaymentDto"%>
<%@page import="data.dao.PaymentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String orderCode = request.getParameter("order_code"); // URL에서 주문번호 받기

OrderListDao orderDao = new OrderListDao();
PaymentDao paymentDao = new PaymentDao();

OrderListDto order = orderDao.getOrderDetailByCode(orderCode);
PaymentDto payment = paymentDao.getPaymentByOrderCode(orderCode);

// 주문 정보가 없는 경우 처리
if (order == null || payment == null) {
	response.sendRedirect(request.getContextPath() + "/orderlist/orderlistform.jsp");
	return;
}

NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 (목데이터 예시)</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body {
	background: #f8f9fa;
}

.order-container {
	max-width: 800px;
	margin: 40px auto;
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.07);
	padding: 30px;
}

.order-title {
	font-size: 2rem;
	font-weight: bold;
}

.section-title {
	font-size: 1.2rem;
	font-weight: bold;
	margin-top: 30px;
}

.table th, .table td {
	vertical-align: middle;
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
</style>
</head>
<body>
	<div class="order-container">
		<div class="mb-4 d-flex justify-content-between align-items-center">
			<span class="order-title"><i class="bi bi-receipt"></i> 주문 상세</span>
			<a onclick="location.href='index.jsp?main=orderlist/orderlistform.jsp'" class="btn btn-outline-secondary btn-sm"><i
				class="bi bi-list"></i> 주문목록</a>
		</div>
		<!-- 주문 기본 정보 -->
		<!-- 주문 기본 정보 -->
		<div>
			<div class="section-title">주문정보</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">주문번호</div>
				<div class="col-8"><%=orderCode%></div>
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">주문일시</div>
				<div class="col-8">
					<%
					if (order.getOrderDate() != null) {
					%>
					<%=sdf.format(order.getOrderDate())%>
					<%
					} else {
					%>
					-
					<%
					}
					%>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">주문자</div>
				<div class="col-8"><%=order.getMemberName()%></div>
				<!-- 수정: 이름 -->
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">주문상태</div>
				<div class="col-8">
					<span class="badge bg-info"><%=order.getOrderStatus()%></span>
				</div>
			</div>
		</div>

		<!-- 상품 목록 -->
		<div>
			<div class="section-title">주문 상품</div>
			<table class="table table-bordered align-middle">
				<thead class="table-light">
					<tr>
						<th style="width: 120px">이미지</th>
						<th>상품정보</th>
						<th>수량</th>
						<th>가격</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (order.getItems() != null && !order.getItems().isEmpty()) {%>
					<%
					for (OrderListDto.OrderItem item : order.getItems()) {
					%>
					<tr>
						<td><img src="<%=item.getProductImage()%>"
							alt="<%=item.getProductName()%>"
							style="width: 65px; height: 65px; object-fit: cover; border-radius: 8px;">
						</td>
						<td>
							<div style="font-weight: 600;"><%=item.getProductName()%></div>
							<div style="font-size: 0.95em; color: #666; margin-top: 3px;">
								<%
								if (item.getColor() != null && !item.getColor().isEmpty()) {%>
								색상:
								<%=item.getColor()%>&nbsp;
								<%
								}%><%
								if (item.getSize() != null && !item.getSize().isEmpty()) {%>
								/ 사이즈:
								<%=item.getSize()%>
								<%}%>
							</div>
						</td>
						<td><%=item.getCnt()%></td>
						<td><%=nf.format(item.getPrice())%>원</td>
						<td><%=nf.format(item.getPrice() * item.getCnt())%>원</td>
					</tr>
					<%
					}%>
					<%} else {%>
					<tr>
						<td colspan="5" class="text-center">주문 상품 정보가 없습니다.</td>
					</tr>
					<%}%>
				</tbody>
				<tfoot>
					<%
					int total = 0;
					for (OrderListDto.OrderItem item : order.getItems()) {
						total += item.getPrice() * item.getCnt();
					}%>
					<tr>
						<th colspan="3" class="text-end">총 결제금액</th>
						<th class="text-danger"><%=nf.format(total)%>원</th>
					</tr>
				</tfoot>
			</table>
		</div>

		<!-- 배송 정보 -->
		<div>
			<div class="section-title">배송 정보</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">수령인</div>
				<div class="col-8"><%=order.getMemberName()%></div>
				<!-- 수정: 이름 -->
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">연락처</div>
				<div class="col-8"><%=payment.getHp()%></div>
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
		<!-- 하단 버튼 -->
		<div class="mt-4 text-end">
			<button class="order-delete-btn"
						onclick="if(confirm('정말로 이 주문을 삭제하시겠습니까?')) { location.href='deleteorder.jsp?order_code=<%=order.getOrderCode()%>' }">주문내역 삭제</button>
		</div>
	</div>
</body>
</html>