<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="inquiryModal" class="modal-overlay" style="display:none;">
  <div class="modal-box">
    <span class="close-btn" onclick="closeInquiryModal()">×</span>
    <%@ include file="q&a.jsp" %>
  </div>
</div>

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