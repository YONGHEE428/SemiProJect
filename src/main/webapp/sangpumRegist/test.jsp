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
        method="POST" action="<%= request.getContextPath() %>/sangpumRegist/productRegisterAction.jsp"
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
        let optionItemIndex=0;

        $(document).ready(function(){
            const productId=$("#productId").val();
            const submitButton=$("#submitButton");

            if(productId &&parseInt(productId)>0){
                submitButton.text("상품 수정하기");
            }

            if(productId && parseInt(productId)>0){
                submitButton.text("상품 수정하기");
            }

            if(productId && parseInt(productId)>0){
                $.ajax({
                    url:"getProductData.jsp",
                    data:{productId:productId},
                    dataType:"json",
                    success:function(response){
                        console.log("AJAX Response:",response);
                        if(response && response.productId){
                            if(response.mainImageUrl){
                                $("#imagePreview").attr("src",response.mainImageUrl).show();
                                $("#imagePreviewContainer .image-placeholder").hide();
                            }

                            $("#productName").val(response.productName || "");
                            $("#productPrice").val(response.price || "");
                            if(response.category){
                                $("#selectedCategory set to hidden input:",$("selectedCategory").val());

                                $("#categoryContainer . category-option").removeClass("selected");

                                $("categoryContainer .category-option").each(funxtion(){
                                    if($(this).data("value")===response.category){
                                        $(this).addClass("selected");
                                        console.log("Category selected by iteration:",$(this).data("value"));
                                        return false;
                                    }
                                });
                            }
                            $("#productDetailTextared").val(response.description || "");

                            console.log("Processing oprions:",response.options);
                            $("#productOptionsContainer").empty();
                            oprionItemIndex=0;
                            if(response.options && response.options.length>0){
                                response.options.forEach(funxtion(option){
                                    addOptionItem(option);
                                });
                            }else{
                                addOptionItem();
                            }
                             
                        },
                        error:funxtion(xhr.status,error){
                            console.error("Failed to load product")
                        }
                    
                            
                        
                
            
        
     
    </script>
</body>
</html>