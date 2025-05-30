<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>상품 이미지 등록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
      body {
        font-family: sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 20px;
        background-color: #f4f4f4;
      }

      .upload-container {
        background-color: #fff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 500px; /* 너비 조정 */
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      h1 {
        font-size: 18px;
        color: #333;
        margin-bottom: 20px;
        align-self: flex-start; /* 왼쪽 정렬 */
      }

      .image-preview-container {
        width: 350px; /* 너비 조정 */
        height: 350px; /* 높이 조정 */
        background-color: #e9ecef;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        overflow: hidden; /* 이미지가 넘칠 경우 숨김 */
      }

      .image-preview {
        max-width: 100%;
        max-height: 100%;
        display: none; /* 기본적으로 숨김 */
      }

      .image-placeholder {
        color: #6c757d;
        text-align: center;
      }

      .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        margin: 5px;
      }

      .btn-upload {
        background-color: #343a40; /* 어두운 회색 계열 */
        color: white;
        margin-bottom: 30px; /* 하단 여백 추가 */
      }

      .btn-secondary {
        background-color: #007bff; /* 파란색 계열 */
        color: white;
      }

      .btn-primary {
        background-color: #007bff; /* 파란색 계열 */
        color: white;
      }

      .button-group {
        display: flex;
        justify-content: center; /* 버튼들을 중앙 정렬 */
        width: 100%;
      }
      /* 파일 입력 필드 숨기기 */
      #imageUpload {
        display: none;
      }

      /* 추가된 섹션 스타일 */
      .info-section,
      .editor-section {
        width: 100%;
        margin-top: 30px;
        margin-bottom: 20px;
      }

      .info-section h2,
      .editor-section h2 {
        font-size: 18px;
        color: #333;
        margin-bottom: 15px;
        align-self: flex-start;
      }

      .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
      }

      .form-group label {
        width: 100px; /* 레이블 너비 고정 */
        margin-right: 10px;
        font-size: 14px;
        color: #333;
        text-align: right;
      }

      .form-group input[type="text"],
      .form-group input[type="number"] {
        flex-grow: 1;
        padding: 8px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 14px;
      }

      /* ==== 색상 옵션 관리 섹션 스타일 ==== */
      .color-options-section {
        width: 100%;
        margin-top: 15px;
        padding-top: 15px;
        border-top: 1px solid #eee;
      }

      .color-option-block {
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 15px;
        background-color: #f9f9f9;
      }

      .color-option-block h3 {
        font-size: 16px;
        color: #333;
        margin-top: 0;
        margin-bottom: 10px;
      }

      .color-input-group {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
      }

      .color-input-group label {
        width: auto;
        margin-right: 10px;
      }

      .color-input-group input[type="text"] {
        flex-grow: 1;
      }

      .btn-remove-color-group {
        background-color: #ff6b6b !important; /* 더 진한 빨강 */
        color: white;
        padding: 6px 10px !important;
        font-size: 12px !important;
        margin-left: 10px;
      }

      .sizes-for-color-container {
        margin-top: 10px;
        padding-left: 10px;
        border-left: 2px solid #007bff;
      }

      /* 기존 .size-quantity-item 스타일 재활용 또는 약간 수정 */
      .size-quantity-item {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
        padding-bottom: 8px;
        border-bottom: 1px dashed #eee;
      }

      .size-quantity-item:last-child {
        border-bottom: none;
      }

      .size-quantity-item label {
        width: auto;
        margin-right: 5px;
      }

      .size-quantity-item input[type="text"],
      .size-quantity-item input[type="number"] {
        padding: 8px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 14px;
        margin-right: 10px;
      }

      .size-quantity-item input[name$="[name]"] {
        /* name 속성이 [name]으로 끝나는 경우 */
        width: 100px;
      }

      .size-quantity-item input[name$="[quantity]"] {
        /* name 속성이 [quantity]으로 끝나는 경우 */
        width: 80px;
      }

      .btn-add-size-for-color {
        background-color: #20c997 !important; /* 민트색 계열 */
        color: white;
        border-color: #20c997 !important;
        padding: 6px 12px !important;
        font-size: 13px !important;
        margin-bottom: 10px;
      }

      .btn-remove-size {
        background-color: #dc3545;
        color: white;
        border-color: #dc3545;
        padding: 5px 8px !important; /* 크기 약간 줄임 */
        font-size: 12px !important;
      }

      /* ==== 상품 옵션 관리 섹션 스타일 (새로운 구조) ==== */
      .product-options-section {
        width: 100%;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #eee;
      }

      .product-options-section h2 {
        font-size: 18px;
        color: #333;
        margin-bottom: 15px;
      }

      .product-option-item {
        background-color: #f8f9fa; /* 연한 회색 배경 */
        border: 1px solid #dee2e6;
        border-radius: 5px;
        padding: 20px;
        margin-bottom: 15px;
        display: flex;
        flex-direction: column; /* 내부 항목들을 세로로 정렬 */
      }

      .product-option-item .form-group {
        display: flex; /* 레이블과 인풋을 가로로 */
        align-items: center;
        margin-bottom: 10px;
      }

      .product-option-item .form-group:last-child {
        margin-bottom: 0; /* 마지막 form-group의 하단 마진 제거 */
      }

      .product-option-item label {
        width: 100px; /* 레이블 너비 고정 */
        margin-right: 10px;
        font-size: 14px;
        color: #333;
        text-align: right;
      }

      .product-option-item input[type="text"],
      .product-option-item input[type="number"] {
        flex-grow: 1;
      }

      .option-item-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
      }

      .option-item-header h3 {
        font-size: 16px;
        color: #333;
        margin: 0;
      }

      .btn-remove-option-item {
        background-color: #dc3545;
        color: white;
        padding: 5px 10px;
        font-size: 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }

      #addOptionBtn {
        background-color: #343a40; /* 어두운 회색 계열 (이미지와 유사하게) */
        color: white;
        padding: 8px 15px;
        font-size: 14px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        display: block; /* 버튼을 블록 요소로 만들어 중앙 정렬 또는 너비 100% 용이 */
        margin: 10px auto 0; /* 위쪽 여백 및 자동 좌우 마진으로 중앙 정렬 */
      }
    </style>
  </head>
  <body>
    <div class="upload-container">
      <h1>1. 상품 메인 이미지 등록</h1>

      <div class="image-preview-container" id="imagePreviewContainer">
        <img
          src="#"
          alt="이미지 미리보기"
          class="image-preview"
          id="imagePreview"
        />
        <span class="image-placeholder">이미지가 여기에 표시됩니다.</span>
      </div>

      <input type="file" id="imageUpload" accept="image/*" />
      <button type="button" class="btn btn-upload" id="triggerUpload">
        이미지 불러오기
      </button>

      <!-- 2. 상품 정보 입력 섹션 -->
      <div class="info-section">
        <h2>2. 상품 정보 입력(1)</h2>
        <div class="form-group">
          <label for="productName">상품 이름:</label>
          <input type="text" id="productName" name="productName" />
        </div>
        <div class="form-group">
          <label for="productPrice">상품 가격:</label>
          <input type="number" id="productPrice" name="productPrice" />
        </div>

        <!-- 새로운 상품 옵션 입력 섹션 (색상, 사이즈, 수량 세트) -->
        <div class="product-options-section">
          <h2>2. 상품 정보 입력(2)</h2>
          <div id="productOptionsContainer">
            <!-- 동적으로 상품 옵션 항목이 추가될 영역 -->
          </div>
          <button type="button" id="addOptionBtn">항목 추가하기</button>
        </div>
      </div>

      <!-- 3. 상품 상세 정보 섹션 -->
      <div class="editor-section">
        <h2>3. 상품 상세 정보</h2>
        <textarea
          name="product_detail"
          id="productDetailTextarea"
          style="
            width: 100%;
            min-height: 200px;
            border: 1px solid #ccc;
            padding: 10px;
            box-sizing: border-box;
          "
          placeholder="상품 상세 내용을 입력하세요."
        ></textarea>
      </div>

      <div class="button-group">
        <button
          type="button"
          class="btn btn-secondary"
          onclick="submitContents(this);"
        >
          임시저장
        </button>
        <button
          type="button"
          class="btn btn-primary"
          onclick="submitContents(this);"
        >
          상품 등록하기
        </button>
      </div>
    </div>

    <script>
      $(document).ready(function () {
        // "이미지 불러오기" 버튼 클릭 시 파일 입력 필드 클릭
        $("#triggerUpload").on("click", function () {
          $("#imageUpload").click();
        });

        // 파일 입력 변경 시
        $("#imageUpload").on("change", function (event) {
          const file = event.target.files[0];
          if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
              $("#imagePreview").attr("src", e.target.result).show();
              $("#imagePreviewContainer .image-placeholder").hide(); // 플레이스홀더 숨기기
            };
            reader.readAsDataURL(file);
          } else {
            // 파일 선택이 취소된 경우 (또는 파일이 없는 경우)
            $("#imagePreview").attr("src", "#").hide();
            $("#imagePreviewContainer .image-placeholder").show(); // 플레이스홀더 보이기
          }
        });

        // --- 새로운 상품 옵션 (색상, 사이즈, 수량 세트) 동적 관리 ---
        let optionItemIndex = 0; // 고유 ID 생성을 위한 인덱스 (계속 증가)

        // 옵션 항목들의 제목(H3)을 순서대로 재정렬하는 함수
        function renumberOptionItemHeadings() {
          let index = 1;
          $("#productOptionsContainer .product-option-item").each(function () {
            $(this).find(".option-item-header h3").text(`옵션 #${index}`);
            index++;
          });
        }

        $("#addOptionBtn").on("click", function () {
          optionItemIndex++; // 폼 요소들의 고유 name/id를 위한 인덱스
          const optionItemHtml = `
                <div class="product-option-item" data-item-index="${optionItemIndex}">
                    <div class="option-item-header">
                        <h3>옵션</h3> <!-- 이 부분은 renumberOptionItemHeadings 함수가 업데이트합니다 -->
                        <button type="button" class="btn-remove-option-item">항목 삭제</button>
                    </div>
                    <div class="form-group">
                        <label for="option_color_${optionItemIndex}">색상 정보:</label>
                        <input type="text" name="options[${optionItemIndex}][color]" id="option_color_${optionItemIndex}" placeholder="예: 빨강">
                    </div>
                    <div class="form-group">
                        <label for="option_size_${optionItemIndex}">사이즈 정보:</label>
                        <input type="text" name="options[${optionItemIndex}][size]" id="option_size_${optionItemIndex}" placeholder="예: M">
                    </div>
                    <div class="form-group">
                        <label for="option_quantity_${optionItemIndex}">상품 수량:</label>
                        <input type="number" name="options[${optionItemIndex}][quantity]" id="option_quantity_${optionItemIndex}" placeholder="예: 10" min="0">
                    </div>
                </div>
            `;
          $("#productOptionsContainer").append(optionItemHtml);
          renumberOptionItemHeadings(); // 새 항목 추가 후 즉시 번호 재정렬
        });

        // 페이지 로드 시, 기존에 표시된 옵션 항목이 없다면 첫 번째 옵션 항목을 기본으로 추가합니다.
        // 이 trigger 호출로 인해 #addOptionBtn의 클릭 핸들러가 실행되고, 그 안에서 renumberOptionItemHeadings가 호출됩니다.
        if ($("#productOptionsContainer .product-option-item").length === 0) {
          $("#addOptionBtn").trigger("click");
        }

        // "항목 삭제" 버튼 클릭 이벤트 (이벤트 위임 방식 사용)
        $("#productOptionsContainer").on(
          "click",
          ".btn-remove-option-item",
          function () {
            $(this).closest(".product-option-item").remove();
            renumberOptionItemHeadings(); // 항목 삭제 후 즉시 번호 재정렬
          }
        );
      }); // $(document).ready 끝

      // 상품 정보 폼 제출 함수 (별도 분리)
      function submitContents(elClickedObj) {
        // 에디터의 내용에 대한 값 검증은 이곳에서
        if (
          document.getElementById("productDetailTextarea").value === "" ||
          document.getElementById("productDetailTextarea").value === null ||
          document.getElementById("productDetailTextarea").value === "&nbsp;" ||
          document
            .getElementById("productDetailTextarea")
            .value.toLowerCase()
            .replace(/<p><\/p>/gi, "")
            .trim() === ""
        ) {
          alert("상세 내용을 입력해 주세요.");
          return; // 폼 제출 중단
        }

        try {
          // 폼을 찾아서 submit 합니다.
          // 실제 폼의 ID나 name으로 더 명확하게 지정하는 것이 좋습니다.
          // 예: $('#productForm').submit(); 또는 document.forms['productFormName'].submit();
          // elClickedObj.form은 버튼이 form 태그 내부에 있을 때 유효합니다.
          if (elClickedObj.form) {
            elClickedObj.form.submit();
          } else {
            // 버튼이 폼 외부에 있거나 폼이 없는 경우를 대비한 대체 로직 (예: AJAX 전송)
            console.error(
              "Form not found for the clicked button. Cannot submit."
            );
            alert("폼을 찾을 수 없어 전송할 수 없습니다.");
          }
        } catch (e) {
          console.error("Error submitting form: ", e);
          alert("폼 제출 중 오류가 발생했습니다.");
        }
      }
    </script>
  </body>
</html>
