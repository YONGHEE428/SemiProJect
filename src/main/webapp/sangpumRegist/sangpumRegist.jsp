<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>상품 등록/수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* 기존 스타일은 그대로 유지 */
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
    width: 500px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    font-size: 18px;
    color: #333;
    margin-bottom: 20px;
    align-self: flex-start;
}

.image-preview-container {
    width: 350px;
    height: 350px;
    background-color: #e9ecef;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
    overflow: hidden;
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
    background-color: #343a40;
    color: white;
    margin-bottom: 30px;
}

.btn-secondary {
    background-color: #007bff;
    color: white;
}

.btn-primary {
    background-color: #007bff;
    color: white;
}

.button-group {
    display: flex;
    justify-content: center;
    width: 100%;
}

#imageUpload {
    display: none;
}

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
    width: 100px;
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
    background-color: #ff6b6b !important;
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
    width: 100px;
}

.size-quantity-item input[name$="[quantity]"] {
    width: 80px;
}

.btn-add-size-for-color {
    background-color: #20c997 !important;
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
    padding: 5px 8px !important;
    font-size: 12px !important;
}

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
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 5px;
    padding: 20px;
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
}

.product-option-item .form-group {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.product-option-item .form-group:last-child {
    margin-bottom: 0;
}

.product-option-item label {
    width: 100px;
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
    background-color: #343a40;
    color: white;
    padding: 8px 15px;
    font-size: 14px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    display: block;
    margin: 10px auto 0;
}

.category-option {
    display: inline-block;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-right: 5px;
    margin-bottom: 5px;
    cursor: pointer;
    font-size: 14px;
    background-color: #f8f9fa;
    color: #333;
}

.category-option.selected {
    background-color: #007bff;
    color: white;
    border-color: #007bff;
}
</style>
</head>
<body>
    <form id="productRegistrationForm" class="upload-container"
        method="POST" action="./productRegisterAction.jsp"
        enctype="multipart/form-data">

        <input type="hidden" id="productId" name="productId" value="<%= request.getParameter("productId") != null ? request.getParameter("productId") : "" %>" />


        <h1>1. 상품 메인 이미지 등록</h1>

        <div class="image-preview-container" id="imagePreviewContainer">
            <img src="#" alt="이미지 미리보기" class="image-preview" id="imagePreview" />
            <span class="image-placeholder">이미지가 여기에 표시됩니다.</span>
        </div>

        <input type="file" id="imageUpload" name="productImage"
            accept="image/*" />
        <button type="button" class="btn btn-upload" id="triggerUpload">
            이미지 불러오기</button>

        <div class="info-section">
            <h2>2. 상품 정보 입력(1)</h2>
            <div class="form-group">
                <label for="productName">상품 이름:</label> <input type="text"
                    id="productName" name="productName" />
            </div>
            <div class="form-group">
                <label for="productPrice">상품 가격:</label> <input type="number"
                    id="productPrice" name="productPrice" />
            </div>
            <div class="form-group">
                <label>상품 카테고리:</label>
                <div id="categoryContainer">
                    <div class="category-option" data-value="티셔츠">티셔츠</div>
                    <div class="category-option" data-value="아우터">아우터</div>
                    <div class="category-option" data-value="팬츠">팬츠</div>
                    <div class="category-option" data-value="치마">치마</div>
                    <div class="category-option" data-value="악세서리">악세서리</div>
                    <div class="category-option" data-value="신발">신발</div>
                </div>
                <input type="hidden" id="selectedCategory" name="selectedCategory"
                    value="" />
            </div>

            <div class="product-options-section">
                <h2>2. 상품 정보 입력(2)</h2>
                <div id="productOptionsContainer">
                    </div>
                <button type="button" id="addOptionBtn">항목 추가하기</button>
            </div>

            <div class="editor-section">
                <h2>3. 상품 상세 정보</h2>
                <textarea name="product_detail" id="productDetailTextarea"
                    style="width: 100%; min-height: 200px; border: 1px solid #ccc; padding: 10px; box-sizing: border-box;"
                    placeholder="상품 상세 내용을 입력하세요."></textarea>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary" id="submitButton">상품 등록하기</button>
            </div>
    </form>

    <script>
      let optionItemIndex = 0; // 고유 ID 생성을 위한 인덱스

      $(document).ready(function () {
        const productId = $("#productId").val(); // hidden input에서 productId 가져오기
        const submitButton = $("#submitButton");

        // 상품 ID가 있을 경우 "상품 수정하기"로 버튼 텍스트 변경
        if (productId && parseInt(productId) > 0) {
            submitButton.text("상품 수정하기");
        }

        // ⭐️ 기존 상품 데이터 불러오기 (페이지 로드 시)
        if (productId && parseInt(productId) > 0) {
            $.ajax({
                url: "getProductData.jsp", // 상품 전체 정보 조회 JSP
                data: { productId: productId },
                dataType: "json",
                success: function(response) {
                    if (response && response.productId) { // productId가 유효한 경우만 처리
                        // 1. 이미지 미리보기 업데이트
                        if (response.mainImageUrl) {
                            $("#imagePreview").attr("src", response.mainImageUrl).show();
                            $("#imagePreviewContainer .image-placeholder").hide();
                        }

                        // 2. 상품 이름, 가격, 카테고리 채우기
                        $("#productName").val(response.productName || "");
                        $("#productPrice").val(response.price || ""); // BigDecimal이 문자열로 잘 들어감
                        if (response.category) {
                            $("#selectedCategory").val(response.category);
                            // 선택된 카테고리 시각적으로 표시
                            $("#categoryContainer .category-option").removeClass("selected");
                            $(`.category-option[data-value='${response.category}']`).addClass("selected");
                        }

                        // 3. 상품 상세 정보 채우기
                        $("#productDetailTextarea").val(response.description || "");

                        // 4. 상품 옵션 채우기 (동적으로 추가)
                        $("#productOptionsContainer").empty(); // 기존에 HTML에 있던 기본 항목 제거
                        optionItemIndex = 0; // 인덱스 초기화
                        if (response.options && response.options.length > 0) {
                            response.options.forEach(function(option) {
                                addOptionItem(option); // 기존 옵션 데이터로 항목 추가
                            });
                        } else {
                            // 옵션이 없는 경우, 기본 옵션 항목 하나를 추가합니다.
                            addOptionItem();
                        }
                    } else {
                         // productId는 있으나 서버에서 데이터를 못 찾은 경우
                         console.warn("Product data not found for ID:", productId);
                         // 신규 등록 모드처럼 처리 (기본 옵션 항목 추가)
                         addOptionItem();
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Failed to load product data for editing:", status, error);
                    // 에러 발생 시에도 신규 등록 모드처럼 처리 (기본 옵션 항목 추가)
                    addOptionItem();
                }
            });
        } else {
            // 상품 등록(새로운 상품) 모드인 경우, 기본 옵션 항목 하나를 추가합니다.
            addOptionItem();
        }

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
            // 파일 선택이 취소된 경우 (또는 파일이 없는 경우), 기존 이미지가 있다면 다시 표시
            const currentProductId = $("#productId").val();
            if (currentProductId && parseInt(currentProductId) > 0) {
                // 상품 수정 모드에서 이미지 선택 취소 시, 기존 S3 이미지를 다시 로드
                $.ajax({
                    url: "getProductData.jsp", // 상품의 모든 정보 가져오기 (이미지 URL 포함)
                    data: { productId: currentProductId },
                    dataType: "json",
                    success: function(response) {
                        if (response && response.mainImageUrl) {
                            $("#imagePreview").attr("src", response.mainImageUrl).show();
                            $("#imagePreviewContainer .image-placeholder").hide();
                        } else {
                             $("#imagePreview").attr("src", "#").hide();
                             $("#imagePreviewContainer .image-placeholder").show();
                        }
                    },
                    error: function() {
                        $("#imagePreview").attr("src", "#").hide();
                        $("#imagePreviewContainer .image-placeholder").show();
                    }
                });
            } else {
                // 새로운 상품 등록 모드에서 선택 취소 시
                $("#imagePreview").attr("src", "#").hide();
                $("#imagePreviewContainer .image-placeholder").show(); // 플레이스홀더 보이기
            }
          }
        });

        // "항목 추가하기" 버튼 클릭 시
        $("#addOptionBtn").on("click", function () {
            addOptionItem();
        });

        // "항목 삭제" 버튼 클릭 이벤트 (이벤트 위임 방식 사용)
        $("#productOptionsContainer").on("click", ".btn-remove-option-item", function () {
            $(this).closest(".product-option-item").remove();
            renumberOptionItemHeadings(); // 항목 삭제 후 즉시 번호 재정렬
            if ($("#productOptionsContainer .product-option-item").length === 0) {
                addOptionItem(); // 모든 옵션이 삭제되면 최소 하나는 유지
            }
        });

        // 카테고리 선택 로직
        $("#categoryContainer .category-option").on("click", function () {
          // 모든 카테고리에서 'selected' 클래스 제거
          $("#categoryContainer .category-option").removeClass("selected");
          // 클릭된 카테고리에 'selected' 클래스 추가
          $(this).addClass("selected");
          // 숨겨진 입력 필드에 선택된 카테고리 값 설정
          $("#selectedCategory").val($(this).data("value"));
        });
      }); // $(document).ready 끝

      // 옵션 항목을 추가하는 함수
      function addOptionItem(optionData = {}) {
        const colorVal = optionData.color || '';
        const sizeVal = optionData.size || '';
        const quantityVal = optionData.stockQuantity !== undefined ? optionData.stockQuantity : 0;

        const optionItemHtml = `
            <div class="product-option-item" data-item-index="${optionItemIndex}">
                <div class="option-item-header">
                    <h3>옵션 #${optionItemIndex + 1}</h3>
                    <button type="button" class="btn-remove-option-item">항목 삭제</button>
                </div>
                <div class="form-group">
                    <label for="option_color_${optionItemIndex}">색상 정보:</label>
                    <input type="text" name="options_color[]" id="option_color_${optionItemIndex}" placeholder="예: 빨강" value="${colorVal}">
                </div>
                <div class="form-group">
                    <label for="option_size_${optionItemIndex}">사이즈 정보:</label>
                    <input type="text" name="options_size[]" id="option_size_${optionItemIndex}" placeholder="예: M" value="${sizeVal}">
                </div>
                <div class="form-group">
                    <label for="option_quantity_${optionItemIndex}">상품 수량:</label>
                    <input type="number" name="options_quantity[]" id="option_quantity_${optionItemIndex}" placeholder="예: 10" value="${quantityVal}" min="0">
                </div>
            </div>
        `;
        $("#productOptionsContainer").append(optionItemHtml);
        optionItemIndex++; // 인덱스 증가
        renumberOptionItemHeadings(); // 새 항목 추가 후 즉시 번호 재정렬
      }

      // 옵션 항목들의 제목(H3)을 순서대로 재정렬하는 함수
      function renumberOptionItemHeadings() {
          let index = 1;
          $("#productOptionsContainer .product-option-item").each(function () {
            $(this).find(".option-item-header h3").text(`옵션 #${index}`);
            index++;
          });
      }

      // 상품 정보 폼 제출 함수
      $("#productRegistrationForm").on("submit", function(event) {
        event.preventDefault(); // 기본 제출 동작 막기

        // 3. 상품 상세 내용 유효성 검사 (공통)
        const productDetailTextarea = $("#productDetailTextarea");
        if (productDetailTextarea.val().trim() === "" ||
            productDetailTextarea.val().toLowerCase().replace(/<p><\/p>/gi, "").trim() === "") {
          alert("3. 상품 상세 내용을 입력해 주세요.");
          productDetailTextarea.focus();
          return;
        }

        // 1. 상품 메인 이미지 등록 확인
        const productId = $("#productId").val();
        const isNewProduct = (!productId || parseInt(productId) <= 0);

        if (isNewProduct && $("#imageUpload").get(0).files.length === 0) {
          alert("1. 상품 메인 이미지를 등록해 주세요.");
          return;
        }

        // 2. 상품 정보 입력(1) 유효성 검사
        const productNameInput = $("#productName");
        if (productNameInput.val().trim() === "") {
          alert("2. 상품 정보 입력(1) - 상품 이름을 입력해 주세요.");
          productNameInput.focus();
          return;
        }
        const productPriceInput = $("#productPrice");
        const productPrice = parseFloat(productPriceInput.val());
        if (isNaN(productPrice) || productPrice <= 0) {
          alert("2. 상품 정보 입력(1) - 상품 가격을 올바르게 입력해 주세요.");
          productPriceInput.focus();
          return;
        }
        const selectedCategoryInput = $("#selectedCategory");
        if (selectedCategoryInput.val().trim() === "") {
          alert("2. 상품 정보 입력(1) - 상품 카테고리를 선택해 주세요.");
          return;
        }

        // 2. 상품 정보 입력(2) - 상품 옵션 유효성 검사
        const optionItems = $("#productOptionsContainer .product-option-item");
        if (optionItems.length === 0) {
          alert("2. 상품 정보 입력(2) - 적어도 하나 이상의 상품 옵션(색상, 사이즈, 수량)을 추가해 주세요.");
          return;
        }

        let optionsValid = true;
        optionItems.each(function (idx) {
            const colorInput = $(this).find("input[name='options_color[]']");
            const sizeInput = $(this).find("input[name='options_size[]']");
            const quantityInput = $(this).find("input[name='options_quantity[]']");

            const color = colorInput.val().trim();
            const size = sizeInput.val().trim();
            const quantity = quantityInput.val().trim();
            const quantityVal = parseInt(quantity);

            if (color === "") {
                alert(`옵션 #${idx + 1}: 색상 정보를 입력해 주세요.`);
                optionsValid = false;
                colorInput.focus();
                return false; // .each 루프 중단
            }
            if (size === "") {
                alert(`옵션 #${idx + 1}: 사이즈 정보를 입력해 주세요.`);
                optionsValid = false;
                sizeInput.focus();
                return false;
            }
            if (quantity === "" || isNaN(quantityVal) || quantityVal < 0) {
                alert(`옵션 #${idx + 1}: 상품 수량을 0 이상으로 정확히 입력해 주세요.`);
                optionsValid = false;
                quantityInput.focus();
                return false;
            }
        });

        if (!optionsValid) {
            return; // 유효성 검사 실패 시 제출 중단
        }

        // 모든 유효성 검사 통과 시 폼 제출
        this.submit(); // jQuery 객체가 아닌 DOM 요소를 사용
      });
    </script>
</body>
</html>