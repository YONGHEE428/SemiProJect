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
<title>Insert title here</title>
<style>
body {
	background: #f8f8f8;
}

.order-container {
	max-width: 900px;
	margin: 40px auto;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 2px 8px #eee;
	padding: 40px 30px;
}

.order-title {
	font-size: 2rem;
	font-weight: bold;
	margin-bottom: 20px;
}

.order-search {
	margin-bottom: 30px;
}

.order-search input {
	width: 100%;
	max-width: 400px;
}

.order-period-btns {
	margin-bottom: 20px;
}

.order-period-btns .btn {
	margin-right: 8px;
	margin-bottom: 8px;
}

.order-list {
	margin-top: 20px;
}

.order-box {
	border: 2px solid #bbb;
	border-radius: 15px;
	padding: 20px;
	margin-bottom: 25px;
	background: #fafafa;
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.order-status {
	font-weight: bold;
	color: #555;
}

.order-delete {
	color: #e55;
	font-size: 1rem;
	border: none;
	background: none;
}

.order-content {
	display: flex;
	align-items: flex-start;
	gap: 20px;
}

.order-img {
	width: 90px;
	height: 90px;
	object-fit: cover;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.order-info {
	flex: 1;
}

.order-name {
	font-weight: bold;
	font-size: 1.1rem;
	margin-bottom: 8px;
}

.order-price {
	color: #333;
	margin-bottom: 8px;
}

.order-cart-btn {
	margin-left: 10px;
}

.order-actions {
	display: flex;
	flex-direction: column;
	gap: 7px;
}

.order-actions .btn {
	font-size: 0.95rem;
}

@media ( max-width : 700px) {
	.order-container {
		padding: 15px 5px;
	}
	.order-content {
		flex-direction: column;
		gap: 10px;
	}
	.order-actions {
		flex-direction: row;
		gap: 7px;
		margin-top: 10px;
	}
}
</style>
</head>
<body>
	<div class="order-container">
		<!-- 주문목록 타이틀 -->
		<div class="order-title">주문목록</div>
		<!-- 검색창 -->
		<div class="order-search mb-3">
			<input type="text" class="form-control" placeholder="주문 상품 검색창">
		</div>
		<!-- 기간 버튼 -->
		<div class="order-period-btns mb-4">
			<button class="btn btn-outline-secondary btn-sm">1개월</button>
			<button class="btn btn-outline-secondary btn-sm">3개월</button>
			<button class="btn btn-outline-secondary btn-sm">6개월</button>
			<button class="btn btn-outline-secondary btn-sm">1년</button>
		</div>
		<!-- 주문목록 리스트 (샘플 4개) -->
		<div class="order-list">
			<!-- 주문 1개 -->
			<div class="order-box">
				<div class="order-header">
					<span class="order-status">배송완료 / 5/10 목 도착</span>
					<button class="order-delete">주문내역 삭제</button>
				</div>
				<div class="order-content">
					<img src="https://via.placeholder.com/90x90.png?text=상품이미지"
						class="order-img">
					<div class="order-info">
						<div class="order-name">상품이름</div>
						<div class="order-price">가격: 20,000원</div>
						<button class="btn btn-outline-primary btn-sm order-cart-btn">장바구니에
							담기</button>
					</div>
					<div class="order-actions">
						<button class="btn btn-outline-secondary btn-sm">주문상세</button>
						<button class="btn btn-outline-secondary btn-sm">배송조회</button>
						<button class="btn btn-outline-secondary btn-sm">교환/반품</button>
					</div>
				</div>
			</div>
			<!-- 주문 2개 -->
			<div class="order-box">
				<div class="order-header">
					<span class="order-status">배송완료 / 5/13 목 도착</span>
					<button class="order-delete">주문내역 삭제</button>
				</div>
				<div class="order-content">
					<img src="https://via.placeholder.com/90x90.png?text=상품이미지"
						class="order-img">
					<div class="order-info">
						<div class="order-name">상품이름</div>
						<div class="order-price">가격: 15,000원</div>
						<button class="btn btn-outline-primary btn-sm order-cart-btn">장바구니에
							담기</button>
					</div>
					<div class="order-actions">
						<button class="btn btn-outline-secondary btn-sm">주문상세</button>
						<button class="btn btn-outline-secondary btn-sm">배송조회</button>
						<button class="btn btn-outline-secondary btn-sm">교환/반품</button>
					</div>
				</div>
			</div>
			<!-- 주문 3개 -->
			<div class="order-box">
				<div class="order-header">
					<span class="order-status">배송완료 / 5/17 목 도착</span>
					<button class="order-delete">주문내역 삭제</button>
				</div>
				<div class="order-content">
					<img src="https://via.placeholder.com/90x90.png?text=상품이미지"
						class="order-img">
					<div class="order-info">
						<div class="order-name">상품이름</div>
						<div class="order-price">가격: 30,000원</div>
						<button class="btn btn-outline-primary btn-sm order-cart-btn">장바구니에
							담기</button>
					</div>
					<div class="order-actions">
						<button class="btn btn-outline-secondary btn-sm">주문상세</button>
						<button class="btn btn-outline-secondary btn-sm">배송조회</button>
						<button class="btn btn-outline-secondary btn-sm">교환/반품</button>
					</div>
				</div>
			</div>
			<!-- 주문 4개 -->
			<div class="order-box">
				<div class="order-header">
					<span class="order-status">배송완료 / 5/20 목 도착</span>
					<button class="order-delete">주문내역 삭제</button>
				</div>
				<div class="order-content">
					<img src="https://via.placeholder.com/90x90.png?text=상품이미지"
						class="order-img">
					<div class="order-info">
						<div class="order-name">상품이름</div>
						<div class="order-price">가격: 25,000원</div>
						<button class="btn btn-outline-primary btn-sm order-cart-btn">장바구니에
							담기</button>
					</div>
					<div class="order-actions">
						<button class="btn btn-outline-secondary btn-sm">주문상세</button>
						<button class="btn btn-outline-secondary btn-sm">배송조회</button>
						<button class="btn btn-outline-secondary btn-sm">교환/반품</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>