<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
      
    /* 메뉴 리스트 */
    .menu-list {
      list-style: none;
      padding: 0;
      margin: 0;
      border-top: 1px solid #e0e0e0;
    }

    .menu-list li {
      padding: 16px;
      border-bottom: 1px solid #e0e0e0;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .menu-list li:hover {
      background-color: #f9f9f9;
    }

    /* 슬라이드 패널 공통 스타일 */
    .slide-panel {
      position: fixed;
      top: 0;
      right: -100%;
      width: 100%;
      max-width: 400px;
      height: 100%;
      background-color: white;
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
      align-items: center;
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
      margin-top: 20px;
      margin-bottom: 8px;
    }
  </style>
</head>
<body>

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
      - 입금전 주문취소는 마이페이지에서 직접 가능합니다.<br>
      - 배송전인 상품은 Q&A 게시판, 혹은 이메일로 주문취소 접수가 가능합니다.<br>
      - 주문취소 및 환불은 이메일 혹은 고객센터를 통해 접수가 가능합니다.

      <strong>교환 및 환불</strong>
      - 상품 수령일로부터 7일 이내만 교환/환불 가능합니다.<br>
      - 훼손/파손 우려가 있는 상품은 재포장하여 반송해주세요.<br>
      - 제품과 함께 들어있던 패키지/라벨/사은품도 함께 반송해주세요.<br>
      - 상품불량 또는 파손에 의한 반품은 하이츠에서 부담합니다.<br>
      - 제품이 도착하고 회수처리 완료 후 환불이 진행됩니다.

      <strong>반품 주소</strong>
       SSY<br>
      (01685) 서울시 마포구 양화로17길 22-9 5층<br>

    </div>
  </div>

  <!-- 패널 2: 배송 안내 -->
  <div id="panel2" class="slide-panel">
    <div class="panel-header">
      배송 안내
      <button onclick="closePanel('panel2')">×</button>
    </div>
    <div class="panel-content">
      
     - 상품별로 상품 특성 및 배송지에 따라 배송유형 및 소요기간이 달라집니다. <br>
     - 일부 주문상품 또는 예약상품의 경우 기본 배송일 외에 추가 배송 소요일이 발생될 수 있습니다. <br>
     - 제주 및 도서산간 지역은 출고, 반품, 교환시 추가 배송비(항공, 도선료)가 부과 될 수 있습니다. <br>
     - 공휴일 및 휴일은 배송이 불가합니다. <br>
     - SSY 자체발송은 오후 2시까지 결제확인된 주문은 당일 출고되고  10만원 이상 주문은 무료배송, 10만원 미만은 3,000원의 배송비가 추가됩니다. <br>
    </div>
  </div>

  <script>
    function openPanel(id) {
      document.getElementById(id).classList.add('open');
    }

    function closePanel(id) {
      document.getElementById(id).classList.remove('open');
    }
  </script>
</body>
</html>