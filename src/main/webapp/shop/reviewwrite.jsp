<%@page import="data.dao.MemberDao"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dto.ProductOptionDto"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<style>
.modal-overlay {
  position: fixed;
  top: 50px; left: 0;
  width: 100%; height: 100%;
  background: rgba(0, 0, 0, 0.5);
  z-index: 10000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-box {
  width: 650px;
  height: 700px;
  background: white;
  padding: 30px;
  border-radius: 15px;
  overflow-y: auto;
  position: relative;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.close-btn {
  position: absolute;
  top: 20px; right: 25px;
  font-size: 24px;
  cursor: pointer;
  color: #666;
  transition: color 0.3s;
}

.close-btn:hover {
  color: #000;
}

.review-title {
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #f0f0f0;
}

.section-divider {
  margin: 25px 0;
  border-bottom: 2px solid #f0f0f0;
}

.review-title h5 {
  font-size: 1.5em;
  margin: 0 0 10px 0;
  color: #333;
  font-weight: 700;
}

.review-title p {
  color: #666;
  margin: 0;
}

.review-title strong {
  color: #ff4757;
}

.form-group {
  margin-bottom: 20px;
  position: relative;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
}

.error-message {
  display: none;
  color: #dc3545;
  font-size: 0.85em;
  margin-top: 5px;
  position: absolute;
  left: 0;
  bottom: -20px;
}

.form-group.error .error-message {
  display: block;
}

.form-group.error input{
  border-color: #dc3545;
}

.radio-group {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
}

.radio-group input[type="radio"] {
  margin-right: 5px;
}

textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  resize: vertical;
  min-height: 100px;
}

select {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
  background-color: white;
}

input[type="text"] {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
}

input[type="file"] {
  width: 100%;
  padding: 8px;
  background-color: #f8f9fa;
  border: 1px dashed #ddd;
  border-radius: 5px;
}

.submit-btn {
  background: #000;
  color: white;
  padding: 12px;
  width: 100%;
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.3s;
}

.submit-btn:hover {
  background: #333;
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
  background: #888;
  border-radius: 4px;
}

.modal-box::-webkit-scrollbar-thumb:hover {
  background: #555;
}

.photo-upload {
  width: 100%;
  border: 2px dashed #ddd;
  border-radius: 8px;
  padding: 15px;
  text-align: center;
  background: #f8f9fa;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  min-height: 120px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.photo-upload:hover {
  border-color: #666;
  background: #f1f3f5;
}

.photo-upload .upload-icon {
  font-size: 28px;
  color: #666;
  margin-bottom: 8px;
}

.photo-upload .upload-text {
  color: #666;
  font-size: 0.9em;
  margin: 0;
}

.preview-container {
  display: none;
  position: relative;
  width: 100%;
  margin: 5px 0;
}

.preview-image {
  max-width: 100%;
  max-height: 300px;
  object-fit: contain;
  border-radius: 4px;
}

.remove-image {
  position: absolute;
  top: 5px;
  right: 10px;
  background: rgba(0, 0, 0, 0.5);
  color: white;
  width: 25px;
  height: 25px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 18px;
  transition: background 0.3s;
}

.remove-image:hover {
  background: rgba(0, 0, 0, 0.7);
}

.photo-upload input[type="file"] {
  display: none;
}

.review-main h5 {
  margin-bottom: 10px;
}

.product-info {
  display: flex;
  align-items: center;
  padding: 20px;
  background: #fff;
  border: 1px solid #eee;
  border-radius: 8px;
  margin: 5px 0 20px 0;
  min-height: 100px;
}

.product-image {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 20px;
}

.product-details {
  flex: 1;
}

.product-category {
  font-size: 0.9em;
  color: #666;
  margin-bottom: 5px;
}

.product-name {
  font-size: 1.1em;
  font-weight: 500;
  color: #333;
}

.star-rating-container {
  display: flex;
  align-items: center;
  gap: 15px;
}

.star-rating {
  display: flex;
  gap: 5px;
}

.star-rating input[type="radio"] {
  display: none;
}

.star-rating label {
  cursor: pointer;
  font-size: 24px;
  color: #ddd;
}

.star-rating input[type="radio"]:checked ~ label {
  color: #ffd700;
}

.rating-text {
  font-size: 0.95em;
  color: #333;
}

.option-group {
  margin-top: 10px;
}

.option-group label {
  display: inline-block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
}

.size-options, .color-options {
  margin-bottom: 15px;
}

.option-title {
  display: inline-block;
  width: 60px;
  font-weight: 500;
  color: #333;
  margin-right: 10px;
}

.radio-group {
  display: inline-flex;
  gap: 15px;
  align-items: center;
}

.radio-group label {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-weight: normal;
  margin: 0;
}

.radio-group input[type="radio"] {
  margin-right: 5px;
  width: 16px;
  height: 16px;
  cursor: pointer;
}

.radio-group input[type="radio"]:checked + span {
  color: #000;
  font-weight: 500;
}


/* 필수 입력 필드 라벨 스타일 제거 */
.required-label::after {
    content: none;
}

/* 키/몸무게 입력 스타일 */
.size-input-group {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.size-input-box {
  flex: 1;
  position: relative;
}

.size-input-box input {
  width: 100%;
  padding: 12px 35px 12px 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 15px;
  transition: all 0.3s;
}

.size-input-box input:focus {
  border-color: #333;
  outline: none;
}

.size-input-box .unit {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
  font-size: 14px;
}

/* 평소 사이즈 선택 스타일 */
.usual-size-group {
  margin-bottom: 30px;
}

.size-select-box {
  margin-bottom: 15px;
}

.size-select-box select {
  width: 100%;
  padding: 12px 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 15px;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 15px center;
  background-size: 16px;
  cursor: pointer;
}

.size-select-box select:focus {
  border-color: #333;
  outline: none;
}

.size-select-box label {
  display: block;
  margin-bottom: 8px;
  color: #333;
  font-weight: bold;
}
</style>

<%
String memberId = (String) session.getAttribute("myid");  
boolean isLoggedIn = memberId != null;

// 로그인 되었다면 이름 조회
String memberName = "";
if (isLoggedIn) {
    MemberDao mdao = new MemberDao();
    memberName = mdao.getName(memberId); 
}

// 상품 정보 가져오기
ProductDto productDto = null;
List<ProductOptionDto> options = new ArrayList<>();
try {
    String productNumStr = request.getParameter("product_id");
    if(productNumStr != null && !productNumStr.trim().isEmpty()) {
        int productNum = Integer.parseInt(productNumStr);
        if(productNum > 0) {
            ProductDao productDao = new ProductDao();
            productDto = productDao.getProductById(productNum);
            options = productDao.getProductOptionsByProductId(productNum);
        }
    }
} catch(Exception e) {
    e.printStackTrace();
}

// 사이즈와 색상 옵션 추출
Set<String> sizeSet = new LinkedHashSet<>();
Set<String> colorSet = new LinkedHashSet<>();
for (ProductOptionDto opt : options) {
    sizeSet.add(opt.getSize());
    colorSet.add(opt.getColor());
}
%>

<!-- 리뷰 작성 모달 -->
<div id="reviewModal" class="modal-overlay" style="display: none;">
  <div class="modal-box">
    <span class="close-btn" onclick="closeReviewModal()">×</span>

    <form id="reviewForm" action="${pageContext.request.contextPath}/SubmitReviewServlet.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
      <input type="hidden" name="member_name" value="<%= memberName %>">
      <input type="hidden" name="product_id" value="<%= request.getParameter("product_id") %>">

      <div class="review-title">
        <h5><%= memberName %> 고객님, 리뷰를 남겨주세요!</h5>
        <p>지금 리뷰를 남기면 적립금 최대 <strong>1,500원</strong>!</p>
      </div>
      
      <div class="review-main">
        <h5><b>이 상품은 어떠셨나요?</b></h5><br>
      </div>
      
      <div class="product-info">
        <% if(productDto != null && productDto.getMainImageUrl() != null) { %>
            <img src="<%=productDto.getMainImageUrl()%>" 
                 class="product-image" alt="상품 이미지"
                 onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg'">
        <% } else { %>
            <img src="${pageContext.request.contextPath}/images/default-product.jpg" 
                 class="product-image" alt="상품 이미지 없음">
        <% } %>
        <div class="product-details">
            <div class="product-category">
                <%= productDto != null ? productDto.getCategory() : "카테고리 없음" %>
            </div>
            <div class="product-name">
                <%= productDto != null ? productDto.getProductName() : "상품명 없음" %>
            </div>
        </div>
      </div>

      <div class="form-group">
        <label>만족도</label>
        <div class="star-rating-container">
          <div class="star-rating">
            <input type="radio" name="satisfaction_text" value="별로예요" id="rate1" required>
            <label for="rate1">★</label>
            <input type="radio" name="satisfaction_text" value="그저 그래요" id="rate2">
            <label for="rate2">★</label>
            <input type="radio" name="satisfaction_text" value="괜찮아요" id="rate3">
            <label for="rate3">★</label>
            <input type="radio" name="satisfaction_text" value="좋아요" id="rate4">
            <label for="rate4">★</label>
            <input type="radio" name="satisfaction_text" value="최고예요" id="rate5">
            <label for="rate5">★</label>
          </div>
          <div class="rating-text" id="rating-text"></div>
        </div>
      </div>
       
      <div class="section-divider"></div>
       
      <div class="review-main">
        <h5><b>어떤 점이 좋았나요?</b></h5><br>
      </div>
	   
      <div class="form-group">
        <label>본문 입력</label>
        <textarea name="content" placeholder="상품에 대한 솔직한 리뷰를 남겨주세요. (최소 5자 이상)" required minlength="5"></textarea>
      </div>
      
      <div class="form-group">
        <label>사진 첨부</label>
        <div class="photo-upload" onclick="document.getElementById('photo-input').click()">
          <div class="upload-icon">+</div>
          <p class="upload-text">
            이미지 파일을 끌어다 놓거나 클릭해서 업로드하세요
          </p>
          <input type="file" id="photo-input" name="photo" accept="image/*" onchange="handlePhotoChange(this)">
          <div class="preview-container" id="preview-container">
            <img class="preview-image" id="preview-image" src="" alt="미리보기">
            <div class="remove-image" onclick="removeImage(event)">×</div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label>구매 옵션</label>
        <div class="option-group">
          <div class="size-options">
            <span class="option-title">사이즈:</span>
            <div class="radio-group">
              <% for(String size : sizeSet) { %>
                <label>
                  <input type="radio" name="purchase_option_size" value="<%=size%>" required>
                  <span><%=size%></span>
                </label>
              <% } %>
            </div>
          </div>
          <div class="color-options">
            <span class="option-title">색상:</span>
            <div class="radio-group">
              <% for(String color : colorSet) { %>
                <label>
                  <input type="radio" name="purchase_option_color" value="<%=color%>" required>
                  <span><%=color%></span>
                </label>
              <% } %>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label>사이즈 어때요?</label>
        <div class="radio-group">
          <label><input type="radio" name="size_fit" value="많이 작아요" required> 많이 작아요</label>
          <label><input type="radio" name="size_fit" value="조금 작아요"> 조금 작아요</label>
          <label><input type="radio" name="size_fit" value="잘 맞아요"> 잘 맞아요</label>
          <label><input type="radio" name="size_fit" value="조금 커요"> 조금 커요</label>
          <label><input type="radio" name="size_fit" value="많이 커요"> 많이 커요</label>
        </div>
      </div>

      <div class="form-group">
        <label>사이즈 한줄평</label>
        <input type="text" name="size_comment" placeholder="사이즈에 대한 의견을 한 줄로 남겨주세요">
      </div>

      <div class="section-divider"></div>

      <div class="review-main">
        <h5><b>나의 정보를 입력해주세요!</b></h5><br>
      </div>

      <div class="size-input-group">
        <div class="size-input-box">
          <label>키</label>
          <input type="number" name="height" placeholder="키를 입력해주세요" required min="100" max="250">
          <span class="unit">cm</span>
        </div>

        <div class="size-input-box">
          <label>몸무게</label>
          <input type="number" name="weight" placeholder="몸무게를 입력해주세요" required min="30" max="200">
          <span class="unit">kg</span>
        </div>
      </div>

      <div class="usual-size-group">
        <div class="size-select-box">
          <label>평소 사이즈 - 상의</label>
          <select name="usual_size_top" required>
            <option value="">상의 사이즈를 선택해주세요</option>
            <option value="XS">XS</option>
            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
            <option value="XXL">XXL</option>
          </select>
        </div>

        <div class="size-select-box">
          <label>평소 사이즈 - 하의</label>
          <select name="usual_size_bottom" required>
            <option value="">하의 사이즈를 선택해주세요</option>
            <option value="XS">XS</option>
            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
            <option value="XXL">XXL</option>
          </select>
        </div>
      </div>

      <button type="submit" class="submit-btn">리뷰 작성하고 적립금 받기</button>
    </form>
    
  </div>
</div>
<script>
  const isLoggedIn = <%= isLoggedIn %>;
  const modal = document.getElementById("reviewModal");

  function openReviewModal() {
    if (!isLoggedIn) {
      if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
        window.location.href = '<%=request.getContextPath()%>/login.jsp';
      }
      return;
    }
    modal.style.display = "flex";
  }
  
  function closeReviewModal() {
    modal.style.display = "none";
  }

  // 모달 바깥 영역 클릭 시 닫기
  window.onclick = function(event) {
    if (event.target == modal) {
      closeReviewModal();
    }
  }

  function handlePhotoChange(input) {
    const uploadText = input.parentElement.querySelector('.upload-text');
    const uploadIcon = input.parentElement.querySelector('.upload-icon');
    const previewContainer = document.getElementById('preview-container');
    const previewImage = document.getElementById('preview-image');
    const photoUpload = input.parentElement;

    if (input.files && input.files[0]) {
      const reader = new FileReader();
      
      reader.onload = function(e) {
        previewImage.src = e.target.result;
        uploadText.style.display = 'none';
        uploadIcon.style.display = 'none';
        previewContainer.style.display = 'block';
        photoUpload.style.background = '#ffffff';
      }
      
      reader.readAsDataURL(input.files[0]);
    }
  }

  function removeImage(e) {
    e.stopPropagation();
    const input = document.getElementById('photo-input');
    const uploadText = input.parentElement.querySelector('.upload-text');
    const uploadIcon = input.parentElement.querySelector('.upload-icon');
    const previewContainer = document.getElementById('preview-container');
    const photoUpload = input.parentElement;
    
    input.value = '';
    uploadText.style.display = 'block';
    uploadIcon.style.display = 'block';
    previewContainer.style.display = 'none';
    photoUpload.style.background = '#f8f9fa';
  }

  // 별점 텍스트 표시
  document.querySelectorAll('.star-rating input[type="radio"]').forEach(radio => {
    radio.addEventListener('change', function() {
      const ratingText = document.getElementById('rating-text');
      ratingText.textContent = this.value;
      
      // 클릭한 별과 그 이전 별들만 색상 변경
      const labels = document.querySelectorAll('.star-rating label');
      labels.forEach(label => label.style.color = '#ddd');
      
      const clickedIndex = Array.from(radio.parentElement.children)
        .indexOf(radio) / 2;
      
      for(let i = 0; i <= clickedIndex; i++) {
        labels[i].style.color = '#ffd700';
      }
    });
  });

  // 구매 옵션 선택 시 hidden input 업데이트
  document.querySelectorAll('input[name="purchase_option_size"], input[name="purchase_option_color"]').forEach(input => {
    input.addEventListener('change', function() {
        const selectedSize = document.querySelector('input[name="purchase_option_size"]:checked')?.value || '';
        const selectedColor = document.querySelector('input[name="purchase_option_color"]:checked')?.value || '';
        
        if(selectedSize && selectedColor) {
            const purchaseOption = `${selectedSize} / ${selectedColor}`;
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'purchase_option';
            hiddenInput.value = purchaseOption;
            
            // 기존 hidden input이 있다면 제거
            const existingInput = document.querySelector('input[name="purchase_option"]');
            if(existingInput) existingInput.remove();
            
            document.getElementById('reviewForm').appendChild(hiddenInput);
        }
    });
  });

  function validateForm() {
    let isValid = true;
    const form = document.getElementById('reviewForm');
    
    // 만족도 체크
    const satisfaction = form.querySelector('input[name="satisfaction_text"]:checked');
    const satisfactionGroup = form.querySelector('.star-rating').closest('.form-group');
    if (!satisfaction) {
      showError(satisfactionGroup, '만족도를 선택해주세요.');
      isValid = false;
    } else {
      hideError(satisfactionGroup);
    }

    // 본문 체크
    const content = form.querySelector('textarea[name="content"]');
    const contentGroup = content.closest('.form-group');
    if (!content.value.trim()) {
      showError(contentGroup, '리뷰 내용을 입력해주세요.');
      isValid = false;
    } else if (content.value.trim().length < 10) {
      showError(contentGroup, '리뷰 내용을 10자 이상 입력해주세요.');
      isValid = false;
    } else {
      hideError(contentGroup);
    }

    // 구매 옵션 체크
    const sizeOption = form.querySelector('input[name="purchase_option_size"]:checked');
    const colorOption = form.querySelector('input[name="purchase_option_color"]:checked');
    const optionGroup = form.querySelector('.option-group').closest('.form-group');
    if (!sizeOption || !colorOption) {
      showError(optionGroup, '사이즈와 색상을 모두 선택해주세요.');
      isValid = false;
    } else {
      hideError(optionGroup);
    }

    // 사이즈 평가 체크
    const sizeFit = form.querySelector('input[name="size_fit"]:checked');
    const sizeFitGroup = form.querySelector('input[name="size_fit"]').closest('.form-group');
    if (!sizeFit) {
      showError(sizeFitGroup, '사이즈 평가를 선택해주세요.');
      isValid = false;
    } else {
      hideError(sizeFitGroup);
    }

    // 키 체크
    const height = form.querySelector('input[name="height"]');
    const heightGroup = height.closest('.form-group');
    if (!height.value.trim()) {
      showError(heightGroup, '키를 입력해주세요.');
      isValid = false;
    } else if (isNaN(height.value) || height.value < 100 || height.value > 250) {
      showError(heightGroup, '올바른 키를 입력해주세요. (100-250cm)');
      isValid = false;
    } else {
      hideError(heightGroup);
    }

    // 몸무게 체크
    const weight = form.querySelector('input[name="weight"]');
    const weightGroup = weight.closest('.form-group');
    if (!weight.value.trim()) {
      showError(weightGroup, '몸무게를 입력해주세요.');
      isValid = false;
    } else if (isNaN(weight.value) || weight.value < 30 || weight.value > 200) {
      showError(weightGroup, '올바른 몸무게를 입력해주세요. (30-200kg)');
      isValid = false;
    } else {
      hideError(weightGroup);
    }

    // 평소 사이즈 체크
    const usualSize = form.querySelector('input[name="usual_size_top"]:checked');
    const usualSizeGroup = form.querySelector('input[name="usual_size_top"]').closest('.form-group');
    if (!usualSize) {
      showError(usualSizeGroup, '평소 사이즈를 선택해주세요.');
      isValid = false;
    } else {
      hideError(usualSizeGroup);
    }

    return isValid;
  }

  function showError(element, message) {
    element.classList.add('error');
    let errorDiv = element.querySelector('.error-message');
    if (!errorDiv) {
      errorDiv = document.createElement('div');
      errorDiv.className = 'error-message';
      element.appendChild(errorDiv);
    }
    errorDiv.textContent = message;
  }

  function hideError(element) {
    element.classList.remove('error');
    const errorDiv = element.querySelector('.error-message');
    if (errorDiv) {
      errorDiv.style.display = 'none';
    }
  }

  // 실시간 유효성 검사를 위한 이벤트 리스너 추가
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('reviewForm');
    
    // 텍스트 입력 필드에 대한 실시간 검사
    form.querySelector('textarea[name="content"]').addEventListener('input', function() {
      const contentGroup = this.closest('.form-group');
      if (!this.value.trim()) {
        showError(contentGroup, '리뷰 내용을 입력해주세요.');
      } else if (this.value.trim().length < 10) {
        showError(contentGroup, '리뷰 내용을 10자 이상 입력해주세요.');
      } else {
        hideError(contentGroup);
      }
    });

    // 숫자 입력 필드에 대한 실시간 검사
    form.querySelector('input[name="height"]').addEventListener('input', function() {
      const heightGroup = this.closest('.form-group');
      if (!this.value.trim()) {
        showError(heightGroup, '키를 입력해주세요.');
      } else if (isNaN(this.value) || this.value < 100 || this.value > 250) {
        showError(heightGroup, '올바른 키를 입력해주세요. (100-250cm)');
      } else {
        hideError(heightGroup);
      }
    });

    form.querySelector('input[name="weight"]').addEventListener('input', function() {
      const weightGroup = this.closest('.form-group');
      if (!this.value.trim()) {
        showError(weightGroup, '몸무게를 입력해주세요.');
      } else if (isNaN(this.value) || this.value < 30 || this.value > 200) {
        showError(weightGroup, '올바른 몸무게를 입력해주세요. (30-200kg)');
      } else {
        hideError(weightGroup);
      }
    });

    // 라디오 버튼 그룹에 대한 실시간 검사
    const radioGroups = {
      'satisfaction_text': '만족도를 선택해주세요.',
      'size_fit': '사이즈 평가를 선택해주세요.',
      'usual_size_top': '평소 사이즈를 선택해주세요.'
    };

    Object.entries(radioGroups).forEach(([name, message]) => {
      const radios = form.querySelectorAll(`input[name="${name}"]`);
      radios.forEach(radio => {
        radio.addEventListener('change', function() {
          const group = this.closest('.form-group');
          if (form.querySelector(`input[name="${name}"]:checked`)) {
            hideError(group);
          } else {
            showError(group, message);
          }
        });
      });
    });

    // 구매 옵션 실시간 검사
    ['purchase_option_size', 'purchase_option_color'].forEach(name => {
      const radios = form.querySelectorAll(`input[name="${name}"]`);
      radios.forEach(radio => {
        radio.addEventListener('change', function() {
          const optionGroup = form.querySelector('.option-group').closest('.form-group');
          const sizeChecked = form.querySelector('input[name="purchase_option_size"]:checked');
          const colorChecked = form.querySelector('input[name="purchase_option_color"]:checked');
          
          if (sizeChecked && colorChecked) {
            hideError(optionGroup);
          } else {
            showError(optionGroup, '사이즈와 색상을 모두 선택해주세요.');
          }
        });
      });
    });
  });
</script>