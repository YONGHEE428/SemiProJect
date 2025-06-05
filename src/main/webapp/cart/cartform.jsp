<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao"%>
<%@ page import="data.dto.CartListDto"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>
<%-- 숫자 포맷을 위해 추가 --%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>장바구니</title>
<style>
.cart-item {
	border-radius: 15px;
	border: 1px solid #eee;
	margin-bottom: 20px;
	padding: 20px;
	background: #fff;
	display: flex;
	align-items: center;
}

.cart-img {
	width: 100px; /* height: auto; 추가하면 비율 유지 */
}

.cart-summary {
	background: #fafafa;
	border-radius: 10px;
	padding: 20px;
	margin-top: 30px;
}

.btn-outline-secondary, .cart-btn {
	background: #c9a797 !important;
	color: #fff !important;
	border-color: #c9a797 !important;
}

.btn-outline-secondary:hover, .cart-btn:hover {
	background: #a3715a !important;
	color: #fff !important;
	border-color: #a3715a !important;
}

.cart-btn {
	padding: 10px 30px;
	border-radius: 5px;
}

.btn-outline-secondary.btn-sm {
	padding: .25rem .5rem !important;
	font-size: .875rem !important;
	border-radius: .2rem !important;
}

.btn-link {
	color: #c9a797 !important;
}

.btn-link:hover {
	color: #a3715a !important;
}

.quantity-input {
	width: 60px;
	text-align: center;
} /* 수량 입력 필드 스타일 */
</style>
<script type="text/javascript">
	$(function() {
		// 전체 선택/해제
		$("#allCheck").change(
				function() {
					$(".item-check").prop("checked", $(this).is(":checked"))
							.trigger("change");
				});

		// 선택한 상품 수, 총액 계산
		function updateSummary() {
			let total = 0;
			let count = 0;

			$(".item-check:checked").each(
					function() {
						let item = $(this).closest(".cart-item");
						let price = parseInt(item.find(".item-unit-price")
								.data("price"));
						let qty = parseInt(item.find(".quantity-input").val());

						count++;
						total += price * qty;
					});

			$("#selectedCount").text(count);
			$("#selectedTotalPrice").text(total.toLocaleString());
			let shipping = (total >= 80000 || total === 0) ? 0 : 3000;
			$("#shippingCost").text(shipping.toLocaleString());
			$("#finalTotalPrice").text((total + shipping).toLocaleString());
		}

		$(".item-check").change(updateSummary);

		// 수량 증가/감소
		$(".quantity-plus, .quantity-minus").click(
				function() {
					let item = $(this).closest(".cart-item");
					let input = item.find(".quantity-input");
					let val = parseInt(input.val());

					if ($(this).hasClass("quantity-plus"))
						val++;
					else if (val > 1)
						val--;

					input.val(val);

					//  수량 변경 시 항목 합계도 업데이트
					let price = parseInt(item.find(".item-unit-price").data(
							"price"));
					let itemTotal = price * val;
					item.find(".item-total-price").text(
							itemTotal.toLocaleString() + "원");

					//  체크된 항목이면 전체 총액 업데이트
					if (item.find(".item-check").is(":checked")) {
						updateSummary();
					}

					//  Ajax로 DB 수량 업데이트
					let idx = item.data("idx");

					$.ajax({
						url : "cart/updatecartcnt.jsp",
						type : "POST",
						data : {
							idx : idx,
							cnt : val
						},
						success : function() {
							console.log("수량 업데이트 완료");
						},
						error : function() {
							alert("수량 변경 실패");
						}
					});
				});

		// 단일 삭제 버튼
		$(".delete-item-btn").click(function() {
			if (!confirm("정말 삭제하시겠습니까?"))
				return;

			let item = $(this).closest(".cart-item");
			let idx = item.data("idx");

			$.ajax({
				url : "cart/cartdelete.jsp",
				type : "POST",
				data : {
					idx : idx
				},
				success : function() {
					item.remove();
					$("#allCheck").prop("checked", false);
					updateSummary();
				}
			});
		});

		// ✅ 선택삭제 버튼 클릭 시
		$("#deleteSelectedBtn").click(function() {
			if (!$(".item-check:checked").length) {
				alert("삭제할 항목을 선택해주세요.");
				return;
			}

			if (!confirm("선택한 상품을 삭제하시겠습니까?"))
				return;

			let selectedIdxs = [];

			$(".item-check:checked").each(function() {
				let idx = $(this).closest(".cart-item").data("idx");
				selectedIdxs.push(idx);
			});

			// Ajax 요청으로 선택된 항목 삭제
			$.ajax({
				url : "cart/cartdelete_selected.jsp", // 👉 선택삭제용 JSP
				type : "POST",
				traditional : true, // 배열 전송
				data : {
					idxs : selectedIdxs
				},
				success : function() {
					// 삭제된 항목 화면에서 제거
					$(".item-check:checked").each(function() {
						$(this).closest(".cart-item").remove();
					});
					$("#allCheck").prop("checked", false);
					updateSummary();
				},
				error : function() {
					alert("선택삭제 실패");
				}
			});
		});
		// 선택상품 주문하기 버튼
		$("#orderSelectedBtn").click(function() {
			let selectedIdxs = [];

			$(".item-check:checked").each(function() {
				selectedIdxs.push($(this).val());
			});

			if (selectedIdxs.length === 0) {

				return;
			}

			$.ajax({
				url : "cart/orderselected.jsp",
				type : "POST",
				traditional : true, // 배열 전송을 위한 옵션
				data : {
					idxs : selectedIdxs
				},
				success : function(response) {
					//결제 화면 링크
					window.location.href = "https://example.com/mock-payment";
				},
				error : function() {
					alert("주문 처리 중 오류가 발생했습니다.");
				}
			});
		});
		//전체상품 주문하기 버튼
		$("#orderAllBtn").click(function() {
			let allIdxs = [];

			$(".item-check").each(function() {
				allIdxs.push($(this).val());
			});

			if (allIdxs.length === 0) {
				alert("장바구니에 상품이 없습니다.");
				return;
			}

			$.ajax({
				url : "orderall.jsp",
				type : "POST",
				traditional : true,
				data : {
					idxs : allIdxs
				},
				success : function(response) {
					// 실제 결제 페이지로 이동 
					window.location.href = "https://example.com/mock-payment";
				},
				error : function() {
					alert("전체 주문 처리 중 오류가 발생했습니다.");
				}
			});
		});
		$("#orderSelectedBtn").click(function() {
			let checkedIdxs = [];
			$(".item-check:checked").each(function() {
				checkedIdxs.push($(this).val());
			});

			if (checkedIdxs.length === 0) {
				alert("주문할 상품을 선택해주세요.");
				return;
			}

			// 👉 주문서 페이지로 GET 방식으로 이동
			location.href = "orderform.jsp?idxs=" + checkedIdxs.join(",");
		});

		// 초기 실행
		updateSummary();
	});
</script>


</head>


<%
String memberId = (String) session.getAttribute("myid"); //id받아오기
if (memberId == null) {
	// 로그인 후 돌아올 현재 페이지 경로를 redirect 파라미터로 전달
	String cartPageUrl = request.getContextPath() + "index.jsp?main=cart/cartform.jsp"; // 현재 장바구니 페이지 URL
	response.sendRedirect(request.getContextPath() + "index.jsp?main=login/loginform.jsp?redirect="
	+ java.net.URLEncoder.encode(cartPageUrl, "UTF-8"));
	return;
}

CartListDao cartDao = new CartListDao();
List<CartListDto> cartItems = cartDao.getCartListByMember(memberId);
String name = (String) session.getAttribute("name");
%>
<body>
	<div class="container mt-5">
		<div class="mb-3 text-secondary">
			홈 &gt; 마이페이지 &gt; <b>장바구니 (&nbsp;<%=name%>&nbsp;님)
			</b>
		</div>
		<h2 class="mb-4">
			장바구니 <span style="font-size: 16px; color: #aaa;">ⓘ</span>
		</h2>
		<div class="mb-3">
			<input type="checkbox" id="allCheck" class="form-check-input">
			<label for="allCheck">전체선택</label>
			<button type="button" id="deleteSelectedBtn"
				class="btn btn-outline-secondary btn-sm float-end">선택삭제</button>
		</div>

		<%
		if (cartItems == null || cartItems.isEmpty()) {
		%>
		<div class="alert alert-info" role="alert">장바구니에 담긴 상품이 없습니다.</div>
		<%
		} else {
		%>
		<%
		for (CartListDto item : cartItems) {
			int itemPrice = 0; // 기본값
			// CartListDto의 getPrice()가 int를 반환하므로 바로 사용
			itemPrice = item.getPrice();

			int cnt = 1; // 기본값 또는 최소 수량
			try {
				// CartListDto의 getCnt()가 String을 반환하므로 Integer.parseInt로 변환
				if (item.getCnt() != null && !item.getCnt().isEmpty()) {
			cnt = Integer.parseInt(item.getCnt());
				}
			} catch (NumberFormatException e) {
				// item.getCnt()가 숫자로 변환될 수 없는 경우 기본값(1) 사용
				// 또는 오류 로깅 등의 처리 가능
				System.err.println(
				"Warning: Cart item count format error for idx " + item.getIdx() + ", cnt value: " + item.getCnt());
				cnt = 1; // 안전하게 기본값으로
			}

			// itemPrice는 int, quantity도 int이므로 itemTotalPrice도 int
			int itemTotalPrice = itemPrice * cnt;
		%>
		<div class="cart-item" data-idx="<%=item.getIdx()%>"
			data-product-id="<%=item.getProduct_id()%>"
			data-option-id="<%=item.getOption_id()%>">
			<input type="checkbox" class="form-check-input me-3 item-check"
				value="<%=item.getIdx()%>"> 
			<!-- <img src="<%=request.getContextPath()%>/product_images/<%=item.getMain_image_url()%>"
				onerror="this.src='https://via.placeholder.com/100x120.png?text=No+Image'"
				class="cart-img me-4" alt="<%=item.getProduct_name()%>"> -->

			<div class="flex-grow-1">
				<div class="fw-bold"><%=item.getProduct_name()%></div>
				<div class="text-secondary" style="font-size: 14px;"><%=item.getColor()%>
					/
					<%=item.getSize()%></div>
				<%-- <div class="text-danger" style="font-size: 13px;">특가! 12시간 00분 남음</div> --%>
				<div class="mt-2">
					<span class="badge bg-light text-dark">옵션: <%=item.getColor()%>
						/ <%=item.getSize()%></span>
					<%-- <button class="btn btn-outline-secondary btn-sm ms-2">옵션변경</button> --%>
				</div>
			</div>
			<div class="d-flex align-items-center ms-4">
				<div style="width: 80px; text-align: right; margin-right: 10px;">
					<span class="item-unit-price" data-price="<%=itemPrice%>"> <%=NumberFormat.getInstance().format(itemPrice)%>원
					</span>
				</div>

				<button class="btn btn-outline-secondary btn-sm quantity-minus"
					type="button">-</button>
				<input type="text"
					class="form-control form-control-sm mx-1 quantity-input"
					value="<%=cnt%>" readonly>
				<button class="btn btn-outline-secondary btn-sm quantity-plus"
					type="button">+</button>

				<div class="ms-3 text-end" style="width: 100px;">
					<div class="fw-bold item-total-price" style="font-size: 18px;">
						<%=NumberFormat.getInstance().format(itemTotalPrice)%>원
					</div>
				</div>
			</div>

			<button type="button"
				class="btn btn-link text-danger ms-3 delete-item-btn">×</button>
		</div>
		<%}%>
		<%}%>
		<div
			class="cart-summary d-flex justify-content-between align-items-center">
			<div>
				선택한 상품 <span class="fw-bold" id="selectedCount">0</span>개 | <span
					class="fw-bold" id="selectedTotalPrice">0</span>원
			</div>
			<div>
				배송비 <span class="fw-bold" id="shippingCost">0</span>원 <span
					class="text-secondary">(8만원 이상 무료배송)</span>
			</div>
			<div>
				총 결제 예상금액 <span class="fw-bold" id="finalTotalPrice">0</span>원
			</div>
		</div>
		<div class="mt-4 d-flex gap-3">
			<button type="button" id="orderSelectedBtn" class="cart-btn">선택상품
				주문하기</button>
			<button type="button" id="orderAllBtn" class="cart-btn">전체상품
				주문하기</button>
		</div>
	</div>
</body>
</html>
