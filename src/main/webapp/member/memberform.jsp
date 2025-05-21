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
<script type="text/javascript">
   $(function(){
	   
	   //id중복체크
	   $("#btnCheck").click(function(){
		   
		   //id읽기
		   var id=$("#id").val();
		   //alert(id);
		   
		   $.ajax({
			   
			   type:"get",
			   url:"member/idcheck.jsp",
			   dataType:"json",
			   data:{"id":id},
			   success:function(res){
				   console.log(res.count);
				   if(res.count==1){
					   //alert("이미 가입된 아이디입니다 \n다시입력해주세요");
					   $("span.idsuccess").text("fail");
					   $("#id").val(" "); 
				   }else{
					   //alert("가입가능한 아이디입니다");
					   $("span.idsuccess").text("ok");
				   }
			   }
		   });
	   });
	   
	   //이메일선택 이벤트
	   $("#selemail").change(function(){
		   
		   if($(this).val()=='-')
			   $("#email2").val('');
		   else
			   $("#email2").val($(this).val());
		   
	   });
	   
   })
   
   function check(f){
	   
	   if(f.pass.value!=f.pass2.value){
		   alert("비밀번호가 서로 다릅니다");
		   f.pass.value="";
		   f.pass2.value="";
		   return false;
	   }
   }

</script>
</head>
<body>
<div style="margin: 100px 200px;">
<form action="member/memberadd.jsp" method="post" onsubmit="return check(this)">
  <table class="table table-bordered" style="width: 500px;">
     <caption align="top"><b>회원가입</b></caption>
     <tr>
       <th width="100" class="table-info">아이디</th>
       <td class="input-group">
         <input type="text" name="id" id="id" class="form-control"
         maxlength="8" required="required" style="max-width: 150px;">&nbsp;&nbsp;&nbsp;
         <button type="button" class="btn btn-danger"
         id="btnCheck">중복체크</button>&nbsp;&nbsp;&nbsp;
         <span class="idsuccess" style="color: green;"></span>
       </td>
     </tr>
     <tr>
        <th width="100" class="table-info">비밀번호</th>
        <td class="input-group">
          <input type="password" name="pass" class="form-control"
          required="required" style="max-width: 160px;" placeholder="비밀번호">&nbsp;&nbsp;
          <input type="password" name="pass2" class="form-control"
          required="required" style="max-width: 160px;" placeholder="비밀번호확인">
        </td>
     </tr>
     <tr>
       <th width="100" class="table-info">이름</th>
       <td class="input-group">
         <input type="text" name="name" class="form-control"
          required="required" style="max-width: 150px;">
     </tr>
     
     <tr>
       <th width="100" class="table-info">이메일</th>
       <td class="input-group">
         <input type="text" name="email1"  class="form-control"
          required="required" style="max-width: 80px;">&nbsp;&nbsp;
          <b>@</b>&nbsp;&nbsp;
          <input type="text" name="email2" id="email2"  class="form-control"
          required="required" style="max-width: 150px;">&nbsp;&nbsp;
          <select id="selemail" class="form-control">
             <option value="-">직접입력</option>
             <option value="naver.com">네이버</option>
             <option value="gmail.com">구글</option>
             <option value="hanmail.net">다음</option>
          </select>
       </td>
     </tr>
     <tr>
       <td align="center" colspan="2">
          <button type="submit" class="btn btn-outline-info"
          style="width: 100px;">저장하기</button>
          <button type="reset" class="btn btn-outline-info"
          style="width: 100px;">초기화</button>
       </td>
     </tr>
  </table>
</form>
</div>
</body>
</html>