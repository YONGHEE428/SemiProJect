<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<style>
	.mypage-main{
		padding: 0 25%;
		
	}
	.mypage-title{
		width: 100%;
		display:flex;
		margin-top: 20px;
		flex-wrap: wrap;
	}
	.mypage-content{
		margin-top:20px;
		width:100%;
		min-height: 500px;
	}
	.mypage-logo{
		width: 130px;
		height:130px;
		border-radius: 100px;
		background-color: black;
		font-size:4em;
		color: white;
		line-height: 130px;
		text-align: center;
	}
	.mypage-name{
		width: 200px;
		height: 30px;
		line-height: 30px;
		font-weight: bold;
		font-size: 2em;
		margin: 30px;
	}
	.mypage-info{
		margin-top:20px;
		margin-left:300px;
		display: flex;
    	flex-direction: column;
    	gap: 10px;
	}
	.MylogOut, .updateMe{
		width: 200px;
		height: 35px;
		background-color: white;
		border-radius: 5px;
		font-weight: bold;
	}
	.MylogOut:hover, .updateMe:hover{
		background-color: black;
		color: white;
	}
	.content-title{
		font-size:1em;
		font-weight: bold;
		padding: 0 150px;
	}
	.content-title>ul{
		display: flex;
		gap:170px;
	}
	.content-title>ul>a{
		text-decoration: none;
		color: gray;
	}
	.content-title>ul>a:hover{
		color:black;
		border-bottom: 3px solid black;
	}
</style>
<%
  MemberDao dao=new MemberDao();
  SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월 dd일");
  
  String loginok=(String)session.getAttribute("loginok");
  String myid=(String)session.getAttribute("myid");
  String num = (String)session.getAttribute("num");
  String name = (String)session.getAttribute("name");
  MemberDto dto = dao.getData(num);
  String email = dto.getEmail();
%>
<script type="text/javascript">

	function logout(){
		alert("로그아웃 하셨습니다.");
		location.href = "login/logoutform.jsp";
		}
	
		function UpdateMyinfo() {
		    let mypass = prompt("비밀번호를 입력해주세요");

		    if (mypass && mypass.trim() !== "") {
		        document.getElementById("hiddenPass").value = mypass;
		        document.getElementById("passForm").submit();
		    } else {
		        alert("비밀번호가 올바르지 않습니다.");
		    }
		}
			
</script>
<body>
  <div class="mypage-main">
  	<div class="mypage-title">
	  	<form id="passForm" action="member/checkpass.jsp" method="post">
	    	<input type="hidden" name="pass" id="hiddenPass">
	    	<input type="hidden" name="num" id="hiddenPass" value="<%=num%>">
		</form>
        <%
        	  if(loginok!=null){%>
				<div class="mypage-logo">SSY</div>
				<div class="mypage-name"><%=name%> 님<br>
				<span style="font-size: 0.5em; color: gray"><%=email%></span>
				</div>
        	  	<div class="mypage-info">
        	  		<button type="button" class="updateMe" onclick="UpdateMyinfo()">정보수정</button>
        	  		<button type="button" class="MylogOut" onclick="logout()">로그아웃</button>
        	  	</div>
         <% }%>
       
        </div>
     <div class="mypage-content">
        <nav class="content-title">
        		<ul>
        			<a href="index.jsp?main=category/catewish.jsp" class="Mywish">위시리스트</a>
        			<a href="index.jsp?main=cart/cartform.jsp" class="MyCart">장바구니</a>
        			<a href="#" class="MybuyList">구매내역</a>
        		</ul>
       </nav>
    </div>
  </div>
  
  
  <!-- Modal
<div class="modal fade" id="myDelModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">삭제확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input type="hidden" id="delnum">
        <b>삭제비밀번호:  </b>
        <input type="password" class="form-control" style="width: 120px;" id="delpass">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary btndel">Save changes</button>
      </div>
    </div>
  </div>
</div> -->
</body>
</html>