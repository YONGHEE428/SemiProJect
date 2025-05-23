<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style>
	 .gaip {
		font-family:monospace;
		margin-bottom:-200px;
	}
	div>b{
		color: black;
		

	}
	label{
		font-weight: bold;
		padding-top: 20px ;
	}
	#hpCheck,#pinCheck,#hewongaip,#btnCheck{
		width:110px;
	    font-weight: 500;
	    line-height: 1.5;
	    text-align: center;
	    text-decoration: none;
	    white-space: nowrap;
	    vertical-align: middle;
	    cursor: pointer;
	    border: 0;
	    border-radius: .313rem;
	    background-color: #d9d9d9;
	    color: #fff;
	}
	 #selemail{
	 background-color: white;}
	#hpCheck:hover,#pinCheck:hover,#btnCheck:hover,{
		 background-color: black;

	}
	input{
		height: 50px;
		font-family:none;
	}
	 .terms-wrapper {
            width: 100%;
            margin: 40px auto;
            font-family: none;
        }

        .terms-box {
            height: 400px; /* 원하는 높이 조정 가능 */
            overflow-y: scroll;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            background-color: #fefefe;
            font-size: 14px;
            line-height: 1.6;
            font-family: none;
        }
	
</style>
<script type="text/javascript">

   $(function(){
		//인증번호 입력창 숨기기
	   $(".pinfield").hide();
	   //id중복체크
	   //$("#btnCheck").click(function(){
		  function checkId(){
		   //id읽기
		   var id=$("#id").val().trim();
		   //alert(id);
		   $.ajax({
			   
			   type:"get",
			   url:"member/idcheck.jsp",
			   dataType:"json",
			   data:{"id":id},
			   success:function(res){
				   if(res.count==1){
					   $(".idsuccess").text("이미 사용 중인 아이디입니다").css("color", "red").show();
					   //$("#id").val(" "); 
				   }else if (res.count==0 && id.length==0){
					   //$('#btnCheck').hide();
					    $(".idsuccess").text("아이디를 입력해주세요").css("color", "red").show();
				   }else{
					   $(".idsuccess").text("사용 가능한 아이디입니다").css("color", "green").show();
				   }
			   }
		   });
	   };
  			$("input[name='id']").on("input",checkId);
	   //이메일선택 이벤트
	   $("#selemail").change(function(){
		   
		   if($(this).val()=='-')
			   $("#email2").val('');
		   else
			   $("#email2").val($(this).val());
		   
	   });
	   
	   //비밀번호 확인
	   function checkPass() {
		    const pass = $("input[name='pass']").val().trim();
		    const pass2 = $("input[name='pass2']").val().trim();
		    
		    if(pass == pass2 && pass !== "") {
		      $(".passsuccess").hide();
		    }else{
		    	$(".passsuccess").show();
			} 	
		  }
		
		  $("input[name='pass'], input[name='pass2']").on("input", checkPass);
   })
   
   function check(f){
	   if(f.pass.value!=f.pass2.value){
		   alert("비밀번호가 서로 다릅니다");
		   f.pass.value="";
		   f.pass2.value="";
		   return false;
	   }
   }
   
   //인증번호 전송 및 타이머
   	$(document).ready(function(){
   			var timerInterval;
		   	var remainingTime = 300;
		   	
		    function startTimer() {
			    clearInterval(timerInterval); // 이전 타이머 제거

			    timerInterval = setInterval(function() {
			        let minutes = Math.floor(remainingTime / 60);
			        let seconds = remainingTime % 60;
			        $("#timer").text(minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
			        
			        if (remainingTime <= 0) {
			            clearInterval(timerInterval);
			            $("#timer").text("인증시간 만료");
			            $("#pinCheck").hide();
			            // 인증번호 입력 비활성화나 재전송 유도 가능
			        }
			        remainingTime--;
			    }, 1000);
			}
		    
   		$("#hpCheck").click(function(){
   			
			var hp = $("input[name='hp']").val().trim();
			if(hp==""||hp.length<11){
				alert("휴대폰 번호를 올바르게 입력해주세요!!!")
				return
			}else{
   				
   				remainingTime = 300;
   				startTimer();
   				<%-- alert("인증번호를 발송하였습니다.");
			 	 $("#pinpass").val("<%= session.getAttribute("verificationCode")%>");
   				$("#hpCheck").css("backgroundColor","black"); 
   				$(".pinfield").show();  --%>
   				$.ajax({
   				    type: "POST",
   				    url: "/SemiProject/SendSmsServlet",
   				    data: { hp: hp },
   				    dataType: "json",  // JSON 타입으로 받음
   				    success: function(res) {
   				        if(res.error) {
   				            alert(res.error);  // 오류 메시지 있으면 출력
   				        } else {
   				            alert("인증번호를 발송하였습니다.");
   				            $("#pinpass").val(res.verificationCode);  // 서버가 보낸 인증번호 세팅
   				            $("#hpCheck").css("backgroundColor","black");
   				            $(".pinfield").show();
   				        }
   				    },
   				    error: function() {
   				        alert("인증번호 발송 중 오류가 발생했습니다.");
   				    }
   				});
			}
   		});
   		
   		$("#pinCheck").click(function(){
			if($("input[name='pin']").val().trim() == $("#pinpass").val().trim()){
				alert("인증되었습니다.");
				clearInterval(timerInterval);
				$("#timer").text("인증완료");
				console.log($("#timer").text());
				$("#pinCheck").css('backgroundColor','black');
				
			}else{
				alert("인증번호가 일치하지 않습니다.");
			}
   		});
   		
   	 $('#agree').on('change', function () {
	      if ($(this).is(':checked') && $("#timer").text()=="인증완료") {
	        $('#hewongaip').prop('disabled', false).css('backgroundColor','black');
	      } else {
	        $('#hewongaip').prop('disabled', true).css('backgroundColor','#d9d9d9');
	      }
	    });
   	});
   
   
</script>
</head>
<body>
<div class="gaip">
<form action="member/memberadd.jsp" method="post" onsubmit="return check(this)">
  <div class="gaiptable" style="width: 500px; margin: auto; margin-top: 50px; margin-bottom: 300px;">
     <div align="top" style=" text-align: center"><b>회원가입</b></div>
     <div>
       <label width="100" class="member-info">아이디</label>
       <div class="input-group">
         <input type="text" name="id" id="id" class="form-control"
         maxlength="10" required="required" style="width: 500px;">
       </div>
       <span class="idsuccess" style="color: red; font-size:0.8em;">아이디를 입력해주세요.</span>
     </div>
     <div>
        <label width="100" class="member-info">비밀번호</label>
        <div class="input-group">
          <input type="password" name="pass" class="form-control"
          required="required" style="max-width: 500px;" placeholder="비밀번호를 입력해주세요">
          </div>
          <div>
        <label width="100" class="member-info">비밀번호 확인</label>
          <input type="password" name="pass2" class="form-control"
          required="required" style="max-width: 500px;" placeholder="비밀번호를 입력해주세요">
          <span class="passsuccess" style="color:red; font-size: 0.8em; ">비밀번호가 일치하지 않습니다.</span>
        </div>
     </div>
     <div>
       <label width="100" class="member-info">이름</label>
       <div class="input-group">
         <input type="text" name="name" class="form-control"
          required="required" style="max-width: 500px;">
         </div>
     </div>
     <div>
       <label width="100" class="member-info">휴대폰 번호</label>
       <input type="hidden" value="" id ="pinpass">
       <div class="input-group">
         <input type="text" name="hp" class="form-control"required="required" style="max-width: 330px;" maxlength="11">&nbsp;&nbsp;&nbsp;
          <button type="button" id="hpCheck">인증번호 발송</button>
       </div>
     </div>
     <div class = "pinfield">
       <label width="100" class="member-info">인증 번호</label>
       <div class="input-group">
         <input type="text" name="pin" class="form-control"
          required="required" style="max-width: 330px;">&nbsp;&nbsp;&nbsp;
          <button type="button" id="pinCheck">확인</button>
          <span id="timer" style="margin-left:10px;margin-top:12px; color: red; font-weight: bold;"></span>
          </div>
     </div>
     <div>
       <label width="100" class="member-info">생년월일</label>
       <div class="input-group">
         <input type="text" name="birth-year" class="form-control" maxlength="4" placeholder="ex)2025"
          required="required" style="max-width: 110px;"placeholder="년도">
          <input type="text" name="birth-month" class="form-control" maxlength="2" placeholder="ex)01"
          required="required" style="max-width: 110px;"placeholder="월">
          <input type="text" name="birth-date	" class="form-control" maxlength="2" placeholder="ex)01"
          required="required" style="max-width: 110px;"placeholder="일">
          </div>
     </div>
     <div>
       <label width="100" class="member-info">이메일</label>
       <div class="input-group">
         <input type="text" name="email1"  class="form-control"
          required="required" style="max-width: 180px;">&nbsp;
          <b style="margin-top: 8px;">@</b>&nbsp;
          <input type="text" name="email2" id="email2"  class="form-control"
          required="required" style="max-width: 180px;">&nbsp;&nbsp;
          <select id="selemail" class="form-control" style="max-width: 120px;">
             <option value="-">직접입력</option>
             <option value="naver.com">네이버</option>
             <option value="gmail.com">구글</option>
             <option value="hanmail.net">다음</option>
          </select>
       </div>
     </div>
     <div>
     	<div>
     		<label style="font-size: 0.784em"><b>※생년월일/휴대폰번호 인증을 통해 14세 이상시 회원가입이 처리됩니다.</b><br></label>
			<label style="color: gray;font-size: 0.8em">* 회원가입에 필요한 최소한의 정보만 입력 받음으로써<br> 고객님의 개인정보 수집을 최소화하고 편리한 회원가입을 제공합니다.</label>
     	</div>
     </div>
     <hr>
     <div class="terms-wrapper">
        <h3>회원가입 이용약관</h3>
        <div class="terms-box">
            <strong>[공통 항목]</strong><br><br>
            
            <strong>[1. 목적]</strong><br>
            이 약관은 패션 쇼핑몰 "SSY.COM" (이하 "회사")가 운영하는 웹사이트에서 제공하는 서비스의 이용 조건 및 절차, 회원과 회사의 권리와 의무 등을 규정함을 목적으로 합니다.<br><br>

            <strong>[2. 회원가입]</strong><br>
            1) 회원가입은 본인의 성명과 유효한 이메일 주소 등 필수정보를 입력하고 본 약관에 동의함으로써 완료됩니다.<br>
            2) 만 14세 미만은 법정대리인의 동의 없이는 회원 가입이 불가합니다.<br><br>

            <strong>[3. 개인정보 수집 및 이용]</strong><br>
            1) 회사는 회원의 구매, 배송, 고객상담 등을 위해 필요한 최소한의 개인정보를 수집합니다.<br>
            2) 수집된 정보는 마케팅 목적(이벤트, 할인 정보 안내 등)으로 활용될 수 있으며, 이에 대한 동의는 선택사항입니다.<br><br>

            <strong>[4. 서비스 이용]</strong><br>
            1) 회원은 상품 주문, 장바구니 이용, 리뷰 작성 등의 서비스를 이용할 수 있습니다.<br>
            2) 회사는 재고 부족, 시스템 오류 등의 사유로 주문을 취소하거나 제한할 수 있으며 이 경우 회원에게 사전 또는 사후 고지합니다.<br><br>

            <strong>[5. 회원 탈퇴 및 자격 정지]</strong><br>
            1) 회원은 언제든지 마이페이지를 통해 회원 탈퇴할 수 있습니다.<br>
            2) 회사는 다음의 경우 회원 자격을 제한 또는 상실시킬 수 있습니다.<br>
            &nbsp;&nbsp;- 타인의 정보 도용<br>
            &nbsp;&nbsp;- 사이트 운영을 방해하는 행위<br>
            &nbsp;&nbsp;- 허위 리뷰 작성 또는 악성 댓글 작성<br><br>

            <strong>[6. 구매 및 배송]</strong><br>
            1) 회원은 결제 완료 후 회사의 배송 정책에 따라 상품을 수령하게 됩니다.<br>
            2) 회사는 천재지변, 물류 상황 등에 따라 배송이 지연될 수 있으며, 이 경우 즉시 회원에게 알립니다.<br><br>

            <strong>[7. 교환 및 환불]</strong><br>
            1) 제품 수령 후 7일 이내에 교환/반품 신청이 가능하며, 상품의 하자 또는 오배송 시 배송비는 회사가 부담합니다.<br>
            2) 단순 변심에 의한 교환/반품은 왕복 배송비를 회원이 부담해야 합니다.<br><br>

            <strong>[8. 기타 조항]</strong><br>
            본 약관에 명시되지 않은 사항은 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련 법령에 따릅니다.
        </div>
    </div>
    <hr>
    <div style="display: flex; align-items: center; height: 50px;">
	  <b style="margin-right: 10px;">해당 약관의 내용을 읽고 이해했으며 동의합니다.</b>
	  <input type="checkbox" id="agree" style="width: 1.5rem;">
	</div>
     <div>
          <button type="submit" id="hewongaip"style="width: 100%;height: 50px;"disabled>저장하기</button>
     </div>
  </div>
</form>
</div>
</body>
</html>