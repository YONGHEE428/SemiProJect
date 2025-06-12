<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- inquiryModal.jsp -->
<div id="inquiryModal" class="modal-overlay" style="display:none;">
  <div class="modal-box">
    <span class="close-btn" onclick="closeInquiryModal()">×</span>
  
</div>
<form action="${pageContext.request.contextPath}/InsertInquiryServlet" method="post">
  <!-- ★★ 여기가 빠져 있으면 servlet 에서 product_id가 null 됩니다 ★★ -->
  <input type="hidden" name="product_id" value="${param.product_id}" />

  <label>제목:</label>
  <input type="text" name="title" required /><br/>

  <label>내용:</label>
  <textarea name="content" required></textarea><br/>

  <label>공개여부:</label>
  <input type="radio" name="is_private" value="false" checked />공개
  <input type="radio" name="is_private" value="true" />비공개<br/>

  <label>비밀번호(비밀글인 경우):</label>
  <input type="password" name="password" /><br/>

  <button type="submit">문의 등록</button>
</form>
<style>
.modal-overlay {
  position: fixed; top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.5);
  display: flex; align-items: center; justify-content: center;
  z-index: 1000;
}
.modal-box {
  background: #fff; padding: 20px;
  border-radius: 8px; max-width: 500px;
  width: 90%; max-height: 90vh; overflow-y: auto;
  position: relative;
}
.close-btn {
  position: absolute; top: 10px; right: 15px;
  font-size: 20px; cursor: pointer;
}
</style>

<script>
function openInquiryModal() {
  document.getElementById('inquiryModal').style.display = 'flex';
}
function closeInquiryModal() {
  document.getElementById('inquiryModal').style.display = 'none';
}
</script>