<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
  <label for="size"><strong>사이즈</strong></label>
  <select id="size" onchange="checkSoldOut(this)">
    <option value="">- [필수] Choose an Option -</option>
    <option value="S">S</option>
    <option value="M">M</option>
    <option value="L[품절]">L [품절]</option>
  </select>
</div>

<div class="mt-2">
  <label for="color"><strong>색상</strong></label>
  <select id="color" onchange="checkSoldOut(this)">
    <option value="">- [필수] Choose an Option -</option>
    <option value="Black">Black</option>
    <option value="White">White</option>
    <option value="Red[품절]">Red [품절]</option>
  </select>
</div>

<!-- 수량 선택 -->
<div class="mt-3">
  <label><strong>수량</strong></label>
  <div class="quantity-selector">
    <button id="minus" class="btn btn-secondary" onclick="changeQty(-1)" disabled>-</button>
    <span id="qty">1</span>
    <button id="plus" class="btn btn-secondary" onclick="changeQty(1)">+</button>
  </div>
</div>

<!-- 가격 표시 -->
<div class="mt-3">
  <strong>총 가격:</strong> <span id="Price">0원</span>
</div>

<!-- 구매 버튼 -->
<div class="mt-3">
  <button onclick="submitOptions()">구매하기</button>
</div>

<!-- 옵션 누락 모달 -->
<div id="optionModal" style="display: none;">
  <p>옵션을 모두 선택해주세요.</p>
  <button onclick="closeModal()">확인</button>
  
</div>
<script>
let quantity = 1;
const unitPrice = 30000; // 예시 단가
const maxQty = 5;

function changeQty(amount) {
  quantity = Math.min(maxQty, Math.max(1, quantity + amount));
  document.getElementById("qty").textContent = quantity;
  document.getElementById("minus").disabled = (quantity === 1);
  document.getElementById("plus").disabled = (quantity === maxQty);
  document.getElementById("Price").textContent = (unitPrice * quantity).toLocaleString() + "원";
}

function checkSoldOut(select) {
  const value = select.value;
  if (value.includes("[품절]")) {
    alert("품절된 상품은 구매가 불가능합니다.");
    select.value = ""; // 선택 취소
  }
}

function submitOptions() {
  const size = document.getElementById('size').value;
  const color = document.getElementById('color').value;
  if (!size || !color) {
    document.getElementById("optionModal").style.display = "block";
    return;
  }
  alert(`선택한 옵션:\n사이즈: ${size}\n색상: ${color}\n수량: ${quantity}`);
}

function closeModal() {
  document.getElementById("optionModal").style.display = "none";
}
</script>
</body>
</html>