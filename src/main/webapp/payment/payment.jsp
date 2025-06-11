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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 다음 주소창api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript"
	src="https://unpkg.com/axios/dist/axios.min.js"></script>
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
</style>
</head>
<body>
	<%
	String root = request.getContextPath();
	String name = (String) session.getAttribute("name");
	String hp = (String) session.getAttribute("hp");
	String email=(String) session.getAttribute("email");
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

	// 배송비 계산 (8만원 이상 무료, 미만 3000원)
	int deliveryFee = totalProductPrice >= 80000 ? 0 : 10;
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

   
	%>

	<!-- 헤더 -->
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
							<span class="fw-bold">쿠폰 적용</span> <span id="usecoupon"
								class="text-muted">선택안함</span>
							<button type="button" class="btn btn-custom btn-sm">
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
					<i class="bi bi-n-circle fs-4"></i>
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
					<span>배송비</span> <span><%=NumberFormat.getInstance().format(deliveryFee)%>원</span>
				</div>
				<div class="summary-item">
					<span>할인금액</span> <span>0원</span>
				</div>
				<div class="total-amount">
					<span>총 결제금액</span> <span><%=NumberFormat.getInstance().format(totalPrice)%>원</span>
				</div>
			</div>

			<input type="hidden" id="selectedPay" name="selectedPay" readonly>
			<button type="button" class="btn btn-custom w-100 mt-4"
				onclick="payrequest()">
				<i class="bi bi-check-circle"></i> 결제하기
			</button>
		</section>
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
                $("#userPostCode").val("");
                $("#userAddress").val("");
                $("#userDtlAddress").val("").prop("readonly", true);
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
		});

        function generateOrderNumber() {
        		const pad = (n) => String(n).padStart(2, '0');
        	    const now = new Date();

        	    const year = String(now.getFullYear()).slice(-2);
        	    const month = pad(now.getMonth() + 1);
        	    const day = pad(now.getDate());
        	    const hour = pad(now.getHours());
        	    const minute = pad(now.getMinutes());
        	    const second = pad(now.getSeconds());
        	    const random = String(Math.floor(Math.random() * 1000)).padStart(3, '0');
        	    const orderNum = "ORDER" + year + month + day + hour + minute + second + random;
        	    console.log("최종 생성된 merchant_uid:", orderNum);

        	    return orderNum;
        }
	
		// 결제 요청
		function payrequest() {
		    const newMerchantUid = generateOrderNumber();
		    console.log("생성된 merchant_uid:", newMerchantUid); 
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
				cardPay(newMerchantUid, memberNum);
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
		function cardPay(newMerchantUid, memberNum) {
		    console.log("memberNum:", memberNum); // 이 메시지가 뜨는지 확인

			/* 콘솔 */
			console.log({
			    pg: "kicc",
			    pay_method: "card",
			    merchant_uid: newMerchantUid,
			    name: '결제테스트',
			    amount: <%= totalPrice %>, 
			    buyer_email: $("#email").val(),
			    buyer_name: $("#name").val(),
			    buyer_tel: $("#hp").val(),
			    buyer_addr: $("#userAddress").val()+$("#userDtlAddress").val(),
			    buyer_postcode: $("#userPostCode").val()
				
			});
			/*  */
			
			var IMP = window.IMP;
			IMP.init('imp23623506');

			IMP.request_pay({
				pg: "kicc",
				pay_method: "card",
				merchant_uid: newMerchantUid,
				name: '결제테스트',
				amount: <%=totalPrice%>,  // 실제 계산된 금액으로 변경
				buyer_email: $("#email").val(),
			    buyer_name: $("#name").val(),
			    buyer_tel: $("#hp").val(),
				buyer_addr: $("#userAddress").val()+$("#userDtlAddress").val(),
				buyer_postcode: $("#userPostCode").val(),

			}, function(rsp) {
				
				if (rsp.success) {
					//배송메세지 처리
					  const deliveryMessage = $(".form-select").val() === "직접 입력" ?
                              $("#mymessage textarea").val() :
                              $(".form-select").val(); // option value를 사용하도록 수정
					// 결제 성공 시 buyok 값 업데이트
					$.ajax({
						url: "updateBuyOk.jsp",
						method: "POST",
						data: {
							"idxs": "<%=request.getParameter("idxs")%>",  // 선택상품 주문의 경우
							"all": "<%=request.getParameter("all")%>",  // 전체상품 주문의 경우
							"member_Id": "<%=session.getAttribute("myid")%>",  // 전체상품 주문 시 필요
							 // payment 테이블 저장을 위한 정보
		                    "imp_uid": rsp.imp_uid,          // 아임포트 결제 고유 번호
		                    "merchant_uid": rsp.merchant_uid,  // 상점 주문 번호
		                    "totalPrice": rsp.paid_amount,     // 아임포트에서 실제 결제된 금액
		                    "addr": rsp.buyer_addr,          // 구매자 주소
		                    "delivery_msg": deliveryMessage, // 배송 메시지
		                    "hp": rsp.buyer_tel,              // 구매자 연락처
		                    "member_num":memberNum
						},
						success: function(response) {
							 if (response.trim() === "success") {
			                        alert('결제가 완료되었습니다. 주문 목록으로 이동합니다.');
			                        location.href = '../index.jsp?main=orderlist/orderlistform.jsp';
			                        
			                    } else {
			                        // 서버에서 에러 응답을 보냈을 경우
			                        alert('결제는 완료되었으나 서버 처리 중 문제가 발생했습니다: ' + response);
			                    }
						},
						error: function() {
							 console.error("AJAX Error:", status, error);
			                    alert('결제는 완료되었으나 주문 처리 중 오류가 발생했습니다. 고객센터에 문의하세요.');
						}
					});
				} else {
					alert('결제에 실패하였습니다.\n' + '에러내용: ' + rsp.error_msg);
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

		 console.log("Name:", "<%=name%>");
		    console.log("Email:", "<%=email%>");
		    console.log("<%=member_num%>");
	</script>
</body>
</html>