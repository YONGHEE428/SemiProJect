<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nanum+Myeongjo&family=Sunflower:wght@300&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<!-- 주소검색 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- 아임포트(이니페이) -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <title>결제하기</title>
    <link rel="stylesheet" href="payment.css">
<style type="text/css">
	/* 전역 스타일 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', sans-serif;
    line-height: 1.6;
    color: #333;
}

/* 헤더 스타일 */
header {
    width: 100%;
}

.top-header {
    background-color: #fff;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
}

.left-section {
    display: flex;
    align-items: center;
    gap: 20px;
}

.slide-menu-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px;
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.slide-menu-btn span {
    display: block;
    width: 20px;
    height: 2px;
    background-color: #333;
}

.shop-name {
    font-size: 1.5rem;
    font-weight: bold;
    cursor: pointer;
}

.user-menu {
    display: flex;
    gap: 20px;
    align-items: center;
}

.user-menu a {
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
}

.user-info {
    font-size: 0.9rem;
}

.main-menu {
    background-color: #fff;
    padding: 10px 20px;
    display: flex;
    justify-content: center;
    gap: 40px;
    border-bottom: 1px solid #eee;
}

.main-menu a {
    text-decoration: none;
    color: #333;
    font-weight: 500;
}

/* 주문 섹션 스타일 */
.order-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
}

.order-section h2 {
    font-size: 30px;
    margin-bottom: 20px;
}

.order-list {
    border: 1px solid #eee;
    padding: 20px;
    min-height: 200px;
}

/* 주문자 정보 섹션 스타일 */
.customer-info-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
    display: flex;
    gap: 20px;
}

.info-container {
    flex: 1;
}

.customer-form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.form-group {
    display: flex;
    gap: 10px;
}

.form-group input,
.form-group textarea {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.address-search-btn {
    padding: 10px 20px;
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}

.message-box textarea {
    width: 100%;
    resize: none;
}

.ad-container {
    width: 200px;
}

.ad-space {
    width: 100%;
    height: 320px;
    background-color: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #ddd;
}

/* 결제 섹션 스타일 */
.payment-section {
    padding: 20px;
    margin: 20px auto;
    max-width: 1200px;
}

.payment-container {
    border: 1px solid #eee;
    padding: 20px;
}

.payment-methods {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.payment-method-btn {
    padding: 10px 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}

.payment-method-btn:hover {
    background-color: #f8f8f8;
}

.payment-details {
    min-height: 100px;
    margin-bottom: 20px;
}

.payment-submit-btn {
    display: block;
    width: 200px;
    padding: 15px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-left: auto;
}

.payment-submit-btn:hover {
    background-color: #444;
}
</style>
<script type="text/javascript">
	$(function(){
		/* 주문자정보 감추기 */
		/* $(".customer-form").hide(); */
		/* 결제정보 감추기 */
		 $(".form-select").change(function(){
	            var m = $(".form-select option:selected").text();
	            if(m==="직접 입력"){
	            	$("#mymessage").show();
	            }
	        });
		//주소창
    	$("#findaddress").click(function(){
    		new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		        	document.getElementById("userAddress").value = data.address;//주소넣기
		        	document.getElementById("userPostCode").value = data.zonecode;//우편번호넣기
		        	var inputDtlAddr = document.getElementById("userDtlAddress");//주소란 읽기전용 설정
		        	inputDtlAddr.readOnly = false;
		        }
		    }).open();
    	});
		$("#canceladdress").click(function(){
			var inputPostCode = document.getElementById("userPostCode");
			inputPostCode.value = ""; // 우편번호 초기화
			var inputAddr = document.getElementById("userAddress");
			inputAddr.value = ""; // 주소란 초기화
			var inputDtlAddr = document.getElementById("userDtlAddress");
			inputDtlAddr.value = ""; // 상세주소란 초기화
			inputDtlAddr.readOnly = true; // 상세주소란 읽기전용 해제
		});
		
	});
	 function KGpay(){
		 var IMP = window.IMP;
		    IMP.init('결제테스트'); // 가맹점 식별코드 입력

		 //iamport 대신 자신의 "가맹점 식별코드"를 사용
		  IMP.request_pay({
		    pg: "inicis",
		    pay_method: "card",
		    merchant_uid : 'merchant_'+new Date().getTime(),
		    name : '결제테스트',
		    amount : 100,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
		  }, function (rsp) { // callback
			  if (rsp.success) {
		            // 결제 성공 시 로직
		            alert('결제가 완료되었습니다.\n' + 
		                '고유ID : ' + rsp.imp_uid + '\n' +
		                '상점 거래ID : ' + rsp.merchant_uid + '\n' +
		                '결제 금액 : ' + rsp.paid_amount + '\n' +
		                '카드 승인번호 : ' + rsp.apply_num);
		                
		            // 여기에 결제 성공 후 이동할 페이지 지정
		            // location.href = '결제성공페이지URL';
		            
		        } else {
		            // 결제 실패 시 로직
		            alert('결제에 실패하였습니다.\n' + 
		                '에러내용: ' + rsp.error_msg);
		        }
		  });
     }
</script>
<%
   //프로젝트 경로구해기
   String root=request.getContextPath();
%>
</head>
<body>
    <header>
        <div class="top-header">
            <div class="left-section">
                <button class="slide-menu-btn">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
                <h1 class="shop-name">
                <img src="<%=root%>/SemiImg/mainLogo.png" class="y_mainlogo" 
                	style="width: 150px;">
				</h1>
            </div>
            <div class="right-section">
                <nav class="user-menu">
                    <a href="#">매장찾기</a>
                    <a href="#">고객센터</a>
                    <span class="user-info">이름(아이디)님</span>
                    <a href="#">장바구니</a>
                    <a href="#">마이페이지</a>
                    <a href="#">로그아웃</a>
                </nav>
            </div>
        </div>
        
    </header>

    <!-- 주문 섹션 -->
    <section class="order-section">
        <h2>주문목록</h2>
        <div class="order-list">
            <!-- 주문 상품 목록이 여기에 들어갑니다 -->
        </div>
    </section>

    <!-- 주문자 정보 섹션 -->
    <section class="customer-info-section">
        <div class="info-container">
            <h2 class="orderer">주문자 정보</h2>
            <form class="customer-form">
                <div class="form-group" style="width: 100px;">
                    <input type="text" placeholder="주문자명">
                </div>
                <div class="form-group" style="width: 250px;">
                    <input type="tel" placeholder="번호(-없이 입력)" >
                </div>
                <div class="form-group address-group">
                    <span><h3>주소</h3></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-outline-secondary"
                    id="findaddress"><fmt:message key="code_search"/>주소찾기</button>
                    <button type="button" class="btn btn-outline-danger" 
                   id="canceladdress"><fmt: message key="code_cancel"/>취소</button>
                </div>
                <!-- 우편번호 -->
     <div class="mb-2 d-flex align-items-center" style="width: 300px;">
    <label for="userPostCode" class="form-label mb-0 me-2" 
    style="white-space: nowrap; padding: 5px;">우편번호&nbsp;&nbsp;</label>
    <input type="text" class="form-control form-control-sm" id="userPostCode" name="userPostCode" readonly style="width: 120px;">
</div>
<!-- 주소 -->
<div class="mb-2 d-flex align-items-center" style="width: 450px; padding: 5px; gap: 10px;">
    <label for="userAddress" class="form-label mb-0" 
    style="width: 60px; margin-right: 22px;">주소</label>
    <input type="text" class="form-control" id="userAddress" name="userAddress" readonly style="flex-grow: 1; min-width: 0;">
</div>

<!-- 상세주소 -->
<div class="mb-2 d-flex align-items-center" style="width: 450px; padding: 5px; gap: 10px;">
    <label for="userDtlAddress" class="form-label mb-0" style="width: 90px;">상세주소</label>
    <input type="text" class="form-control" id="userDtlAddress" name="userDtlAddress" maxlength="100" readonly style="flex-grow: 1; min-width: 0;">
</div>    
             <section>
             <span style="padding: 5px;">이메일</span><br><br>          
                <div class="form-group" style="width: 450px;">
                    <input type="email" placeholder="이메일" 
                    required="required">
                </div>
                <br>
                <div class="form-group">
                	<span style="padding: 5px;">배송 전 메세지</span>
                </div><br>
                <div class="form-group" style="margin-bottom: 10px; width: 450px;">
                    <select class="form-select">
                    	<option class="msg" id="message1">부재 시 경비실에 맡겨주세요.</option>
                    	<option class="msg" id="message2">문 앞에 놔두고 가세요.</option>
                    	<option class="msg" id="message3">배송 전 연락주세요.</option>
                    	<option class="msg" id="message4">직접 입력</option>
                    </select>
                </div>
                
                		
                <div class="form-group message-box" id="mymessage" 
                style="display: none;">
                
                    <textarea rows="3" placeholder="메세지 입력"></textarea>
                </div>
             </section>
              
            </form>
        </div>
        <div class="ad-container">
            <div class="ad-space" style="height: 500px;">광고</div>
        </div>
    </section>

    <!-- 결제 섹션 -->
    <section class="payment-section">
        <h2>결제</h2>
        <div class="payment-container">
            <div class="payment-methods">
                <button class="payment-method-btn">카드결제</button>
                <button class="payment-method-btn">네이버페이</button>
              	<button class="payment-method-btn">카카오페이</button>
            </div>
            <div class="payment-details">
                <!-- 결제 상세 정보가 여기에 들어갑니다 -->
            </div>
            <button type="button" class="payment-submit-btn" onclick="KGpay()">결제요청</button>
        </div>
    </section>
</body>
</html> 