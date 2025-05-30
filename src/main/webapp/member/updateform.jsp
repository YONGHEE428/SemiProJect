<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.MemberDto"%>
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
  .UpdateMydata {
    padding: 50px 400px;
  }

  .updatetable {
    margin: auto;
  }
  .updatetable tr{
  	margin-bottom: 20px;
  }
  .updatetable th,
  .updatetable td {
    padding: 12px 15px;
    vertical-align: middle;
    text-align: left;
  }

  .updatetable th {
    width: 150px;
    font-weight: bold;
    white-space: nowrap;
  }

  .form-control {
    max-width: 180px;
  }
  #updatebtn{
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
   #updatebtn:hover{
   		background-color: black;
   		color:white;
   }
</style>
<script type="text/javascript">
	//이메일선택 이벤트
$(function(){

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
			
			  if (pass === pass2 && pass !== "") {
			    $(".passsuccess").css("visibility", "hidden");
			    $('#updatebtn').prop('disabled', false)
			  } else {
			    $(".passsuccess").css("visibility", "visible");
			    $('#updatebtn').prop('disabled', true)
			  }
			}
		$("input[name='pass'], input[name='pass2']").on("input", checkPass);
		
	})
</script>
<body>
<%
	String num = request.getParameter("num");

	MemberDao dao = new MemberDao();
	MemberDto dto = dao.getData(num);
	String birth = dto.getBirth();
	String[] emailParts = dto.getEmail().split("@");
	String email1 = emailParts[0]; // 왼쪽: aaa
	String email2 = emailParts[1]; // 오른쪽: naver.com


%>
<div class="UpdateMydata">
	<form action="member/memberupdate.jsp" method="post">
		<table class="updatetable">
			<tr>
				<th>이름</th>
				<td><b><%=dto.getName()%></b></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td style="display: flex;">
					<input type="hidden" name="num" value="<%=num%>">
					<input type="text" name="email1"  class="form-control"
		          	required="required" style="max-width: 180px;" value ="<%=email1%>">&nbsp;
		          	<b style="margin-top: 8px;">@</b>&nbsp;
		          	<input type="text" name="email2" id="email2"  class="form-control"
		          	required="required" style="max-width: 180px;" value ="<%=email2%>">&nbsp;&nbsp;
		          	<select id="selemail" class="form-control" style="max-width: 120px;">
			             <option value="-">직접입력</option>
			             <option value="naver.com">네이버</option>
			             <option value="gmail.com">구글</option>
			             <option value="hanmail.net">다음</option>
		          </select>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td style="display: flex">
					  <input type="text" name="birth-year" class="form-control" maxlength="4" placeholder="ex)2025"
			          required="required" style="max-width: 110px;" value="<%=birth.substring(0,4)%>">
			          <input type="text" name="birth-month" class="form-control" maxlength="2" placeholder="ex)01"
			          required="required" style="max-width: 110px;" value="<%=birth.substring(5,7)%>">
			          <input type="text" name="birth-date" class="form-control" maxlength="2" placeholder="ex)01"
			          required="required" style="max-width: 110px;" value="<%=birth.substring(8,10)%>">
				</td>
			</tr>
			<tr>
				<th>새로운 비밀번호</th>
				<td>
					<input type="text" name="pass" class="form-control"required="required" style="max-width: 500px;" value="<%=dto.getPass()%>">
				</td>	
			</tr>
			<tr>
				<th style="transform: translateY(-12px);">비밀번호 확인</th>
				<td>
					<input type="text" name="pass2" class="form-control"required="required" style="max-width: 500px;" placeholder="비밀번호를 입력해주세요">
					<span class="passsuccess" style="color:red; font-size: 0.8em; visibility: visible;">비밀번호가 일치하지 않습니다.</span>
				</td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit" id="updatebtn"style="width: 100%;height: 50px; disabled">수정하기</button></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>