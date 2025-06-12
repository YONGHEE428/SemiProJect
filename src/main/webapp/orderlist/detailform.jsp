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
.product-simple-box {
	border: 1.5px solid #f1f1f5;
	border-radius: 12px;
	padding: 18px 22px;
	background: #fafbfc;
}
.product-image {
	width: 80px;
	height: 80px;
	border-radius: 8px;
	object-fit: cover;
	border: 1.5px solid #e3e3e3;
	background: #fff;
}
.product-info-area {
	min-width: 0;
}
.product-name {
	font-size: 1.16rem;
	font-weight: bold;
	color: #141414;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.product-option {
	font-size: 1.03rem;
	color: #6b7280;
}
.product-meta {
	font-size: 1.07rem;
	font-weight: 500;
	color: #222;
	letter-spacing: 0.01em;
	margin-top: 1px;
}
.price-strong {
	color: #252525;
	font-weight: bold;
}
.sum-strong {
	color: #52423C;
	font-weight: bold;
}
@media (max-width: 700px) {
	.product-simple-box {
		flex-direction: column;
		padding: 12px 6vw;
	}
	.product-image {
		margin-bottom: 8px;
	}
}

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

		<!-- 배송 정보 -->
		<%
			
		%>
		<div>
			<div class="section-title">배송 정보</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">수령인</div>
				<div class="col-8"><%=payment.getBuyer_name()%></div>
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">연락처</div>
				<div class="col-8"><%=payment.getHp() %></div>
			</div>
			<div class="row mb-2">
				<div class="col-4 text-secondary">주소</div>
				<div class="col-8">
				<%
					// --- 주소 포맷팅 로직 시작 ---
					String fullAddress = payment.getAddr();
					if (fullAddress != null && !fullAddress.isEmpty()) {
						String[] addrParts = fullAddress.split(",", 3); // 최대 3부분으로 분리
						String formattedAddress = "";
						
						if (addrParts.length > 0 && !addrParts[0].trim().isEmpty()) {
							formattedAddress += "[" + addrParts[0].trim() + "]"; // 우편번호에 대괄호
						}
						// 기본 주소와 상세 주소는 띄어쓰기로 연결
						if (addrParts.length > 1 && !addrParts[1].trim().isEmpty()) {
							if (!formattedAddress.isEmpty()) formattedAddress += " "; // 앞에 내용이 있으면 공백 추가
							formattedAddress += addrParts[1].trim(); // 기본 주소
						}
						if (addrParts.length > 2 && !addrParts[2].trim().isEmpty()) {
							if (!formattedAddress.isEmpty()) formattedAddress += " "; // 앞에 내용이 있으면 공백 추가 (쉼표 대신)
							formattedAddress += addrParts[2].trim(); // 상세 주소
						}
						out.print(formattedAddress);
					} else {
						out.print("-"); // 주소 정보가 없을 경우
					}
					// --- 주소 포맷팅 로직 끝 ---
					%>
				</div>
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

		<div class="row mb-2">
			<div class="col-4 text-secondary">주문상태</div>
			<div class="col-8">
				<span class="badge <%=badgeClass%>"><%=status%></span>

			</div>
		</div>
	</div>
	<!-- 주문 상품 상세 (1개) -->
	<div>
	<div>
	
	<div class="section-title">주문 상품</div>
<div class="product-simple-box d-flex align-items-center mb-4">
    <!-- 이미지 -->
    <img src="<%=item.getProductImage()%>" class="product-image me-4" alt="상품 이미지">
    <!-- 상품 정보 -->
    <div class="product-info-area flex-grow-1">
        <div class="product-name mb-1"><%=item.getProductName()%></div>
        <div class="product-option mb-1"><%=item.getColor()%> / <%=item.getSize()%></div>
        <div class="product-meta">
            수량: <b><%=item.getCnt()%></b>
            &nbsp;|&nbsp; 단가: <b><span class="price-strong"><%=nf.format(item.getPrice())%>원</span></b>
            &nbsp;|&nbsp; 총 금액: <b><span class="sum-strong"><%=nf.format(item.getPrice() * item.getCnt())%>원</span></b>
        </div>
    </div>
</div>



</div>

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
