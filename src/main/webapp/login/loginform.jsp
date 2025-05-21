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
<body>
<div style="margin: 100px 300px; width: 200px;">
   <h2 class="alert alert-success">회원로그인</h2>
   <form action="login/loginaction.jsp" method="post">
     <input type="text" name="id" class="form-control"
     style="width: 200px;" placeholder="로그인할 아이디"
     required="required" ><br>
     <input type="password" name="pass" class="form-control"
     style="width: 200px;" placeholder="로그인할 비밀번호"
     required="required">
     <br>
     <button type="submit" class="btn btn-success btn-lg"
     style="width: 200px;">로그인</button><br>
     
     <input type="checkbox" name="savechk"> 아이디저장
    
   </form>
</div>
</body>
</html>