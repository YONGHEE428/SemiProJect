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
  html, body {
    height: 100%;
    margin: 0;
  }

  body {
    font-family: 'Nanum Myeongjo';
  }

  .wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }

  .menu {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100px;
    background-color: white;
    z-index: 999;
    text-align: center;
    font-size: 20pt;
    line-height: 80px;
  }

  .main {
    flex: 1;
    margin-top: 100px; /* 메뉴 높이만큼 띄움 */
    padding: 20px;
    font-size: 12pt;
  }

  .info {
    width: 100%;
    height: 300px;
    line-height: 30px;
    font-size: 13pt;
    padding: 20px;
    border: 5px solid purple;
    border-radius: 30px;
    background-color: white;
    margin-top: 50px;
  }

  a, a:hover {
    color: black;
    text-decoration: none;
  }
</style>

</head>
<%
   String mainPage = "layout/main.jsp"; 
   if(request.getParameter("main") != null) {
     mainPage = request.getParameter("main");
   }
%>
<body>
  <div class="wrapper">

    <div class="menu">
      <jsp:include page="layout/menu.jsp"/>
    </div>

    <div class="main">
      <jsp:include page="<%=mainPage %>"/>
    </div>

    <div class="info">
      <jsp:include page="layout/sideinfo.jsp"/>
    </div>

  </div>
</body>
</html>
