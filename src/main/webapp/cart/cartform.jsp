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
<link rel="stylesheet"  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>장바구니</title>
<style>
body {
    background: #f8f8f8;
}
.cart-wrapper {
    max-width: 900px;
    margin: 70px auto;
    background: #fff;
    border: 1px solid #444;
    padding: 30px 25px;
}
.cart-title-bar {
    background: #f5f5f5;
    border: 1px solid #aaa;
    border-radius: 4px;
    padding: 10px 20px;
    font-weight: bold;
    font-size: 1.15rem;
    margin-bottom: 22px;
    display: inline-block;
}
.cart-list-section {
    margin-top: 14px;
}
.cart-box {
    border: 2px solid #bbb;
    border-radius: 15px;
    padding: 19px 22px 14px 22px;
    margin-bottom: 22px;
    background: #fafafa;
}
.cart-header-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 14px;
}
.cart-content-row {
    display: flex;
    align-items: flex-start;
    gap: 20px;
}
.cart-thumb-box {
    border: 1px solid #aaa;
    width: 92px; height: 92px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 6px;
    background: #fff;
    font-size: 0.97rem; color: #666;
}
.cart-prod-info {
    flex: 1;
    min-width: 0;
}
.cart-prod-title {
    font-weight: bold;
    font-size: 1.07rem;
    margin-bottom: 7px;
}
.cart-prod-desc {
    font-size: 0.97rem;
    color: #555;
    margin-bottom: 7px;
}
.cart-prod-price-row {
    display: flex;
    align-items: center;
    gap: 17px;
    margin-bottom: 5px;
}
.cart-prod-price {
    font-size: 0.99rem;
    border: 1px solid #bbb;
    background: #fff;
    border-radius: 4px;
    padding: 4px 16px;
    margin-right: 6px;
}
.cart-actions-col {
    display: flex;
    flex-direction: column;
    gap: 5px;
    min-width: 87px;
}
.cart-actions-col .btn {
    font-size: 0.96rem;
    border-radius: 4px;
    padding: 3px 0;
    border: 1px solid #bbb;
    background: #fff;
}
.cart-actions-col .btn:hover {
    background: #e7e7e7;
}
@media (max-width: 700px) {
    .cart-wrapper { padding: 12px 2px; }
    .cart-content-row { flex-direction: column; gap: 8px; }
    .cart-actions-col { flex-direction: row; gap: 7px; }
}
/* 상단바 */
.mypage-content{
    height:60px;
    line-height:60px;
    top:150px;
    position:fixed;
    width:100%;
    min-height: 5px;
    font-weight: bold;
    text-align: center;
    background-color: white;
    transition: top 0.3s ease;
}
.content-title > ul{
    display: flex;
    justify-content: center;
    gap : 170px;
}
.content-title > ul > li >a{
    color:gray;
    text-decoration: none;
}
.content-title > ul > li > a:hover{
    color:black;
    border-bottom: 3px solid black;
}
.cart-btn, .btn-outline-secondary {
  background: #fff !important;
  color: #232323 !important;
  border: 1.5px solid #232323 !important;
  border-radius: 7px;
  box-shadow: none !important;
  font-weight: 700;
  letter-spacing: 1px;
  text-transform: uppercase;
  padding: 13px 32px;
  font-size: 1.05rem;
  outline: none;
  transition: background 0.22s, color 0.22s, border-color 0.22s;
}
.cart-btn:hover, .btn-outline-secondary:hover {
  background: #000 !important;
  color: #fff !important;
  border-color: #000 !important;
}
.btn-link {
  color: #232323 !important;
  font-size: 22px;
  transition: color 0.2s;
}
.btn-link:hover {
  color: #000 !important;
  text-decoration: underline;
}
.form-check-input:checked {
  background-color: #111 !important;
  border-color: #111 !important;
}
.quantity-input {
  background: #fff;
  border: 1.5px solid #232323;
  border-radius: 5px;
  color: #232323;
  font-weight: 600;
  text-align: center;
  outline: none;
}
.cart-summary {
  background: #fff;
  border: 1.5px solid #232323;
  border-radius: 11px;
  padding: 22px 24px;
  margin-top: 36px;
  font-size: 1.07rem;
  color: #111;
}
.cart-item {
  border-radius: 14px;
  border: 1.5px solid #e6e6e6;
  margin-bottom: 22px;
  padding: 22px 24px;
  background: #fff;
  display: flex;
  align-items: center;
}
.cart-img {
  width: 90px; height: 90px;
  object-fit: cover;
  border-radius: 10px;
  border: 1.5px solid #eee;
}
.badge.bg-light {
  background: #fff !important;
  color: #232323 !important;
  font-weight: 500;
  border-radius: 7px;
  padding: 7px 14px;
  border: 1px solid #e6e6e6;
}
   	/* 상단바 */
    .mypage-content{
    	height:60px;
    	line-height:60px;
    	top:150px;
    	position:fixed;
		width:100%;
		min-height: 5px;
		font-weight: bold;
		text-align: center;
		background-color: white;
		transition: top 0.3s ease;
		
	}
.content-title > ul{
	display: flex;
	justify-content: center;
	gap : 170px;
	}
	.content-title > ul > li >a{
		color:gray;
		text-decoration: none;
	}
	.content-title > ul > li > a:hover{
		color:black;
		border-bottom: 3px solid black;
	}
</style>

<script type="text/javascript">
   $(function() {

	   window.addEventListener("scroll", function () {
		    const mypage = document.querySelector(".mypage-content");
		    const scrollTop = window.scrollY || document.documentElement.scrollTop;

		    if (scrollTop > 50) {
		      mypage.style.top = "100px";
		    } else {
		      mypage.style.top = "150px";
		    }
	  });
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
          if (!confirm("정말 삭제하시겠습니까?")) return;

          let item = $(this).closest(".cart-item");
          let idx = item.data("idx");
          // 항상 idxs로 보내기 (배열!)
          $.ajax({
              url: "cart/cartdelete_selected.jsp",
              type: "POST",
              traditional: true,
              data: { idxs: [idx] }, // 단일도 배열!
              success: function() {
                  item.remove();
                  $("#allCheck").prop("checked", false);
                  updateSummary();
              }
          });
      });

      // ✅ 선택삭제 버튼 클릭 시
      $("#deleteSelectedBtn").click(function() {
          let checked = $(".item-check:checked");
          if (!checked.length) {
              alert("삭제할 항목을 선택해주세요.");
              return;
          }
          if (!confirm("선택한 상품을 삭제하시겠습니까?")) return;

          let selectedIdxs = [];
          checked.each(function() {
              let idx = $(this).closest(".cart-item").data("idx");
              selectedIdxs.push(idx);
          });
          $.ajax({
              url: "cart/cartdelete_selected.jsp", // 단일/선택 동일 JSP!
              type: "POST",
              traditional: true,
              data: { idxs: selectedIdxs }, // 여러개 배열!
              success: function() {
                  checked.each(function() {
                      $(this).closest(".cart-item").remove();
                  });
                  $("#allCheck").prop("checked", false);
                  updateSummary();
              },
              error: function() {
                  alert("선택삭제 실패");
              }
          });
      });
   // 선택상품 주문하기
      $("#orderSelectedBtn").click(function() {
          let checkedIdxs = [];
          $(".item-check:checked").each(function() {
              checkedIdxs.push($(this).val());
          });

          if (checkedIdxs.length === 0) {
              alert("주문할 상품을 선택해주세요.");
              return;
          }

          // 👉 GET 방식으로 결제페이지로 이동 (파라미터에 idxs 전달)
          location.href = "payment/payment.jsp?idxs=" + checkedIdxs.join(",");
      });

      // 전체상품 주문하기
      $("#orderAllBtn").click(function() {
          let allIdxs = [];
          $(".item-check").each(function() {
              allIdxs.push($(this).val());
          });

          if (allIdxs.length === 0) {
              alert("장바구니에 상품이 없습니다.");
              return;
          }
          location.href = "payment/payment.jsp?idxs=" + allIdxs.join(",");
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
   String cartPageUrl = request.getContextPath() + "/index.jsp?main=cart/cartform.jsp"; // 현재 장바구니 페이지 URL
   response.sendRedirect(request.getContextPath() + "/index.jsp?main=login/loginform.jsp&redirect="
   + java.net.URLEncoder.encode(cartPageUrl, "UTF-8"));
   return;
}

CartListDao cartDao = new CartListDao();
List<CartListDto> cartItems = cartDao.getCartListByMember(memberId);
String name = (String) session.getAttribute("name");
%>
<body>

<div class="mypage-content">
        <div class="content-title">
            <ul>
                <li><a onclick="location.href='index.jsp?main=cart/cartform.jsp'" style="color: black; border-bottom: 3px solid black;">장바구니</a></li>
                <li><a onclick="location.href='index.jsp?main=orderlist/orderlistform.jsp'">구매내역</a></li>
                <li><a onclick="location.href='index.jsp?main=category/catewish.jsp'">위시리스트</a></li>
            </ul>
        </div>
    </div>

   <div class="container mt-5" style="margin-top: 5rem !important;">
      <div class="mb-3 text-secondary">
         홈 &gt; 마이페이지 &gt; <b>장바구니 (<%=name%>&nbsp;님)
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
       <img src="<%=item.getMain_image_url()%>" 
        class="cart-img me-5" alt="<%=item.getProduct_name()%>" style="width: 100px; height: 100px;">
         <div class="flex-grow-1">
            <div class="fw-bold"><%=item.getProduct_name()%></div>
            <div class="text-secondary" style="font-size: 14px;"><%=item.getColor()%>
               /
               <%=item.getSize()%></div>         
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
               value="<%=cnt%>" style="width: 100px;" readonly>
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