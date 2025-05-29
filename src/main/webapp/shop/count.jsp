<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 👇 상품 클릭 시 조회수 증가 요청 -->
<a href="sangpumpage.jsp?productId=123" onclick="increaseViewCount(123)">
  <img src="..." alt="상품 이미지">
</a>

<!-- 👁️ 이모티콘 + 조회수 (이건 productDetail.jsp에서 렌더링할 부분) -->
<div style="font-size: 18px; margin-top: 10px;">
  👁️ <span id="view-count"></span>명
</div>

<script>
function increaseViewCount(productId) {
  fetch(`/increaseViewCount.jsp?productId=${productId}`, {
    method: 'GET'
  })
  .then(response => response.text())
  .then(data => {
    // 응답 값이 숫자면 화면에 보여주기
    document.getElementById('view-count').textContent = data;
  })
  .catch(err => console.error("View count update failed", err));
}
</script>

</body>
</html>