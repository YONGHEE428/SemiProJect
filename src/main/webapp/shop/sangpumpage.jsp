<%@page import="data.dao.MemberDao"%>
<%@page import="data.dao.WishListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dto.ProductOptionDto" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>


<%

    String idParam = request.getParameter("product_id");

    int productId = 0;
    if (idParam != null && !idParam.trim().isEmpty()) {
        productId = Integer.parseInt(idParam);
    } else {
        out.println("<h3 style='color:red;'>잘못된 접근입니다. 상품 ID가 없습니다.</h3>");
        return;
    }

    ProductDao dao = new ProductDao();
    ProductDto product = dao.getProductById(productId);
    List<ProductOptionDto> options = dao.getProductOptionsByProductId(productId);
    dao.updateReadCount(productId);

    Set<String> sizeSet = new LinkedHashSet<>();
    Set<String> colorSet = new LinkedHashSet<>();
    for (ProductOptionDto opt : options) {
        sizeSet.add(opt.getSize());
        colorSet.add(opt.getColor());
    }
    
    BigDecimal price = product.getPrice(); 
    BigDecimal discountRate = new BigDecimal("0.8");
    BigDecimal discountedPrice = price.multiply(discountRate);

    int originalPrice = price.intValue();
    int discountPrice = discountedPrice.intValue();

    DecimalFormat df = new DecimalFormat("#,###");
    boolean isFreeShipping = originalPrice >= 100000;
    
    MemberDao mdao = new MemberDao();
    String id = (String)session.getAttribute("myid");
    int memberId = mdao.getMemberNumById(id);
    WishListDao wdao = new WishListDao();
    boolean checkwish = wdao.checkWish(memberId, productId);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Product Detail</title>

  <!-- Bootstrap & Icons -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }

    .product-page {
      display: flex;
      justify-content: flex-start;
      gap: 10px;
      align-items: flex-start;
      padding-top: 30px;
      padding-bottom: 300px;
      overflow: visible;
      max-width: 1500px;
      margin-left: auto;
      margin-right: auto;
      padding: 0px 20px;
      position: relative;
      min-height: calc(100vh - 300px);
      isolation: isolate;
      background-color: #F9F9F9;
    }

    .left-panel {
      flex: 1;
      align-self: flex-start;
      left: -10px;
      position: relative;
      width: 800px;
      background: white;
    }

    .right-panel { 
      flex: 1; 
      min-width: 320px;
      max-width:600px;
      position: sticky;
      right: 10px;
      top: 100px;
      height: 1000px;
      overflow-y: auto;
      padding: 20px 20px 20px 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      z-index: 1;
    }

    .img-container {
      max-width: 600px;
      width: 100%;
      border: 1px solid #ddd;
      overflow: hidden;
      position: sticky;

      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0 auto;
    }

    .zoom-img {
      max-width: 100%;
      height: auto;
      transition: transform 0.3s ease;
    }

    .slide-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(255, 255, 255, 0.7);
      border: none;
      font-size: 30px;
      width: 40px;
      height: 60px;
      cursor: pointer;
      z-index: 10;
    }

    #prevBtn { left: 0; border-radius: 0 5px 5px 0; }
    #nextBtn { right: 0; border-radius: 5px 0 0 5px; }

    .tags {
      display: inline-block;
      border: 1px solid #ccc;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 12px;
      margin-right: 5px;
    }

    .product-title {
      font-weight: bold;
      font-size: 22px;
      margin: 10px 0;
    }

    .item-icons {
      font-size: 14px;
      color: #666;
    }

    .quantity-selector {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-top: 10px;
    }

    .highlight { font-weight: bold; }

    .action-buttons {
      margin-top: 15px;
      display: flex;
      gap: 10px;
    }

    .price-info {
      margin-top: 10px;
      border: 1px solid #ddd;
      padding: 10px;
      background: #f9f9f9;
    }

    .slide-panel {
      position: fixed;
      top: 0;
      right: -100%;
      width: 100%;
      max-width: 400px;
      height: 100%;
      background: white;
      box-shadow: -2px 0 8px rgba(0, 0, 0, 0.2);
      transition: right 0.3s ease-in-out;
      z-index: 1000;
      overflow-y: auto;
    }

    .slide-panel.open { right: 0; }

    .panel-header {
      display: flex;
      justify-content: space-between;
      padding: 16px;
      font-weight: bold;
      border-bottom: 1px solid #ddd;
    }

    .panel-header button {
      background: none;
      border: none;
      font-size: 20px;
      cursor: pointer;
    }

    .panel-content {
      padding: 16px;
      font-size: 14px;
      line-height: 1.6;
    }

    .panel-content strong {
      display: block;
      margin: 20px 0 8px;
    }

    .menu-list {
      list-style: none;
      padding: 0;
      border-top: 1px solid #e0e0e0;
      margin-top: 20px;
    }

    .menu-list li {
      padding: 16px;
      border-bottom: 1px solid #e0e0e0;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
    }

    .menu-list li:hover { background-color: #f9f9f9; }

    .product-tab {
      background-color: white;
      border-top: 1px solid #ccc;
      border-bottom: 1px solid #ccc;
      margin-top: 20px;
    }

    .tab-menu {
      display: flex;
      justify-content: center;
      font-size: 15px;
      font-weight: 500;
    }

    .tab-item {
      padding: 15px 20px;
      text-decoration: none;
      color: black;
      border-bottom: 2px solid transparent;
      transition: border-color 0.3s, font-weight 0.3s;
    }

    .tab-item.active {
      font-weight: bold;
      border-color: black;
    }

    .sticky-fixed {
     position: static;
      top: 0;
      left: 0;
      right: 0;
      z-index: 999;
      background: white;
      border-bottom: 1px solid #ccc;
    }

    section {
      padding: 100px 20px;
      border-bottom: 1px solid #eee;
    }

    h2 { margin-top: 0; }
    
    .modal {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.4);
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 300px;
    text-align: center;
    position: relative;
}

.close-btn {
    position: absolute;
    right: 10px; top: 10px;
    cursor: pointer;
    font-size: 20px;
}

.btn-black {
    background: black;
    color: white;
    padding: 8px 16px;
    border: none;
    margin-right: 10px;
    cursor: pointer;
}

.btn-white {
    border: 1px solid black;
    padding: 8px 16px;
    background: white;
    cursor: pointer;
}
.btn-black-custom {
  background-color: black;
  color: white;
  border: none;
  padding: 12px 0;
  width: 100%;
  font-size: 16px;
  font-weight: bold;
  border-radius: 6px;
  transition: background-color 0.3s;
}

.btn-black-custom:hover {
  background-color: #333;
}
  </style>
</head>

<body>
<!-- 숨겨진 필드 추가 -->
<input type="hidden" id="productId" value="<%= product.getProductId() %>">
<input type="hidden" id="optionId">

<!-- Product Layout -->
<div class="product-page">

  <!-- Left Panel: Image + Tabs -->
  <div class="left-panel">
   <!-- 이미지 영역 -->
<div class="img-container">
 <img id="productImage" src="<%= product.getMainImageUrl() %>" class="zoom-img" />
</div>

    <div class="product-tab sticky" id="tabMenu">
      <div class="tab-menu">
        <a href="#desc" class="tab-item active" onclick="selectTab(this)">상품 설명</a>
        <a href="#reviews" class="tab-item" onclick="selectTab(this)">리뷰</a>
        <a href="#qna" class="tab-item" onclick="selectTab(this)">문의</a>
      </div>
    </div>

   <!-- 상품 설명 -->
<section id="desc"><h2>상품 설명</h2><%= product.getDescription() %></section>
   <section id="reviews"><h2>리뷰</h2></section>
   <!-- 리뷰 작성 버튼 -->
<button onclick="openReviewModal()">리뷰 작성</button>
    <section id="qna"><h2>문의</h2></section>
  </div>

  <!-- Right Panel: Info -->
  <div class="right-panel">
  
<% if (isFreeShipping) { %>
  <div><span class="tags">무료배송</span></div>
<% } %>
    
    <div class="d-flex align-items-center gap-4 mt-2" >
     <div class="product-title"><%= product.getProductName() %>&nbsp;&nbsp;&nbsp;<br></div>
    </div>
    <div class="item-icons">
      <%if(checkwish ==true){ %>
      	<i class ="bi bi-heart-fill" style="color: red; font-style: normal; font-size:18px;">&nbsp;<%=product.getLikeCount()%>&nbsp;&nbsp;</i>
      	<%}else{ %>
       <i class="bi bi-heart" style="font-style: normal; font-size:18px;">&nbsp;<%=product.getLikeCount()%>&nbsp;&nbsp;</i>
       <%} %>
		<i class="bi bi-eye" style="font-size:18px; font-style: normal;">&nbsp;<%= product.getViewCount()%></i>
      </div>

    <div class="mt-3">
      <span class="stars">⭐</span> 
      <span class="review-link text-primary" onclick="goToReviews()" style="cursor:pointer;">리뷰</span>
    </div>

<!-- 상품 가격 -->
<div class="price mt-2" style="font-size: 20px; font-weight: bold;">
  <%= df.format(originalPrice) %>원
</div>

<!-- 첫 구매가 -->
<div class="price-info mt-2">
  <div>나의 구매 가능 가격 ▼</div>
  <div><strong>첫 구매가:</strong> 20% <span><%= df.format(discountPrice) %>원</span></div>
</div>



    <div class="mt-2">배송정보: <span class="highlight">3일 이내 출고</span></div>
    <div>배송비: <span class="highlight">3,000원</span> (10만원 이상 무료배송, 제주/도서산간 3,000원 추가)</div>

    <label for="size" class="mt-3 d-block">사이즈</label>
<select id="size" class="form-control" required>
  <option value="">- [필수] Option -</option>
  <% for (String size : sizeSet) { %>
    <option value="<%= size %>"><%= size %></option>
  <% } %>
</select>

    <label for="color" class="mt-2 d-block">색상</label>
<select id="color" class="form-control" required>
  <option value="">- [필수] Color -</option>
  <% for (String color : colorSet) { %>
    <option value="<%= color %>"><%= color %></option>
  <% } %>
</select>

    <div class="mt-3">
      <label><strong>수량</strong></label>
      <div class="quantity-selector">
        <button id="minus" class="btn btn-secondary" onclick="changeQty(-1)" disabled>-</button>
        <span id="qty">1</span>
        <button class="btn btn-secondary" onclick="changeQty(1)">+</button>
      </div>
    </div>
    <script>
    let quantity = 1;
    const pricePerUnit = <%= originalPrice %>;

    function changeQty(delta) {
      if (delta === -1 && quantity > 1) {
        quantity--;
      } else if (delta === 1) {
        if (quantity >= 5) {
          showLimitModal();
          return;
        }
        quantity++;
      }
      updateTotalPrice();
    }

    function updateTotalPrice() {
      const total = pricePerUnit * quantity;
      document.getElementById("qty").textContent = quantity;
      document.getElementById("Price").textContent = total.toLocaleString() + "원";
      document.getElementById("minus").disabled = quantity === 1;
    }

    document.addEventListener("DOMContentLoaded", updateTotalPrice);

function showLimitModal() {
  document.getElementById("limitModal").style.display = "flex";
}

function closeLimitModal() {
  document.getElementById("limitModal").style.display = "none";
}

document.addEventListener("DOMContentLoaded", updateTotalPrice);
</script>
    <div id="limitModal" class="modal" style="display: none;">
  <div class="modal-content">
    <span class="close-btn" onclick="closeLimitModal()">×</span>
    <h4>알림</h4>
    <p>최대 구매 가능 수량은 5개입니다.</p>
    <button onclick="closeLimitModal()" class="btn-black">확인</button>
  </div>
</div>

    <div class="mt-2"><strong>총 가격:</strong> <span id="Price"></span></div>

    <div class="action-buttons">
  <%
    boolean isLoggedIn = session.getAttribute("userId") != null;
%>


<div class="action-buttons">
  <button id="addToCartBtn" class="btn btn-black-custom">장바구니</button>
<button class="btn btn-black-custom" onclick="location.href='../payment/payment.jsp'">바로구매</button>
</div>

<!-- 모달 -->
<div id="cartModal" class="modal" style="display: none;">
  <div class="modal-content">
    <span class="close-btn" onclick="closeModal()">×</span>
    <h3>장바구니 담기</h3>
    <p>선택하신 상품을 장바구니에 담았습니다.<br>지금 장바구니를 확인하시겠습니까?</p>
    <button onclick="goToCart()" class="btn-black">장바구니 확인</button>
    <button onclick="continueShopping()" class="btn-white">쇼핑 계속하기</button>
  </div>
</div>

<script>
const isLoggedIn = <%= isLoggedIn %>;

// 옵션 ID 자동 생성 (예: opt-M-red)
function updateOptionId() {
    const size = document.getElementById("size").value;
    const color = document.getElementById("color").value;
    const optionId = document.getElementById("optionId");

    if (size && color) {
        optionId.value = opt-${size}-${color}; // 조합 방식 (임시 예시)
    } else {
        optionId.value = "";
    }
}

document.getElementById("size").addEventListener("change", updateOptionId);
document.getElementById("color").addEventListener("change", updateOptionId);

document.getElementById("addToCartBtn").addEventListener("click", function() {
    const productId = <%= productId %>; // 제품 번호
    const size = document.getElementById("size").value;
    const color = document.getElementById("color").value;
    const quantity = document.getElementById("qty").textContent;

    if (!size || !color) {
        alert("옵션을 모두 선택해주세요.");
        return;
    }

    // form 생성 및 전송
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "shop/addcart.jsp";

    // hidden input 추가
    const fields = {
        'product_id': productId,
        'size': size,
        'color': color,
        'quantity': quantity
    };

    for (const [key, value] of Object.entries(fields)) {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = key;
        input.value = value;
        form.appendChild(input);
    }

    document.body.appendChild(form);
    form.submit();
});

function showModal() {
    document.getElementById("cartModal").style.display = "block";
}
function closeModal() {
    document.getElementById("cartModal").style.display = "none";
}
function goToCart() {
    window.location.href = "../index.jsp?main=cart/cartform.jsp";
}
function continueShopping() {
    closeModal();
    window.location.href = "../index.jsp?main=category/category.jsp";
}
</script>
     
    </div>

    <ul class="menu-list">
      <li onclick="openPanel('panel1')">교환 및 환불 <span>›</span></li>
      <li onclick="openPanel('panel2')">배송 안내 <span>›</span></li>
    </ul>

    <div id="panel1" class="slide-panel">
      <div class="panel-header">교환 및 환불<button onclick="closePanel('panel1')">×</button></div>
     <strong>배송 전 취소</strong><br>
          - 입금전 주문취소는 마이페이지에서 직접 가능합니다.<br />
          - 배송전인 상품은 Q&A 게시판, 혹은 이메일로 주문취소 접수가 가능합니다.<br />
          - 주문취소 및 환불은 이메일 혹은 고객센터를 통해 접수가 가능합니다.<br />

          <strong>교환 및 환불</strong><br />
          - 상품 수령일로부터 7일 이내만 교환/환불 가능합니다.<br />
          - 훼손/파손 우려가 있는 상품은 재포장하여 반송해주세요.<br />
          - 제품과 함께 들어있던 패키지/라벨/사은품도 함께 반송해주세요.<br />
          - 상품불량 또는 파손에 의한 반품은 하이츠에서 부담합니다.<br />
          - 제품이 도착하고 회수처리 완료 후 환불이 진행됩니다.<br />

          <strong>반품 주소</strong><br />
          SSY<br />
          (01685) 서울시 마포구 양화로17길 22-9 5층<br />
    </div>

    <div id="panel2" class="slide-panel">
      <div class="panel-header">배송 안내<button onclick="closePanel('panel2')">×</button></div>
   <div class="panel-content">
          - 상품별로 상품 특성 및 배송지에 따라 배송유형 및 소요기간이 달라집니다.<br />
          - 일부 주문상품 또는 예약상품의 경우 기본 배송일 외에 추가 배송 소요일이 발생될 수 있습니다.<br />
          - 제주 및 도서산간 지역은 출고, 반품, 교환시 추가 배송비(항공, 도선료)가 부과 될 수 있습니다.<br />
          - 공휴일 및 휴일은 배송이 불가합니다.<br />
          - SSY 자체발송은 오후 2시까지 결제확인된 주문은 당일 출고되고 10만원 이상 주문은 무료배송, 10만원 미만은 3,000원의 배송비가 추가됩니다.<br />
        </div>
       
    </div>
    <div style="margin-top: 20px; text-align: right; width: 200px; height:900;" >
      <img src="../image/sale.png" alt="여름 아이템 할인 배너" style="max-width: 100%; height: auto;" />
    </div>
  </div>
</div>

<!-- Script -->
<script>
 
 
  function goToReviews() {
    const reviewsSection = document.getElementById("reviews");
    window.scrollTo({ top: reviewsSection.offsetTop - 100, behavior: "smooth" });
  }

  function openPanel(id) {
    document.getElementById(id).classList.add("open");
  }

  function closePanel(id) {
    document.getElementById(id).classList.remove("open");
  }

  function selectTab(el) {
    document.querySelectorAll(".tab-item").forEach(tab => tab.classList.remove("active"));
    el.classList.add("active");
  }

  window.addEventListener("scroll", () => {
    const tabMenu = document.getElementById("tabMenu");
    const tabOffset = tabMenu.offsetTop;

    tabMenu.classList.toggle("sticky-fixed", window.scrollY >= tabOffset);

    const sections = ["desc", "reviews", "qna"];
    let current = "";
    sections.forEach(id => {
      const section = document.getElementById(id);
      if (window.scrollY >= section.offsetTop - 150) current = id;
    });

    document.querySelectorAll(".tab-item").forEach(el => {
      el.classList.toggle("active", el.getAttribute("href") === #${current});
    });
  });

  document.addEventListener("DOMContentLoaded", function() {
    const rightPanel = document.querySelector('.right-panel');
    const productPage = document.querySelector('.product-page');
  });
</script>

</body>
</html>