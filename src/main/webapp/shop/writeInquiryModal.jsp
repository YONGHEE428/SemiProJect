<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- inquiryModal.jsp -->
<div id="inquiryModal" class="modal-overlay" style="display:none;">
  <div class="modal-box">
    <span class="close-btn" onclick="closeInquiryModal()">×</span>

<form action="${pageContext.request.contextPath}/InsertInquiryServlet" method="post">
  <!-- ★★ 여기가 빠져 있으면 servlet 에서 product_id가 null 됩니다 ★★ -->
  <input type="hidden" name="product_id" value="${param.product_id}" />

  <label>제목:</label>
  <input type="text" name="title" required /><br/>

  <label>내용:</label>
  <textarea name="content" required></textarea><br/>

  <label>공개여부:</label>
  <input type="radio" name="is_private" value="false" checked onchange="togglePasswordField(false)" />공개
  <input type="radio" name="is_private" value="true" onchange="togglePasswordField(true)" />비공개<br/>

  <label>비밀번호(비밀글인 경우):</label>
  <input type="password" name="password" id="passwordField" disabled /><br/>

  <button type="submit">문의 등록</button>
   </div>
</form>
<style>
.modal-overlay {
  position: fixed; top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.6);
  display: flex; align-items: center; justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(8px);
}

.modal-box {
  background: #fff; padding: 2rem;
  border-radius: 16px; max-width: 500px;
  width: 90%; max-height: 90vh; overflow-y: auto;
  position: relative;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.close-btn {
  position: absolute; top: 1rem; right: 1rem;
  font-size: 1.5rem; cursor: pointer;
  width: 32px; height: 32px;
  display: flex; align-items: center; justify-content: center;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.close-btn:hover {
  background-color: #f5f5f5;
}

/* 폼 스타일 */
form {
  padding: 1rem;
}

label {
  display: block;
  margin: 1rem 0 0.5rem;
  font-weight: 600;
  color: #333;
}

input[type="text"],
input[type="password"],
textarea {
  width: 100%;
  padding: 0.8rem;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  font-size: 0.95rem;
  transition: all 0.2s ease;
  background-color: #f8f9fa;
  margin-bottom: 0.5rem;
}

input[type="text"]:focus,
input[type="password"]:focus,
textarea:focus {
  outline: none;
  border-color: #4a90e2;
  box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
  background-color: #fff;
}

input[type="password"]:disabled {
  background-color: #f0f0f0;
  cursor: not-allowed;
  opacity: 0.7;
}

textarea {
  min-height: 120px;
  resize: vertical;
}

input[type="radio"] {
  width: 16px;
  height: 16px;
  margin: 0 0.5rem 0 0;
  accent-color: #4a90e2;
}

button[type="submit"] {
  width: 100%;
  padding: 0.8rem;
  background-color: #333;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  margin-top: 1rem;
}

button[type="submit"]:hover {
  background-color: #222;
  transform: translateY(-1px);
}

button[type="submit"]:active {
  transform: translateY(0);
}

/* 스크롤바 스타일링 */
.modal-box::-webkit-scrollbar {
  width: 8px;
}

.modal-box::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.modal-box::-webkit-scrollbar-thumb {
  background: #ddd;
  border-radius: 4px;
}

.modal-box::-webkit-scrollbar-thumb:hover {
  background: #ccc;
}
</style>

<script>
function openInquiryModal() {
  document.getElementById('inquiryModal').style.display = 'flex';
  document.body.style.overflow = 'hidden';
}

function closeInquiryModal() {
  document.getElementById('inquiryModal').style.display = 'none';
  document.body.style.overflow = 'auto';
}

// 비밀번호 필드 활성화/비활성화 함수
function togglePasswordField(isPrivate) {
  const passwordField = document.getElementById('passwordField');
  passwordField.disabled = !isPrivate;
  if (!isPrivate) {
    passwordField.value = ''; // 공개로 변경시 비밀번호 초기화
  }
}

// ESC 키로 모달 닫기
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    closeInquiryModal();
  }
});

// 모달 외부 클릭시 닫기
document.getElementById('inquiryModal').addEventListener('click', function(e) {
  if (e.target === this) {
    closeInquiryModal();
  }
});
</script>