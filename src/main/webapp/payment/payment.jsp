<%@page import="data.dao.PaymentDao"%>
<%@page import="data.dto.PaymentDto"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dao.CartListDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.dto.CartListDto"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.catalina.Context"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nanum+Myeongjo&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"> -->
	<link rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 다음 주소창api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript"
	src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>결제하기</title>
<style>
/* 전역 스타일 */
* {
	margin: 0;
	padding: 0;
	/* padding, border를 포함한 전체 너비로 계산
				→ 요소가 width: 100px이면 padding 10px 포함해도 100px 유지됨 */
	box-sizing: border-box;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	/* 텍스트 줄간격 (기본: 1.0). 1.6이면 텍스트 간 간격이 넓어짐 */
	line-height: 1.6;
	color: #333;
	background-color: #f8f9fa;
}
/* 헤더 스타일 */
.top-header {
	background-color: #fff;
	padding: 1rem 2rem;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	z-index: 1000;
	/* display block: 한 줄 전체 차지
			   inline: 내용 크기만큼 차지
			   flex: 유연하게 정렬, 가로/세로 배치 가능
			   grid: 격자 형태 배치 */
	display: flex;
	/* space-between: 양 끝 정렬, 중간은 균등 간격 */
	justify-content: space-between;
	/* align-items 세로축 정렬, center: 세로 가운데 정렬 */
	align-items: center;
}

.left-section {
	display: flex;
	align-items: center;
	/* Flex/Grid 자식 요소 사이 간격 */
	gap: 2rem;
}

.slide-menu-btn {
	background: none;
	border: none;
	cursor: pointer;
	padding: 0.5rem;
}

.slide-menu-btn span {
	display: block;
	width: 24px;
	height: 2px;
	background-color: #333;
	margin: 4px 0;
	/* 애니메이션 0.3초후 시작 */
	transition: 0.3s;
}

.shop-name {
	font-size: 1.8rem;
	font-weight: 700;
	color: #2c3e50;
	margin: 0;
}

.user-menu {
	display: flex;
	gap: 1.5rem;
	align-items: center;
	margin: 0;
	font-size: 12px;
}

.user-menu a {
	text-decoration: none;
	color: #2c3e50;
	font-weight: 500;
	transition: color 0.3s;
}

/* 컨테이너 스타일 */
.container {
	max-width: 1200px;
	/* auto:좌우여백 자동설정,가운데 정렬 */
	margin: 2rem auto;
	padding: 0 1.5rem;
}

/* 카드 스타일 */
.card {
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 4px 25px rgba(0, 0, 0, 0.05);
	padding: 2.5rem;
	margin-bottom: 2rem;
	border: none;
	transition: transform 0.3s ease;
}

.card:hover {
	/* 요소를 Y축으로 -5px만큼 이동 */
	transform: translateY(-5px);
}

/* 섹션 타이틀 */
.section-title {
	font-size: 2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 2rem;
	position: relative;
	padding-bottom: 1rem;
}

/* 폼 스타일 */
.form-floating {
	margin-bottom: 1.5rem;
}

.form-control, .form-select {
	height: 3.5rem;
	border-radius: 12px;
	border: 2px solid #e9ecef;
	padding: 1rem 1.25rem;
	font-size: 1rem;
	transition: all 0.1s ease;
}

.form-control:focus, .form-select:focus {
	border-color: #fff;
	box-shadow: 0 0 0 0.25rem rgba(0, 0, 0, 0.5);
}

.form-floating label {
	padding: 1rem 1.25rem;
	color: #6c757d;
}

/* 버튼 스타일 */
.btn-custom {
	background: #fff;
	color: #000;
	border: 1px solid black;
	padding: 1rem 2rem;
	border-radius: 12px;
	font-weight: 600;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
}

.btn-custom:hover {
	background: #2c3e50;
	color: white;
	box-shadow: 0 5px 15px rgba(164, 120, 100, 0.2);
}

/* 결제 수단 버튼 */
.payment-methods {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 1rem;
	margin-bottom: 2rem;
}

.payment-method-btn {
	text-align: center;
	padding: 1.5rem;
	border-radius: 12px;
	background: #fff;
	border: 2px solid #e9ecef;
	transition: all 0.3s ease;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	gap: 0.5rem;
	cursor: pointer;
}

.payment-method-btn:hover {
	border-color: #000;
	background: #fff;
}

.payment-method-btn.active {
	background: #2c3e50;
	color: white;
	transform: scale(1.05);
}

/* 주문 요약 */
.order-summary {
	background: #f8f9fa;
	border-radius: 16px;
	padding: 2rem;
	margin-top: 2rem;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 1rem;
	font-size: 1.1rem;
	color: #495057;
}

.total-amount {
	margin-top: 1.5rem;
	padding-top: 1.5rem;
	border-top: 2px solid #dee2e6;
	font-size: 1.4rem;
	font-weight: 700;
	color: #2c3e50;
	 display: flex;
    justify-content: space-between; 
}

/* 체크박스 스타일 */
.form-check {
	margin-top: 1rem;
}

.form-check-input {
	width: 1.2em;
	height: 1.2em;
	border-radius: 6px;
	border: 2px solid #000;
	cursor: pointer;
}

.form-check-input:checked {
	background-color: #2c3e50;
	border-color: #000;
}

.form-check-label {
	cursor: pointer;
	user-select: none;
}

/* 주소 입력 섹션 */
.address-section h3 {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 1rem;
}

.btn-outline-secondary {
	color: #6c757d;
	border-color: #6c757d;
	transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
	background-color: #6c757d;
	color: white;
	transform: translateY(-2px);
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.container {
		padding: 0 1rem;
	}
	.card {
		padding: 1.5rem;
	}
	.section-title {
		font-size: 1.5rem;
	}
	.payment-methods {
		grid-template-columns: 1fr;
	}
	.user-menu {
		gap: 1rem;
	}
	.top-header {
		padding: 0.5rem 1rem;
	}
}
/* 애니메이션 효과 */
@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}
.card {
	animation: fadeIn 0.6s ease-out;
}

/* 입력 필드 포커스 효과 */
.form-control:focus ~ label, .form-select:focus ~ label {
	color: #c9a797;
}
/* 버튼 로딩 상태 */
.btn-custom.loading {
	position: relative;
	pointer-events: none;
	opacity: 0.8;
}
.btn-custom.loading::after {
	content: '';
	position: absolute;
	width: 20px;
	height: 20px;
	border: 2px solid #fff;
	border-radius: 50%;
	border-top-color: transparent;
	animation: spin 1s linear infinite;
	right: 1rem;
	top: calc(50% - 10px);
}
@keyframes spin {
	to {
		transform: rotate(360deg);
	}
}
#logouting {
	pointer-events: none; /* 마우스 이벤트 비활성화 */
	cursor: text; /* 기본 커서로 유지 */
	color: inherit; /* 색상 변경 방지 */
	text-decoration: none; /* 밑줄 제거 */
}

.coupon-item {
    background-color: white;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 15px;
    cursor: pointer;
    transition: all 0.2s;
    position: relative;
    display: flex;
    align-items: center;
    gap: 20px;
    overflow: hidden;
    min-height: 120px;
}

.coupon-image-container {
    width: 250px;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    background-color: #f8f9fa;
    border-radius: 8px;
}

.coupon-image {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.coupon-content {
    flex: 1;
    padding: 10px 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    min-height: 90px;
}

.coupon-title {
    font-weight: bold;
    font-size: 1.1rem;
    margin-bottom: 8px;
    color: #000;
}

.coupon-description {
    font-size: 1rem;
    color: #6c757d;
    margin-bottom: 5px;
}

.coupon-expiry {
    font-size: 0.9em;
    color: #999;
    margin-top: auto;
}

.coupon-item.selected {
    border: 2px solid #000;
    background-color: #f8f9fa;
}

.coupon-cancel {
    position: absolute;
    top: 10px;
    right: 10px;
    background: none;
    border: none;
    padding: 5px;
    cursor: pointer;
    color: #aaa;
    font-size: 18px;
    line-height: 1;
    display: none;
    z-index: 2;
}

.coupon-cancel:hover {
    color: #666;
}

.coupon-item.selected .coupon-cancel {
    display: block;
}

.coupon-radio {
    display: none;
}

.modal-footer {
    border-top: none;
    padding: 1rem;
}

.modal-footer .btn-apply {
    width: 100%;
    background-color: #000;
    color: #fff;
    border: none;
    padding: 12px;
    border-radius: 8px;
    font-weight: 500;
}

.modal-footer .btn-apply:hover {
    background-color: #333;
}
</style>
</head>
<body>
	<%
	String root = request.getContextPath();
	String name = (String) session.getAttribute("name");
	String hp = (String) session.getAttribute("hp");
	String email=(String) session.getAttribute("email");
	String id = (String)session.getAttribute("myid");
	MemberDao mdao = new MemberDao();
	String memberNum = String.valueOf(mdao.getMemberNumById(id));
	MemberDto mdto = mdao.getData(memberNum);
	String birth =  mdto.getBirth();// 생일 정보 가져오기
	boolean isJuneBirth = false;

	// 생일이 6월인지 확인
	if (birth.substring(5,7).equals("06")) {
	    isJuneBirth = true;
	}

	StringTokenizer stk = new StringTokenizer(hp, "-");

	String idxs = request.getParameter("idxs"); // "2,4,8"
	List<CartListDto> orderItems = new ArrayList<>();
	if (idxs != null && !idxs.trim().isEmpty()) {
		String[] arr = idxs.split(",");
		CartListDao cartDao = new CartListDao();
		for (String idx : arr) {
			CartListDto dto = cartDao.getCartItemByIdx(Integer.parseInt(idx));
			if (dto != null)
				orderItems.add(dto);
		}
	}

	// 총 상품 금액 계산
	int totalProductPrice = 0;
	int totalQuantity = 0;
	for (CartListDto item : orderItems) {
		int price = item.getPrice();
		int quantity = Integer.parseInt(item.getCnt());
		totalProductPrice += price * quantity;
		totalQuantity += quantity;
	}

	// 배송비 계산 (10만원 이상 무료, 미만 3000원)
	int deliveryFee = totalProductPrice >= 100000 ? 0 : 3000;
	int totalPrice = totalProductPrice + deliveryFee;
	
	  //member_num
   String memberNumStr = (String) session.getAttribute("num"); // String으로 가져오기
	Integer member_num = null;
	
	if (memberNumStr != null && !memberNumStr.isEmpty()) {
	    try {
	        member_num = Integer.parseInt(memberNumStr); // Integer로 변환
	    } catch (NumberFormatException e) {
	        System.err.println("세션 'num' 값이 유효한 숫자가 아닙니다: " + memberNumStr);
	    }
	}
		PaymentDto pdto=null;
		String recentPostcode = "";
		String recentMainAddress = "";
		String recentDtlAddress = "";
		 if (member_num != null) {
		        PaymentDao pdao = new PaymentDao();
		        pdto = pdao.getLatestPaymentDetailsByMemberNum(member_num.intValue());
		        
		        if (pdto != null) {
		            String recentAddr = pdto.getAddr() != null ? pdto.getAddr() : "";
		            String[] addrParts = recentAddr.split(",", 3);
		            
		            if (addrParts.length > 0) {
		                recentPostcode = addrParts[0].trim(); // 첫 번째 부분은 우편번호
		            }
		            if (addrParts.length > 1) {
		                recentMainAddress = addrParts[1].trim(); // 두 번째 부분은 기본 주소
		            }
		            if (addrParts.length > 2) {
		                recentDtlAddress = addrParts[2].trim(); // 세 번째 부분은 상세 주소
		            }
		        }
		    }
	%>
	<header>
		<div class="top-header">
			<div class="left-section">
				<button class="slide-menu-btn">
					<span></span> <span></span> <span></span>
				</button>
				<h1 class="shop-name">
					<a href="<%=root%>/index.jsp"> <img
						src="<%=root%>/SemiImg/mainLogo.png" class="y_mainlogo"
						style="width: 150px;">
					</a>
				</h1>
			</div>
			<div class="right-section">
				<nav class="user-menu">
					<a href="#">매장찾기</a> <a
						href="../index.jsp?main=boardlist/boardlist.jsp"> 고객센터</a> <a
						href="../index.jsp?main=cart/cartform.jsp"> 장바구니</a> <a
						href="../index.jsp?main=member/mypage.jsp"> 마이페이지</a>
					<%
					String loginok = (String) session.getAttribute("loginok");
					String role = (String) session.getAttribute("role");
					if (loginok != null && loginok.equals("yes")) {
					%>
					<a href="#" id="logouting"><span><%=name%>님</span></a> <a href="#"
						onclick="logout()"><i class="bi bi-box-arrow-right"></i> 로그아웃</a>
					<%
					} else {
					%>
					<a
						href="../index.jsp?main=login/loginform.jsp&redirect=<%=request.getRequestURI()%>">
						<i class="bi bi-box-arrow-in-right"></i> 로그인
					</a>
					<%
					}
					%>
				</nav>
			</div>
		</div>
	</header>
	<!-- 메인 컨테이너 -->
	<div class="container">
		<!-- 주문 섹션 -->
		<section class="card">
			<h2 class="section-title">주문 목록</h2>
			<div class="order-list">
				<%
				for (CartListDto item : orderItems) {
				%>
				<div class="order-item"
					style="display: flex; align-items: center; gap: 18px; margin-bottom: 22px;">
					<div>
						<img src="<%=item.getMain_image_url()%>"
							style="width: 100px; height: 100px; border-radius: 8px; object-fit: cover; border: 1px solid #ddd;">
					</div>
					<div>
						<div style="font-weight: bold; font-size: 1.08rem; margin-bottom: 7px;"><%=item.getProduct_name()%></div>
						<div style="color: #666; font-size: 0.97rem;">
							<%=item.getColor()%> 
							/<%=item.getSize()%>
							/<%=item.getCnt()%>개 / <span style="color: #b28555;"><%=NumberFormat.getInstance().format(item.getPrice() * Integer.parseInt(item.getCnt()))%>원</span>
						</div>
					</div>
				</div>
				<%}%>
			</div>
		</section>
		<!-- 주문자 정보 섹션 -->
		<section class="card">
			<h2 class="section-title">주문자 정보</h2>
			<form class="customer-form">
				<div class="row g-4">
					<!-- 주문자명 입력 -->
					<div class="col-md-6">
						<div class="form-floating">
							<input type="text" class="form-control" id="name"
								placeholder="주문자명"> <label for="name">주문자명</label>
						</div>
						<div class="form-check">
							<input type="checkbox" class="form-check-input" id="sameinfo">
							<label class="form-check-label" for="sameinfo">회원정보와 동일</label>
						</div>
					</div>

					<!-- 전화번호 입력 -->
					<div class="col-md-6">
						<div class="form-floating">
							<input type="tel" class="form-control" id="hp" placeholder="전화번호">
							<label for="hp">전화번호 (-없이 입력)</label>
						</div>
					</div>
					<!-- 주소 입력 -->
					<div class="col-12">
						<h3 class="h5 mb-3">배송지 주소</h3>
						<div class="d-flex gap-2 mb-3">
							<button type="button" class="btn btn-custom" id="findaddress">
								<i class="bi bi-search"></i> 주소찾기
							</button>
							<button type="button" class="btn btn-outline-secondary"
								id="canceladdress">
								<i class="bi bi-x-lg"></i> 취소
							</button>
							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="sameaddr">
								<label class="form-check-label" for="sameaddress">최근 배송지</label>
							</div>
						</div>
					</div>
					<!-- 우편번호 -->
					<div class="col-md-4">
						<div class="form-floating">

							<input type="text" class="form-control" id="userPostCode"
								readonly> <label for="userPostCode">우편번호</label>
						</div>
					</div>

					<!-- 기본주소 -->
					<div class="col-12">
						<div class="form-floating">
							<input type="text" class="form-control" id="userAddress" readonly>
							<label for="userAddress">기본주소</label>
						</div>
					</div>

					<!-- 상세주소 -->
					<div class="col-12">
						<div class="form-floating">
							<input type="text" class="form-control" id="userDtlAddress"
								readonly> <label for="userDtlAddress">상세주소</label>
						</div>
					</div>

					<!-- 이메일 -->
					<div class="col-md-6">
						<div class="form-floating">
							<input type="email" class="form-control" id="email"
								placeholder="이메일"> <label for="email">이메일</label>
						</div>
					</div>

					<!-- 쿠폰 선택 -->
					<div class="col-12">
						<div class="d-flex align-items-center gap-3">
							<span class="fw-bold">쿠폰 적용</span>
							<span id="usecoupon" class="text-muted">선택안함</span>
							<button type="button" class="btn btn-custom btn-sm" data-bs-toggle="modal" data-bs-target="#couponModal">
								<i class="bi bi-ticket-perforated"></i> 쿠폰찾기
							</button>
						</div>
					</div>

					<!-- 배송 메시지 -->
					<div class="col-12">
						<label class="form-label fw-bold">배송 전 메시지</label> <select
							class="form-select mb-3">
							<option class="msg" id="message1" value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
							<option class="msg" id="message2" value="문 앞에 놔두고 가세요.">문 앞에 놔두고 가세요.</option>
							<option class="msg" id="message3" value="배송 전 연락주세요.">배송 전 연락주세요.</option>
							<option class="msg" id="message4" value="직접 입력">직접 입력</option>
						</select>

						<div class="form-floating" id="mymessage" style="display: none;">
							<textarea class="form-control" placeholder="메시지를 입력하세요"
								style="height: 100px"></textarea>
							<label>메시지 입력</label>
						</div>
					</div>
				</div>
			</form>
		</section>

		<!-- 결제 섹션 -->
		<section class="card">
			<h2 class="section-title">결제 수단</h2>
			<div class="payment-methods">
				<button class="btn payment-method-btn" name="pay">
					<i class="bi bi-credit-card fs-4"></i>
					<div class="mt-2">카드결제</div>
				</button>
				<button class="btn payment-method-btn" name="pay">
					  <i class="bi bi-bag fs-4"></i>
					<div class="mt-2">네이버페이</div>
				</button>
				<button class="btn payment-method-btn" name="pay">
					<i class="bi bi-chat-fill fs-4"></i>
					<div class="mt-2">카카오페이</div>
				</button>
				<button class="btn payment-method-btn" name="pay">
					<i class="bi bi-bank fs-4"></i>
					<div class="mt-2">무통장입금</div>
				</button>
				<button class="btn payment-method-btn" name="pay">
					<i class="bi bi-wallet2 fs-4"></i>
					<div class="mt-2">TOSS</div>
				</button>
			</div>

			<div class="order-summary">
				<div class="summary-item">
					<span>상품금액</span> <span><%=NumberFormat.getInstance().format(totalProductPrice)%>원</span>
				</div>
				<div class="summary-item">
					<span>쿠폰 할인</span>
					<div>
						<span id="coupon-discount">0원</span>
					</div>
				</div>
				<div class="summary-item">
					<span>배송비</span> <span><%=NumberFormat.getInstance().format(deliveryFee)%>원</span>
				</div>
				<div class="total-amount">
					<span>총 결제금액</span>
					<span style="text-align: right; flex-grow: 1;"><%=NumberFormat.getInstance().format(totalPrice)%>원</span>
				</div>
				<!-- 금액 계산 -->
				<input type="hidden" id="finalCalculatedAmount" value="<%=totalPrice%>">
				
			</div>

			<input type="hidden" id="selectedPay" name="selectedPay" readonly>
			<button type="button" class="btn btn-custom w-100 mt-4"
				onclick="payrequest()">
				<i class="bi bi-check-circle"></i> 결제하기
			</button>
		</section>
	</div>

	<!-- 쿠폰모달 -->
	<div class="modal fade" id="couponModal" tabindex="-1" aria-labelledby="couponModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="couponModalLabel">사용 가능한 쿠폰</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="coupon-item" data-discount="20">
						<input type="radio" name="coupon" value="welcome" class="coupon-radio">
						<div class="coupon-image-container">
							<img src="<%=root%>/SemiImg/MemberCoupon.png" alt="웰컴 쿠폰" class="coupon-image">
						</div>
						<div class="coupon-content">
							<div class="coupon-title">회원가입 감사 쿠폰</div>
							<div class="coupon-description">20% 할인</div>
							<div class="coupon-expiry">2025-09-31 까지</div>
						</div>
						<button type="button" class="coupon-cancel">
							<i class="bi bi-x-lg"></i>
						</button>
					</div>
					
					<% if (isJuneBirth) { %>
					<div class="coupon-item" data-discount="25">
						<input type="radio" name="coupon" value="birthday" class="coupon-radio">
						<div class="coupon-image-container">
							<img src="<%=root%>/SemiImg/BirthCoupon.png" alt="생일 쿠폰" class="coupon-image">
						</div>
						<div class="coupon-content">
							<div class="coupon-title">6월 생일자 할인 쿠폰</div>
							<div class="coupon-description">25% 할인</div>
							<div class="coupon-expiry">2025-06-30 까지</div>
						</div>
						<button type="button" class="coupon-cancel">
							<i class="bi bi-x-lg"></i>
						</button>
					</div>
					<% } %>
					
					<div class="coupon-item" data-discount="50">
						<input type="radio" name="coupon" value="summer" class="coupon-radio">
						<div class="coupon-image-container">
							<img src="<%=root%>/SemiImg/SummerCoupon.png" alt="여름 쿠폰" class="coupon-image">
						</div>
						<div class="coupon-content">
							<div class="coupon-title">여름 빅할인 쿠폰</div>
							<div class="coupon-description">50% 할인</div>
							<div class="coupon-expiry">2025-08-31 까지</div>
						</div>
						<button type="button" class="coupon-cancel">
							<i class="bi bi-x-lg"></i>
						</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-apply" id="applyCouponBtn">쿠폰 적용하기</button>
				</div>
			</div>
		</div>
	</div>

	<script>
        $(function(){
            // 결제 수단 선택
            $(".payment-method-btn").click(function() {
            	
                $(".payment-method-btn").removeClass("active");
                $(this).addClass("active");
                var selectedPay = $(this).text().trim();
                $("#selectedPay").val(selectedPay);
            });

            // 배송 메시지 직접 입력
            $(".form-select").change(function(){
                var m = $(".form-select option:selected").text();
                if(m === "직접 입력"){
                    $("#mymessage").show();
                }else{
                    $("#mymessage").hide();
                }
            });

            // 주소찾기
            $("#findaddress").click(function(){
                new daum.Postcode({
                    oncomplete: function(data) {
                        document.getElementById("userAddress").value = data.address;
                        document.getElementById("userPostCode").value = data.zonecode;
                        var inputDtlAddr = document.getElementById("userDtlAddress");
                        inputDtlAddr.readOnly = false;
                    }
                }).open();
            });

            // 주소 초기화
            $("#canceladdress").click(function(){
                
                $("#userAddress").val("");
                $("#userDtlAddress").val("").prop("readonly", true);
            });
            
            const recentPostcode = "<%= recentPostcode %>";
            const recentMainAddr = "<%= recentMainAddress %>";
            const recentDtlAddr = "<%= recentDtlAddress %>";
            //최근배송지 클릭
            $("#sameaddr").click(function(){
            	if($(this).is(":checked")){
            		$("#userPostCode").val(recentPostcode);
                	$("#userAddress").val(recentMainAddr);
                	 $("#userDtlAddress").val(recentDtlAddr);
						} else {
							$("#userPostCode").val("");
							$("#userAddress").val("");
			                $("#userDtlAddress").val("").prop("readonly", true);
						}
					});
            		
           
            
            // 회원정보 동일
            $("#sameinfo").click(function(){
                if($(this).is(":checked")){
                    $("#name").val("<%=name%>");
                    $("#hp").val("<%=stk.nextToken()%>"+"<%=stk.nextToken()%>"+"<%=stk.nextToken()%>");
                    $("#email").val("<%=email%>");
						} else {
							$("#name").val("");
							$("#hp").val("");
		                    $("#email").val("");
						}
					});
            
         // Bootstrap 모달 객체
    		var couponModal = new bootstrap.Modal(document.getElementById('couponModal'));
    		
    		// 쿠폰찾기 버튼 클릭시 모달 열기
    		$('.btn-custom.btn-sm').click(function() {
    			couponModal.show();
    		});
    		
    		// 쿠폰 아이템 클릭 시 라디오 버튼 선택
    		$('.coupon-item').click(function(e) {
    			// 취소 버튼 클릭 시 이벤트 전파 중지
    			if ($(e.target).closest('.coupon-cancel').length) {
    				return;
    			}
    			
    			const radio = $(this).find('input[type="radio"]');
    			radio.prop('checked', true);
    			$('.coupon-item').removeClass('selected');
    			$(this).addClass('selected');
    		});
    		
    		// 취소 버튼 클릭 시
    		$('.coupon-cancel').click(function(e) {
    			e.stopPropagation(); // 이벤트 전파 중지
    			const couponItem = $(this).closest('.coupon-item');
    			couponItem.removeClass('selected');
    			couponItem.find('input[type="radio"]').prop('checked', false);
    			
    			// 할인 금액 초기화
    			$('#coupon-discount').text('0원');
    			$('.total-amount span:last').text('<%= NumberFormat.getInstance().format(totalPrice) %>원');
                $('#finalCalculatedAmount').val(originalTotalPrice); // hidden 필드도 초기화

    			$('#usecoupon').text('선택안함');
    		});
            
    		// 쿠폰 적용 버튼 클릭시
    		$('#applyCouponBtn').click(function() {
    			var selectedCoupon = $('input[name="coupon"]:checked');
    			if (selectedCoupon.length > 0) {
    				var couponType = selectedCoupon.val();
    				var discount = selectedCoupon.closest('.coupon-item').data('discount');
    				
    				// 할인 금액 계산
    				var totalPrice = <%= totalPrice %>;
    				var discountAmount = Math.floor(<%=totalProductPrice%> * (discount / 100));
    				
    				// 할인 금액 표시
    				$('#coupon-discount').text('-' + discountAmount.toLocaleString() + '원');
    				
    				// 최종 금액 업데이트
    				var finalAmount = totalPrice - discountAmount;
    				$('.total-amount span:last').text(finalAmount.toLocaleString() + '원');
    				
    				// 쿠폰 선택 텍스트 업데이트
    				var couponName = couponType === 'welcome' ? '회원가입 감사 쿠폰' : '6월 생일자 축하 쿠폰';
    				$('#usecoupon').text(couponName + ' (' + discount + '% 할인)');
    				// 중요: 최종 결제 금액을 hidden 필드나 전역 변수에 저장하여 `payrequest`에서 접근할 수 있도록 합니다.
                    // hidden input 필드 추가
                    $('#finalCalculatedAmount').val(finalAmount);
    			} else {
    				// 선택된 쿠폰이 없을 때
    				$('#coupon-discount').text('0원');
    				$('.total-amount span:last').text('<%= NumberFormat.getInstance().format(totalPrice) %>원');
    				$('#usecoupon').text('선택안함');
    				$('#finalCalculatedAmount').val(<%= totalPrice %>)
    			}
    			
    			// 모달 닫기
    			$('#couponModal').modal('hide');
    		});
		});
<%
// 1. 서버에서 미리 주문 ID 또는 임시 주문 코드 생성
//    이 로직은 PaymentService나 OrderService 같은 곳에서 처리하는 것이 좋습니다.
//    여기서는 예시를 위해 간단히 표현하지만, 실제로는 DB 트랜잭션과 연결되어야 합니다.
//    만약 비회원 주문도 처리해야 한다면, memberNum 대신 세션 ID나 다른 고유값으로 임시 주문을 먼저 생성해야 합니다.

// 임시 주문 코드 생성 (이 코드를 Imp_uid로 사용)
// 실제로는 createOrder 메소드를 호출하여 order_code를 받아와야 합니다.
// 예시: String preGeneratedMerchantUid = new OrderService().generatePreOrderCode(member_num);
// 현재 `createOrder`는 카트 상품 목록을 받으므로, 이 시점에 바로 `createOrder`를 호출하기 어려울 수 있습니다.
// 따라서, 여기서는 클라이언트 UUID를 기반으로 임시 merchant_uid를 생성하고,
// 검증 단계에서 실제 order_code를 서버에서 생성하여 매핑하는 방식을 고려해볼 수 있습니다.
// 그러나 가장 견고한 방법은 서버에서 order_code를 먼저 생성하고 클라이언트에 전달하는 것입니다.

// 서버에서 주문번호 미리 생성하는 로직 (예시)
// DTO를 사용하여 미리 주문 데이터를 만들거나, 간단한 임시 주문번호 생성 로직을 추가합니다.
// 여기서는 기존 generateOrderNumber()와 유사하게 JSP에서 생성하되, 서버에서 관리될 고유성을 더 확보하도록 합니다.

	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	String today = sdf.format(new java.util.Date());
// 실제 운영에서는 UUID.randomUUID() 대신 서버에서 관리되는 시퀀스 또는 DB를 통한 고유 ID 생성 방식이 권장됩니다.
//UUID는 일반적으로 32개의 16진수 문자로 구성되며, 하이픈으로 구분되어 5개의 그룹으로 나뉘어져요.
//예시: 550e8400-e29b-41d4-a716-446655440000
	String preGeneratedMerchantUid = "ORD" + today + "-" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();

	
%>
      
const preGeneratedMerchantUid = "<%= preGeneratedMerchantUid %>";
console.log("미리 생성된 상점 주문번호:", preGeneratedMerchantUid);
		// 결제 요청
		function payrequest() {
			const selectedPay = $("#selectedPay").val();
			if (!selectedPay) {
				alert("결제 수단을 선택해주세요.");
				return;
			}
		 // 주문번호 생성
			
		    const memberNum = "<%= member_num %>"; // JSP에서 가져온 member_num을 JavaScript로 넘겨줍니다.
		    console.log("1b. memberNum 확인: TYPE -", typeof memberNum, ", VALUE -", memberNum); // String, "2" 뜨는지 다시 확인
		    
			switch (selectedPay) {
			case "카드결제":
				cardPay(preGeneratedMerchantUid, memberNum);
				break;
			case "네이버페이":
				naverPay();
				break;
			case "카카오페이":
				kakaoPay();
				break;
			case "무통장입금":
				bankTransfer();
				break;
			case "TOSS":
				tossPay();
				break;
			default:
				alert("지원하지 않는 결제 수단입니다.");
			}
		}
		// 카드결제
		function cardPay(merchantUid, memberNum) {
		    console.log("memberNum:", memberNum); // 이 메시지가 뜨는지 확인
		    const finalAmountForPay = parseInt($("#finalCalculatedAmount").val());
			/* 콘솔 */
			console.log({
			    pg: "kicc",
			    pay_method: "card",
			    merchant_uid: merchantUid,
			    name: '결제테스트',
			    amount: finalAmountForPay, 
			    buyer_email: $("#email").val(),
			    buyer_name: $("#name").val(),
			    buyer_tel: $("#hp").val(),
			    buyer_addr: $("#userAddress").val()+","+$("#userDtlAddress").val()+","+$("#userPostCode").val()
			    				
			});
		    
			var IMP = window.IMP;
			IMP.init('imp23623506');

			IMP.request_pay({
				pg: "kicc",
				pay_method: "card",
				merchant_uid: merchantUid,
				name: '결제테스트',
				amount: finalAmountForPay,  // 실제 계산된 금액으로 변경
				buyer_email: $("#email").val(),
			    buyer_name: $("#name").val(),
			    buyer_tel: $("#hp").val(),
				buyer_addr: $("#userPostCode").val()+","+$("#userAddress").val()+","+$("#userDtlAddress").val(),
			}, function(rsp) {

			    if (rsp.success) {
			        // 배송메시지 처리
			        const deliveryMessage = $(".form-select").val() === "직접 입력" ? 
			            $("#mymessage textarea").val() : 
			            $(".form-select").val();
			        
			        // 1단계: 아임포트 결제 검증 (PaymentVerifyServlet 사용)
			        $.ajax({
			            url: "<%=root%>/payment/verify",  // PaymentVerifyServlet 경로
			            method: "POST",
			            data: {
			                "imp_uid": rsp.imp_uid,           // 아임포트 결제 고유번호
			                "merchant_uid": rsp.merchant_uid, // 상점 주문번호
			                "amount": rsp.paid_amount,        // 실제 결제된 금액
			                "addr": rsp.buyer_addr,           // 구매자 주소
			                "delivery_msg": deliveryMessage,   // 배송 메시지
			                "buyer_email": rsp.buyer_email,   // 구매자 이메일 파라미터 추가
			                "buyer_name": rsp.buyer_name,      // 구매자 이름 파라미터 추가
			                "hp": rsp.buyer_tel
			            },
			            success: function(verifyResponse) {
			                if (verifyResponse.status === "success") {
			                	// 서버에서 전달받은 memberNum을 추출
		                        // PaymentVerifyServlet에서 success 시 memberNum을 응답에 포함하도록 수정했음
			                    // 2단계: 결제 검증 성공 후 주문 처리
			                    processOrder(rsp, deliveryMessage,memberNum);
			                } else {
			                    // 결제 검증 실패
			                    alert('결제 검증에 실패했습니다: ' + verifyResponse.message);
			                    console.error('Payment verification failed:', verifyResponse.message);
			                }
			            },
			            error: function(xhr, status, error) {
			                let errorMessage = '결제 검증 중 오류가 발생했습니다.';
			                
			                if (xhr.responseJSON && xhr.responseJSON.message) {
			                    errorMessage = xhr.responseJSON.message;
			                } else if (xhr.status === 400) {
			                    errorMessage = '결제 정보가 올바르지 않습니다.';
			                } else if (xhr.status === 500) {
			                    errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
			                }
			                
			                alert(errorMessage);
			                console.error('Payment verification error:', status, error);
			            }
			        });
			        
			    } else {
			        // 결제 실패
			        alert('결제에 실패하였습니다.\n에러내용: ' + rsp.error_msg);
			    }

			});
		}
					// 주문 처리 함수 (결제 검증 완료 후 실행)
					function processOrder(rsp, deliveryMessage, memberNum) {
					    $.ajax({
					        url: "updateBuyOk.jsp",
					        method: "POST",
					        data: {
					            // 기존 주문 처리 데이터
					            "idxs": "<%=request.getParameter("idxs")%>",
					            "all": "<%=request.getParameter("all")%>",
					            "member_Id": "<%=session.getAttribute("myid")%>",
					            
					            // 결제 관련 정보 (이미 PaymentService에서 DB에 저장됨)
					            "imp_uid": rsp.imp_uid,
					            "merchant_uid": rsp.merchant_uid,
					            "totalPrice": rsp.paid_amount,
					            "addr": rsp.buyer_addr,
					            "delivery_msg": deliveryMessage,
					            "hp": rsp.buyer_tel,
					            "member_num": memberNum
					        },
					        success: function(response) {
					            if (response.trim() === "success") {
					                alert('결제 및 주문이 완료되었습니다. 주문 목록으로 이동합니다.');
					                location.href = '../index.jsp?main=orderlist/orderlistform.jsp';
					            } else {
					                alert('결제는 완료되었으나 주문 처리 중 문제가 발생했습니다: ' + response);
					                console.error('Order processing failed:', response);
					            }
					        },
					        error: function(xhr, status, error) {
					            alert('결제는 완료되었으나 주문 처리 중 오류가 발생했습니다. 고객센터에 문의하세요.');
					            console.error("Order processing error:", status, error);
					        }
					    });
					}
		function naverPay() {
			alert("공사 중입니다.");
		}
		function kakaoPay(){
			alert("공사 중입니다.");
		}
		function bankTransfer(){
			alert("공사 중입니다.");
		}
		function tossPay(){
			alert("공사 중입니다.");
		}
		function logout() {
			alert("로그아웃 하셨습니다.");
			location.href = "../login/logoutform.jsp";
		}
			
		    console.log("<%=member_num%>");
		    console.log("JSP에서 전달된 totalPrice:", <%= totalPrice %>);
		    console.log("JSP에서 전달된 member_num:", "<%= member_num %>");
		  
	</script>
</body>
</html>