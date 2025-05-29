<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<style>
	.guide-main{
		width: 100%;
		height: 100%;
		padding: 50px 400px 0 400px;;
	}
	.guide-content{
		font-size: 0.8em;
	}
	.guide-content > hr{
		color: gray;
		border: none; 
		border-top: 2px dotted #888;
	}
</style>
<body>
<div class="guide-main"> 
<div class="guide-content" style="line-height: 1.7;">
	  <h4>🛍 SSY.COM 쇼핑 이용안내</h4>
	  <hr>
	
	  <h5>📌 회원가입 안내</h5>
	  SSY.COM을 방문해주셔서 진심으로 감사드립니다.<br>
	  저희 쇼핑몰은 <strong>회원제를 운영</strong>하고 있습니다.<br>
	  - 회원으로 <a href="index.jsp?main=member/memberform.jsp" style="color: red;">[가입]</a>하시면 <strong>더욱 다양한 혜택과 편리한 서비스</strong>를 이용하실 수 있습니다.<br>
	  - <strong>비회원</strong>으로도 상품을 구매하실 수 있으나, 주문 조회나 적립금 등의 혜택은 제공되지 않습니다.<br><hr>
	  
	
	  <h5>🛒 상품 주문방법</h5>
	  1. 메뉴에서 원하는 <strong>카테고리(여성의류, 남성의류 등)</strong>를 선택하세요.<br>
	  2. 상품 목록에서 원하는 상품의 <strong>이미지나 이름을 클릭</strong>해 상세페이지로 이동합니다.<br>
	  3. 사이즈 및 수량을 선택한 후, <strong>[장바구니 담기]</strong> 버튼을 누릅니다.<br>
	  4. 장바구니 페이지에서 상품을 확인하고 <strong>[주문하기]</strong> 버튼을 클릭합니다.<br>
	  5. <strong>배송지 정보 및 결제 방법을 입력</strong>한 후 [결제하기]를 누르면 주문이 완료됩니다.<br><hr>
	
	  <h5>🚚 배송안내</h5>
	  - 배송방법: 택배 (CJ대한통운)<br>
	  - 배송지역: 전국<br>
	  - 배송기간:<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 입금 확인일로부터 <strong>3~6일 이내</strong> 발송됩니다.<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 연휴 및 주말 주문 건은 다소 지연될 수 있습니다.<br>
	  - 배송비:<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• <strong>50,000원 이상 구매 시 무료배송</strong><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• <strong>50,000원 미만 시 기본 배송비 3,000원</strong><br><hr>
	
	  <h5>🔄 교환 및 반품 안내</h5>
	  - 상품 수령 후 <strong>7일 이내</strong> 교환/반품 신청이 가능합니다.<br>
	  - 교환 및 반품은 [마이페이지 → 주문조회]에서 신청하실 수 있습니다.<br>
	  - <strong>고객 변심에 의한 반품/교환 시 배송비는 고객 부담</strong>입니다.<br>
	  - <strong>상품 불량, 오배송 등 당사 과실로 인한 반품/교환은 전액 무료</strong>입니다.<br>
	  - 다음과 같은 경우 교환/반품이 불가능합니다:<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 택 제거, 착용 흔적, 세탁한 경우<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 상품 수령 후 7일 경과<br><hr>
	
	  <h5>💳 결제안내</h5>
	  - 결제 수단:<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 신용카드 (국내 모든 카드 가능)<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 실시간 계좌이체<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 가상계좌<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 휴대폰 결제<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;• 적립금/쿠폰 사용 가능<br><hr>
	
	  <h5>📞 고객센터</h5>
	  - 운영시간: <strong>평일 10:00 ~ 17:00 (점심시간 12:30 ~ 13:30)</strong><br>
	  - 전화: <strong>1111-2222</strong><br>
	  - 이메일: <strong>help@ssy.com</strong><br>
	  - 문의사항은 [고객센터 → 1:1 문의]를 통해 접수해 주세요.<br><hr>
	
	  <h5>🔒 개인정보처리방침</h5>
	  - 고객의 개인정보는 안전하게 보호되며, 자세한 내용은 <a class="Footer-link" href="#" rel="noopener noreferrer" onclick="openPrivacy()" style="color: red;">[개인정보처리방침]</a>에서 확인하실 수 있습니다.<br>
	  - 담당자: <strong>홍길동</strong><br>
	  - 연락처: <strong>privacy@ssy.com / 02-1234-5678</strong><br><br>
</div>
</div>
<script type="text/javascript">
	function openPrivacy(){
		window.open(
			'Privacy.jsp',
			'개인정보방침',
			'width=600,height=500,top=100,left=200,resizable=yes,scrollbars=yes'
		)
		
	}
</script>
</body>
</html>