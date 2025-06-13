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

<html>
<%boolean isLoggedIn = session.getAttribute("myid") != null; %>
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
      width: 700px;
      background: white;
    }

    .right-panel { 
      flex: 1; 
      min-width: 320px;
      max-width:600px;
      position: sticky;
      right: 10px;
      top: 150px;
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
  font-size:15px; 
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

section h2 {
  font-size: 20px;
  font-weight: bold;
  
 .qna-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}
.qna-header h2 {
  margin: 0;
  font-size: 22px;
  font-weight: 700;
}

.qna-header button {
  padding: 6px 14px;
  border-radius: 5px;
  border: 1px solid #888;
  background: #fff;
  cursor: pointer;
  font-size: 1rem;
}

.tab-section {
  max-width: 650px;
  margin: 0 auto;
  padding: 0 16px;
}
#review-list-container {
  margin-top: 16px;
}
.review-card {
  border: 1px solid #e1e1e1;
  border-radius: 8px;
  padding: 18px 22px;
  margin-bottom: 18px;
  background: #fff;
  width: 100%;
  box-sizing: border-box;
  text-align: left;
}

/* 버튼 공통 스타일 */
.modern-button {
    padding: 12px 24px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 15px;
    transition: all 0.3s ease;
    cursor: pointer;
    border: none;
    text-align: center;
    width: 100%;
}

/* 메인 버튼 (바로구매) */
.btn-primary.modern-button {
    background-color: #000;
    color: white;
    border: none;
}

.btn-primary.modern-button:hover {
    background-color: #333;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* 보조 버튼 (장바구니) */
.btn-outline-primary.modern-button {
    background-color: white;
    color: #000;
    border: 1.5px solid #000;
}

.btn-outline-primary.modern-button:hover {
    background-color: #f8f8f8;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 문의 작성 버튼 */
.inquiry-button {
    background-color: #f8f8f8;
    color: #333;
    padding: 10px 20px;
    border-radius: 6px;
    border: 1px solid #ddd;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
}
.inquiry-button:hover {
    background-color: #eee;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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

    <!-- 탭 메뉴 -->
<div class="product-tab sticky" id="tabMenu">
  <div class="tab-menu">
    <a href="#desc"    class="tab-item active" onclick="selectTab(this)">상품 설명</a>
    <a href="#reviews" class="tab-item"        onclick="selectTab(this)">리뷰</a>
    <a href="#qna"     class="tab-item"        onclick="selectTab(this)">문의</a>
  </div>
</div>

<section id="desc" class="tab-section active">
  <h2>상품 설명</h2>
  <%= product.getDescription() %>
</section>

<section id="reviews" class="tab-section">
  <h2>&nbsp; 리뷰</h2>
  <div id="review-list-container">
    <jsp:include page="reviewList.jsp" flush="true">
      <jsp:param name="product_id" value="<%= product.getProductId() %>" />
    </jsp:include>
  </div>
</section>

<section id="qna" class="tab-section">
  <div class="qna-header">
    <h2>문의</h2>
    <button type="button" class="inquiry-button" onclick="openInquiryModal()">문의 작성</button>
  </div>
  <!-- 문의 목록 -->
  <div id="qna-list-container">
    <jsp:include page="/shop/q&alist.jsp" flush="true">
      <jsp:param name="product_id" value="<%= product.getProductId() %>" />
    </jsp:include>
  </div>
</section>
<!-- 파라미터(product_id)와 함께 포함 -->
    <jsp:include page="/shop/writeInquiryModal.jsp" flush="true">
      <jsp:param name="product_id" value="<%= product.getProductId() %>" />
    </jsp:include>
  </div>
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

</script>
   
    <div class="mt-2"><strong>총 가격:</strong> <span id="Price"></span></div>

    <div class="action-buttons">
      <button id="addToCartBtn" class="btn btn-outline-primary modern-button">장바구니</button>
      <button id="buyNowBtn" class="btn btn-primary modern-button">바로구매</button>
    </div>

    <script>
    // 장바구니 추가 함수
    function addToCart(redirect) {
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

        if (redirect) {
            fields['redirect'] = redirect;
        }

        for (const [key, value] of Object.entries(fields)) {
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = key;
            input.value = value;
            form.appendChild(input);
        }

        document.body.appendChild(form);
        form.submit();
    }

    // 장바구니 버튼 클릭 이벤트
    document.getElementById("addToCartBtn").addEventListener("click", function() {
        addToCart();
    });

    // 바로구매 버튼 클릭 이벤트
    document.getElementById("buyNowBtn").addEventListener("click", function() {
        addToCart('payment');
    });
    </script>
    <br>   
    <!-- 오른쪽 하단에 있는 메뉴 -->
    <jsp:include page="guide.jsp" />

    <div id="panel1" class="slide-panel">
      <div class="panel-header">교환 및 환불<button onclick="closePanel('panel1')">×</button></div>
      <div class="panel-content">...</div>
    </div>
    <div id="panel2" class="slide-panel">
      <div class="panel-header">배송 안내<button onclick="closePanel('panel2')">×</button></div>
      <div class="panel-content">...</div>
    </div>
    
    <div style="margin-top: 20px; text-align: right; width: 200px; height:900;" >
      <img src="shop/sale.png"  alt="여름 아이템 할인 배너" style="max-width: 100%; height: auto;" />
    </div>
  </div>

<script>
function openInquiryModal(){
	  const modal = document.getElementById('inquiryModal');
	  modal.style.display = 'flex';  // 중요: flex로 지정해야 가운데 정렬됨
	}

	function closeInquiryModal(){
	  const modal = document.getElementById('inquiryModal');
	  modal.style.display = 'none';
	}
 
  function goToReviews() {
    const reviewsSection = document.getElementById("reviews");
    window.scrollTo({ top: reviewsSection.offsetTop - 100, behavior: "smooth" });
  }

  function openPanel(id) {
	  const panel = document.getElementById(id);
	  if (panel) {
	    panel.classList.add('open');
	  }
	}
	function closePanel(id) {
	  const panel = document.getElementById(id);
	  if (panel) {
	    panel.classList.remove('open');
	  }
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
      el.classList.toggle("active", el.getAttribute("href") === "#" + current);
    });
  });

</script>

</body>
</html>