<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- inquiryModal.jsp -->
<style>
.modal-overlay {
  display: none; /* JS로 토글 */
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.5);
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-box {
  background: #fff;
  max-width: 480px;
  width: 90%; /* 명확한 퍼센트 너비 지정 */
  max-height: 90vh;
  overflow-y: auto;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  position: relative;
  box-sizing: border-box; /* padding 포함 너비 산정 */
}

/* form-group input/textarea에 box-sizing 추가 */
.form-group input[type="text"],
.form-group input[type="password"],
.form-group textarea {
  width: 100%;            /* 부모(.form-group) 너비 가득 채우기 */
  box-sizing: border-box; /* padding 포함해서 100% */
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 1rem;
}

/* 라디오랑 버튼 영역도 가운데 정렬 */
.radio-group {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
}

/* submit 버튼 너비도 100% 유지 */
.submit-btn {
  width: 100%;
}
</style>
<div id="inquiryModal" class="modal-overlay">
  <div class="modal-box">
    <button type="button" class="close-btn" onclick="closeInquiryModal()">×</button>
    <h2 class="modal-title">문의 작성</h2>
    <form action="${pageContext.request.contextPath}/InsertInquiryServlet" method="post">
      <input type="hidden" name="product_id" value="${param.product_id}"/>

      <div class="form-group">
        <label for="title">제목</label>
        <input id="title" type="text" name="title" required/>
      </div>

      <div class="form-group">
        <label for="content">내용</label>
        <textarea id="content" name="content" rows="4" required></textarea>
      </div>

      <div class="form-group radio-group">
        <span>공개여부</span>
        <label><input type="radio" name="is_private" value="false" checked/> 공개</label>
        <label><input type="radio" name="is_private" value="true"/> 비공개</label>
      </div>

      <div class="form-group">
        <label for="password">비밀번호 <small>(비밀글인 경우)</small></label>
        <input id="password" type="password" name="password"/>
      </div>

      <div class="form-group">
        <button type="submit" class="submit-btn">문의 등록</button>
      </div>
    </form>
  </div>
</div>
