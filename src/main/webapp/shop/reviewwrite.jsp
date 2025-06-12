<%@page import="data.dao.MemberDao"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<style>
.modal-overlay {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-box {
  width: 400px;
  max-height: 90vh;
  background: white;
  padding: 20px;
  border-radius: 10px;
  overflow-y: auto;
  position: relative;
}

.close-btn {
  position: absolute;
  top: 10px; right: 15px;
  font-size: 20px;
  cursor: pointer;
}

.submit-btn {
  background: black;
  color: white;
  padding: 10px;
  width: 100%;
  border: none;
  margin-top: 15px;
  cursor: pointer;
}
</style>



<%
String memberId = (String) session.getAttribute("");  
boolean isLoggedIn = memberId != null;

// 로그인 되었다면 이름 조회
String memberName = "";
if (isLoggedIn) {
    MemberDao mdao = new MemberDao();
    memberName = mdao.getName(memberId); 
}
%>

<!-- 리뷰 작성 모달 -->
<div id="reviewModal" class="modal-overlay" style="display: none;">
  <div class="modal-box">
    <span class="close-btn" onclick="closeReviewModal()">×</span>

    <form id="reviewForm" action="${pageContext.request.contextPath}/SubmitReviewServlet.do" method="post" enctype="multipart/form-data">
      <input type="hidden" name="member_name" value="<%= memberName %>">
       <input type="hidden" name="product_id" value="<%= request.getParameter("product_id") %>">

      <h5><%= memberName %> 고객님, 리뷰를 남겨주세요!</h5>
      <p>지금 리뷰를 남기면 적립금 최대 <strong>1,500원</strong>!</p>

      <label>구매 옵션</label><br>
      <input type="radio" name="purchase_option" value="S"> S
      <input type="radio" name="purchase_option" value="M"> M
      <input type="radio" name="purchase_option" value="L"> L
      <input type="radio" name="purchase_option" value="XL"> XL

      <br><label>리뷰 작성란</label><br>
      <textarea name="content" rows="4" placeholder="리뷰를 남겨주세요."></textarea>

      <br><label>만족도</label><br>
      <select name="satisfaction_text">
          <option value="아주 좋아요">아주 좋아요 ★★★★★</option>
          <option value="좋아요">좋아요 ★★★★</option>
          <option value="보통이에요">보통이에요 ★★★</option>
          <option value="그냥 그래요">그냥 그래요 ★★</option>
          <option value="별로예요">별로예요 ★</option>
      </select>

      <br><label>포토 첨부</label><br>
      <input type="file" name="photo" accept="image/*">

      <br><label>사이즈 어때요?</label><br>
      <input type="radio" name="size_fit" value="많이 작아요"> 많이 작아요
      <input type="radio" name="size_fit" value="조금 작아요"> 조금 작아요
      <input type="radio" name="size_fit" value="잘 맞아요"> 잘 맞아요
      <input type="radio" name="size_fit" value="조금 커요"> 조금 커요
      <input type="radio" name="size_fit" value="많이 커요"> 많이 커요

      <br><label>사이즈 한줄평</label><br>
      <input type="text" name="size_comment" />

      <br><label>키</label><br>
      <input type="text" name="height" />

      <br><label>몸무게</label><br>
      <input type="text" name="weight" />

      <br><label>평소 사이즈 – 상의</label><br>
      <input type="radio" name="usual_size" value="S"> S
      <input type="radio" name="usual_size" value="M"> M
      <input type="radio" name="usual_size" value="L"> L
      <input type="radio" name="usual_size" value="XL"> XL

      <br><br>
      <button type="button" class="submit-btn" onclick="handleReviewClick()">리뷰 작성하고 적립금 받기</button>
    </form>
  </div>
</div>
<script>
  const isLoggedIn = <%= isLoggedIn %>;

  function openReviewModal() {
    document.getElementById("reviewModal").style.display = "flex";
  }
  function closeReviewModal() {
    document.getElementById("reviewModal").style.display = "none";
  }

  function handleReviewClick() {
    if (!isLoggedIn) {
      // 로그인 안 됐으면 confirm 이후에 로그인 페이지로 이동
      if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
        window.location.href = '<%=request.getContextPath()%>/login.jsp';
      }
      return;   // 반드시 return 해 줘야 아래 submit 이 안 됩니다
    }
    // 로그인 돼 있으면 정상 제출
    document.getElementById("reviewForm").submit();
  }
</script>