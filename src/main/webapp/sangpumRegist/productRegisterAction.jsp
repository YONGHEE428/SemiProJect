<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.io.*, java.math.BigDecimal" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dto.ProductOptionDto" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.util.S3Config" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>
<%@ page import="com.amazonaws.AmazonServiceException" %>
<%@ page import="com.amazonaws.SdkClientException" %>
<%@ page import="java.util.UUID" %>

<%
    request.setCharacterEncoding("UTF-8");
    String message = "";
    String redirectUrl = "./sangpumRegist.jsp"; // 기본 리다이렉션 페이지
    ProductDto productDto = new ProductDto();
    List<ProductOptionDto> optionList = new ArrayList<>(); // 옵션 리스트 초기화

    // S3 클라이언트 초기화
    AmazonS3 s3Client = S3Config.getS3Client();
    String s3BucketName = S3Config.getS3BucketName();
    String s3BaseUrl = S3Config.getS3BaseUrl(); // S3 기본 URL (이미지 접근용)

    // 상품 ID 가져오기 (수정 모드인지 확인)
    int productId = 0; // 기본값 0 (신규 등록)

    try {
        // 1. 파일 업로드 설정
        String tempUploadPath = application.getRealPath("/temp_uploads");
        File tempUploadDir = new File(tempUploadPath);
        if (!tempUploadDir.exists()) {
            tempUploadDir.mkdirs(); // 임시 디렉토리 생성
        }
        int maxSize = 10 * 1024 * 1024; // 최대 10MB
        String encoding = "UTF-8";
        MultipartRequest mrequest = new MultipartRequest(request, tempUploadPath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 2. 폼 데이터 추출
        String productIdStr = mrequest.getParameter("productId"); // productId 파라미터 가져오기
        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                System.err.println("Invalid productId format: " + productIdStr);
                // 유효하지 않은 productId는 신규 등록으로 간주하거나, 에러 처리
                productId = 0;
            }
        }

        String productName = mrequest.getParameter("productName");
        String productPriceStr = mrequest.getParameter("productPrice");
        String selectedCategory = mrequest.getParameter("selectedCategory");
        String productDetailContent = mrequest.getParameter("product_detail");
        // String formActionType = mrequest.getParameter("form_action_type"); // 더 이상 사용 안 함
        String originalImageFileName = mrequest.getOriginalFileName("productImage"); // 원본 파일명
        String filesystemImageFileName = mrequest.getFilesystemName("productImage"); // 서버에 저장된 임시 파일명

        // 3. ProductDto 기본 정보 채우기
        productDto.setProductId(productId); // 상품 ID 설정 (신규 등록이면 0, 수정이면 기존 ID)
        productDto.setProductName(productName);
        productDto.setCategory(selectedCategory);
        productDto.setDescription(productDetailContent);

        String s3ImageUrl = null; // S3 이미지 URL을 저장할 변수

        // 4. 파일이 업로드된 경우 S3에 업로드
        if (filesystemImageFileName != null && !filesystemImageFileName.trim().isEmpty()) {
            File tempImageFile = new File(tempUploadPath, filesystemImageFileName);
            if (tempImageFile.exists()) {
                // S3에 저장될 고유한 파일명 생성
                String s3Key = "product_images/" + UUID.randomUUID().toString() + "_" + originalImageFileName;
                try {
                    // S3에 파일 업로드
                    s3Client.putObject(new PutObjectRequest(s3BucketName, s3Key, tempImageFile));
                    s3ImageUrl = s3BaseUrl + s3Key; // S3에서 접근할 수 있는 URL 생성
                    tempImageFile.delete(); // S3 업로드 후 임시 파일 삭제
                } catch (AmazonServiceException e) {
                    System.err.println("S3 업로드 실패 (서비스 오류): " + e.getErrorMessage());
                    throw new Exception("S3 업로드 서비스 오류: " + e.getErrorMessage());
                } catch (SdkClientException e) {
                    System.err.println("S3 업로드 실패 (클라이언트 오류): " + e.getMessage());
                    throw new Exception("S3 업로드 클라이언트 오류: " + e.getMessage());
                }
            }
        } else {
            // 파일이 업로드되지 않았을 경우 (예: 상품 수정 시 기존 이미지 유지)
            // 기존 이미지가 있다면 그 URL을 가져와서 사용
            if (productId > 0) { // 수정 모드인 경우
                ProductDao productDao = new ProductDao();
                String existingImageUrl = productDao.getProductImageUrl(productId); // 기존 이미지 URL 조회
                if (existingImageUrl != null && !existingImageUrl.trim().isEmpty()) {
                    s3ImageUrl = existingImageUrl;
                }
            }
        }
        productDto.setMainImageUrl(s3ImageUrl); // ProductDto에 최종 S3 URL 설정

        // 5. 모든 필수 필드 유효성 검사 (등록/수정 공통)
        if (productName == null || productName.trim().isEmpty()) {
            throw new IllegalArgumentException("상품 이름을 입력해주세요.");
        }
        if (productPriceStr == null || productPriceStr.trim().isEmpty()) {
            throw new IllegalArgumentException("상품 가격을 입력해주세요.");
        }
        try {
            BigDecimal tempPrice = new BigDecimal(productPriceStr);
            if (tempPrice.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("상품 가격은 0보다 커야 합니다.");
            }
            productDto.setPrice(tempPrice);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("상품 가격은 유효한 숫자로 입력해주세요.");
        }
        if (selectedCategory == null || selectedCategory.trim().isEmpty()) {
            throw new IllegalArgumentException("상품 카테고리를 선택해주세요.");
        }
        if (s3ImageUrl == null || s3ImageUrl.trim().isEmpty()) {
            throw new IllegalArgumentException("상품 메인 이미지를 등록해주세요.");
        }
        if (productDetailContent == null || productDetailContent.trim().isEmpty()) {
            throw new IllegalArgumentException("상품 상세 내용을 입력해주세요.");
        }

        // 6. ProductOptionDto 리스트 생성 및 값 설정
        String[] colors = mrequest.getParameterValues("options_color[]");
        String[] sizes = mrequest.getParameterValues("options_size[]");
        String[] quantities = mrequest.getParameterValues("options_quantity[]");

        if (colors == null || colors.length == 0 ||
            sizes == null || sizes.length == 0 ||
            quantities == null || quantities.length == 0 ||
            colors.length != sizes.length || sizes.length != quantities.length) {
            throw new IllegalArgumentException("상품 옵션 데이터가 올바르지 않습니다. 모든 옵션 필드를 채우거나 적어도 하나의 옵션을 추가해주세요.");
        }

        for (int i = 0; i < colors.length; i++) {
            String color = colors[i] != null ? colors[i].trim() : "";
            String size = sizes[i] != null ? sizes[i].trim() : "";
            String quantityStr = quantities[i] != null ? quantities[i].trim() : "";

            if (color.isEmpty()) {
                throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 색상 정보를 입력해주세요.");
            }
            if (size.isEmpty()) {
                throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 사이즈 정보를 입력해주세요.");
            }

            ProductOptionDto optionDto = new ProductOptionDto();
            optionDto.setColor(color);
            optionDto.setSize(size);
            try {
                int stockQuantity = Integer.parseInt(quantityStr);
                if (stockQuantity < 0) {
                    throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 상품 수량은 0 이상이어야 합니다.");
                }
                optionDto.setStockQuantity(stockQuantity);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 상품 수량을 올바르게 입력해주세요.");
            }
            optionList.add(optionDto);
        }

        // 7. DAO를 통해 데이터베이스에 저장
        ProductDao productDao = new ProductDao();
        productDao.saveProduct(productDto, optionList); // ⭐️ 세 번째 boolean 인자 제거!

        if (productId > 0) { // productId가 0보다 크면 수정 모드
            message = "상품 정보가 성공적으로 수정되었습니다.";
            redirectUrl = "productListAdmin.jsp"; // 수정 후 리다이렉션
        } else { // productId가 0이면 신규 등록 모드
            message = "상품이 성공적으로 등록되었습니다.";
            redirectUrl = "productListAdmin.jsp"; // 등록 후 리다이렉션
        }

    } catch (IllegalArgumentException iae) {
        message = "입력 값 오류: " + iae.getMessage();
        redirectUrl = "./sangpumRegist.jsp" + (productId > 0 ? "?productId=" + productId : ""); // 수정 모드일 경우 productId 유지
    } catch (Exception e) {
        e.printStackTrace();
        message = "상품 처리 중 오류가 발생했습니다. 오류: " + e.getClass().getSimpleName() + ": " + e.getMessage();
        redirectUrl = "./sangpumRegist.jsp" + (productId > 0 ? "?productId=" + productId : ""); // 수정 모드일 경우 productId 유지
    }
%>

<script type="text/javascript">
    var alertMessage = '<%= message != null ? message.replace("'", "\\'") : "" %>';
    if (alertMessage) {
        alert(alertMessage);
    }

    var targetUrl = '<%= request.getContextPath() %>';
    var redirectPath = '<%= redirectUrl != null ? redirectUrl : "./sangpumRegist.jsp" %>';

    // 상대 경로 처리
    if (redirectPath.startsWith("./")) {
        targetUrl += redirectPath.substring(1); // 앞에 './' 제거
    } else if (redirectPath.startsWith("/")) {
        targetUrl += redirectPath;
    } else {
        // 완전한 파일 이름만 있는 경우 (예: "productListAdmin.jsp"), 현재 JSP가 있는 폴더 기준으로 경로 구성
        // 예: /프로젝트명/현재JSP폴더/productListAdmin.jsp
        var currentPath = window.location.pathname;
        var lastSlashIndex = currentPath.lastIndexOf('/');
        var basePath = currentPath.substring(0, lastSlashIndex);
        targetUrl = basePath + '/' + redirectPath;
    }

    window.location.href = targetUrl;
</script>