<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 깔끔한 고딕체 폰트 (Google Fonts - Noto Sans KR) -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- Bootstrap CSS & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>

<title>결제 완료 메시지</title>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background: #f2f4f7; /* 부드러운 연회색 배경 */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }
  #hero {
    background: white;
    padding: 30px 50px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    font-size: 26px;
    color: #333;
    display: flex;
    align-items: center;
    gap: 12px;
  }
  #hero i.bi-check-circle-fill {
    color: #28a745; /* Bootstrap 녹색 */
    font-size: 1.6em;
    vertical-align: middle;
  }
  #hero .ti-cursor {
    display: none !important; /* 커서 숨김 */
  }
</style>
</head>
<body>

  <div id="hero"></div>

  <script>
    new TypeIt("#hero", {
      speed: 50,
      startDelay: 500,
    })
    .type("결제가 완료되었습니다!", { delay: 100 })
    .pause(500)
    .type('<i class="bi bi-check-circle-fill"></i>', { instant: true })
    .go();
  </script>
  
</body>
</html>
