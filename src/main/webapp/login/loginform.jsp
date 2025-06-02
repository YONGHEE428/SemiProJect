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
</head>
<style>
	.login-main{
		margin: auto;
		width: 22%;
		height: 80%;
		margin-top: 30px; 
		
		font-weight: bold;
	}
	.login-title{
		text-align: center;
	}
	.login-span {
		font-size: 0.8em;
		font-weight: bolder;
	}
	.field {
    	margin-bottom: 20px;
    	}
    .login-btn{
    	width: 100%;
    	height: 50px;
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
</style>

<script type="text/javascript">
	$(function(){
	  function checkInput() {
	    const idVal = $("input[name='id']").val().trim();
	    const passVal = $("input[name='pass']").val().trim();
	    
	    if(idVal !== "" && passVal !== "") {
	      $(".login-btn").prop("disabled", false).css("background-color", "#000");
	    } else {
	      $(".login-btn").prop("disabled", true).css("background-color", "#d9d9d9");
	    }
	  }
	
	  $("input[name='id'], input[name='pass']").on("input", checkInput);
	  
	  // 초기 체크 (만약 값이 세션에서 자동으로 들어왔을 경우 대비)
	  //checkInput();
	});


</script>
<%
  String saveok=(String)session.getAttribute("saveok");
  String myid="";
  if(saveok!=null){
	  myid=(String)session.getAttribute("myid");
  }
  
  String redirect = request.getParameter("redirect");
  if (redirect == null || redirect.trim().equals("")) {
      redirect = "../index.jsp";  //아무것도 안적혀있으면 기본페이지
  }
 %>
<body>
<div class="login-main">
	<div class="login-title">
   <p style="font-size: 1.5em">로그인</p>
   </div>

   <form action="login/loginaction.jsp" method="post">
    <span class="login-span"><p>아이디</p></span>
     <input type="text" name="id" class="form-control field" placeholder="" required="required" value="<%=myid%>" >
    <span class="login-span"><p>비밀번호</p></span>
     <input type="password" name="pass" class="form-control field" placeholder="" required="required">
         <input type="hidden" name="redirect" value="<%= redirect %>">
         								<!-- 히든으로 loginaction.jsp에 redirect 값에 전달 -->
     
	
     <button type="submit" class="login-btn" disabled>로그인</button><br>
     <div class="login-bottom">
     <input type="checkbox" name="savechk" <%=saveok==null?"":"checked" %>> 아이디저장
     </div>
   </form>
</div>
</body>
</html>