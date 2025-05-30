<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    .product-detail-container {
      display: flex;
      gap: 40px;
      align-items: flex-start;
    }
    .left-panel, .right-panel {
      flex: 1;
    }
    .img-container {
      max-width: 600px;
      border: 1px solid #ddd;
      overflow: hidden;
      position: relative;
    }
    .zoom-img {
      width: 100%;
      transition: transform 0.3s ease;
    }
    .img-container:hover .zoom-img {
      transform: scale(1.2);
      cursor: zoom-in;
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
    .highlight {
      font-weight: bold;
    }
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
    .slide-panel.open {
      right: 0;
    }
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
    .menu-list li:hover {
      background-color: #f9f9f9;
    }
    .tab_style3 {
      margin-top: 20px;
    }
    .tab_btn {
      padding: 10px 20px;
      font-weight: bold;
      text-decoration: none;
      color: #000;
      cursor: pointer;
    }
    .tab_btn.is_active {
      border-bottom: 2px solid black;
    }
    .tab-content {
      display: none;
      margin-top: 15px;
    }
    .tab-content.active {
      display: block;
    }
  </style>
</head>
<body>
  <div class="product-detail-container">
    <!-- 왼쪽: 이미지 및 탭 -->
    <div class="left-panel">
      <div class="img-container">
        <button id="prevBtn" class="slide-btn" onclick="changeImage(-1)">‹</button>
        <button id="nextBtn" class="slide-btn" onclick="changeImage(1)">›</button>
        <img id="productImage" src="<%= request.getContextPath() %>/image/top/f81.jpg" class="zoom-img" alt="제품 이미지" />
      </div>

      <!-- 탭 버튼 -->
      <div class="tab_style3">
        <a href="javascript:void(0);" class="tab_btn is_active" onclick="showTab('desc', event)">상품 설명</a>
        <a href="javascript:void(0);" class="tab_btn" onclick="location.href='../shop/reviews.jsp'">리뷰</a>
        <a href="javascript:void(0);" class="tab_btn" onclick="showTab('qna', event)">문의 [6]</a>
      </div>

      <!-- 탭 내용 -->
      <div id="tab-desc" class="tab-content active">
        <h2>상품 설명</h2>
        <p>여기에 상품 설명 내용이 들어갑니다.</p>
      </div>
      <div id="tab-review" class="tab-content">
        <h2>리뷰 (59)</h2>
        <strong style="font-size: 40px;">★ 4.9</strong>
        <p><strong>98%</strong>의 구매자가 이 상품을 좋아합니다.</p>
      </div>
      <div id="tab-qna" class="tab-content">
        <h2>문의 (6)</h2>
        <p>문의 목록이 여기에 표시됩니다.</p>
      </div>
    </div>

    <!-- 오른쪽: 상품 정보 -->
    <div class="right-panel">
      <div>
        <div class="tags">무료배송</div>
        <div class="tags">무료포장</div>
      </div>

      <div style="display: flex; justify-content: flex-start; align-items: center; gap: 30px; margin-top: 10px;">
        <div class="product-title">Eoa ribbon blouse</div>
        <div class="item-icons">
          <i class="bi bi-heart"></i>&nbsp;98&nbsp;&nbsp;
          
          <i class="bi bi-eye"></i>&nbsp;72
        </div>
      </div>

      <div class="mt-3" style="margin-top: 15px;">
        <span class="stars">⭐</span>
        <span class="review-link" onclick="goToReviews()" style="cursor:pointer; color:blue;">3개의 리뷰</span>
      </div>

      <div class="price" style="margin-top: 10px; font-size: 20px; font-weight: bold;">89,000원</div>
      <button class="btn btn-info mt-2" onclick="location.href='../login/loginform.jsp'" style="margin-top: 10px;">↓ 쿠폰받기</button>

      <div class="price-info">
        <div><strong>첫 구매가:</strong> 20% <span>71,200원</span></div>
        <div>나의 구매 가능 가격 ▼</div>
      </div>

     
      <div class="mt-2" style="margin-top: 10px;">배송정보: <span class="highlight">3일 이내 출고</span></div>
      <div>
        배송비: <span class="highlight">3,000원</span> (100,000원 이상 구매 시 무료배송)<br />
        제주/도서산간 3,000원 추가
      </div>

      <label for="size" style="margin-top: 15px; display: block;">사이즈</label>
      <select id="size" required>
        <option value="">- [필수] Option -</option>
        <option value="XS">XS</option>
        <option value="S">S</option>
        <option value="M">M</option>
        <option value="L">L</option>
      </select>

      <label for="color" style="margin-top: 10px; display: block;">색상</label>
      <select id="color" required>
        <option value="">- [필수] Color -</option>
        <option value="red">red</option>
        <option value="white">white</option>
      </select>

      <div class="mt-3" style="margin-top: 15px;">
        <label><strong>수량</strong></label>
        <div class="quantity-selector">
          <button id="minus" class="btn btn-secondary" onclick="changeQty(-1)" disabled>-</button>
          <span id="qty">1</span>
          <button class="btn btn-secondary" onclick="changeQty(1)">+</button>
        </div>
      </div>

      <div class="mt-2" style="margin-top: 10px;">
        <strong>총 가격:</strong> <span id="Price">89,000원</span>
      </div>

      <div class="action-buttons">
        <button class="btn btn-outline-primary" onclick="location.href='../cart/cartform.jsp'">장바구니</button>
        <button class="btn btn-primary" onclick="location.href='../payment/payment.jsp'">바로구매</button>
      </div>

      <!-- 메뉴 -->
      <ul class="menu-list">
        <li onclick="openPanel('panel1')">교환 및 환불 <span>›</span></li>
        <li onclick="openPanel('panel2')">배송 안내 <span>›</span></li>
      </ul>

      <!-- 패널 1: 교환 및 환불 -->
      <div id="panel1" class="slide-panel">
        <div class="panel-header">
          교환 및 환불
          <button onclick="closePanel('panel1')">×</button>
        </div>
        <div class="panel-content">
          <strong>배송 전 취소</strong>
          - 입금전 주문취소는 마이페이지에서 직접 가능합니다.<br />
          - 배송전인 상품은 Q&A 게시판, 혹은 이메일로 주문취소 접수가 가능합니다.<br />
          - 주문취소 및 환불은 이메일 혹은 고객센터를 통해 접수가 가능합니다.

          <strong>교환 및 환불</strong>
          - 상품 수령일로부터 7일 이내만 교환/환불 가능합니다.<br />
          - 훼손/파손 우려가 있는 상품은 재포장하여 반송해주세요.<br />
          - 제품과 함께 들어있던 패키지/라벨/사은품도 함께 반송해주세요.<br />
          - 상품불량 또는 파손에 의한 반품은 하이츠에서 부담합니다.<br />
          - 제품이 도착하고 회수처리 완료 후 환불이 진행됩니다.

          <strong>반품 주소</strong>
          SSY<br />
          (01685) 서울시 마포구 양화로17길 22-9 5층<br />
        </div>
      </div>

      <!-- 패널 2: 배송 안내 -->
      <div id="panel2" class="slide-panel">
        <div class="panel-header">
          배송 안내
          <button onclick="closePanel('panel2')">×</button>
        </div>
        <div class="panel-content">
          - 상품별로 상품 특성 및 배송지에 따라 배송유형 및 소요기간이 달라집니다.<br />
          - 일부 주문상품 또는 예약상품의 경우 기본 배송일 외에 추가 배송 소요일이 발생될 수 있습니다.<br />
          - 제주 및 도서산간 지역은 출고, 반품, 교환시 추가 배송비(항공, 도선료)가 부과 될 수 있습니다.<br />
          - 공휴일 및 휴일은 배송이 불가합니다.<br />
          - SSY 자체발송은 오후 2시까지 결제확인된 주문은 당일 출고되고 10만원 이상 주문은 무료배송, 10만원 미만은 3,000원의 배송비가 추가됩니다.<br />
        </div>
      </div>
    </div>
  </div>

  <script>
    const images = [
      "<%= request.getContextPath() %>/image/top/f81.jpg",
      "<%= request.getContextPath() %>/image/top/f82.jpg",
      "<%= request.getContextPath() %>/image/top/f83.jpg",
      "<%= request.getContextPath() %>/image/top/f84.jpg"
    ];
    let currentImageIndex = 0;

    function changeImage(dir) {
      currentImageIndex = (currentImageIndex + dir + images.length) % images.length;
      document.getElementById("productImage").src = images[currentImageIndex];
    }

    function showTab(tab, event) {
      document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
      document.getElementById('tab-' + tab).classList.add('active');

      document.querySelectorAll('.tab_btn').forEach(btn => btn.classList.remove('is_active'));
      event.target.classList.add('is_active');
    }

    
    function goToReviews() {
      showTab('review', { target: document.querySelector('.tab_btn:nth-child(2)') });
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function changeQty(amount) {
      const qtyEl = document.getElementById('qty');
      let qty = parseInt(qtyEl.textContent);
      qty += amount;
      if (qty < 1) qty = 1;
      qtyEl.textContent = qty;

      // minus 버튼 활성/비활성 처리
      document.getElementById('minus').disabled = qty <= 1;

      // 가격 갱신 (예: 기본 89,000원 * 수량)
      const price = 89000 * qty;
      document.getElementById('Price').textContent = price.toLocaleString() + '원';
    }

    function submitOptions(action) {
      alert(action + ' 처리 구현 필요');
    }

    function openPanel(id) {
      document.getElementById(id).classList.add('open');
    }

    function closePanel(id) {
      document.getElementById(id).classList.remove('open');
    }
  </script>
</body>
</html> 