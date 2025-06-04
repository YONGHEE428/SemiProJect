<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
  background: #f2f4f7;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
}

#hero {
  width: 500px;
  background: white;
  padding: 30px 50px;
  border-radius: 5px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  font-size: 26px;
  color: #333;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
  text-align: center;
}

#typing-text i.bi-check-circle-fill {
  color: #28a745;
  font-size: 1.6em;
  vertical-align: middle;
}

#typing-text .ti-cursor {
  display: none !important;
}

#buttons {
  display: flex;
  gap: 12px;
}
</style>
</head>
<body>

  <div id="hero">
  <div><span id="typing-text"></span></div>
  <div id="buttons">
  	<button type="button" class="btn btn-danger" onclick="location.href='index.jsp'">메인으로</button>
  	<button type="button" class="btn btn-secondary" onclick="">마이페이지</button>
  </div>
</div>
  
  <script>
  new TypeIt("#typing-text", {
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
