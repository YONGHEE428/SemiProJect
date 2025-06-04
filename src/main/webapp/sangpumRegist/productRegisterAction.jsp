<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.io.*, java.util.regex.Pattern, java.util.regex.Matcher" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dto.ProductOptionDto" %>
<%@ page import="data.dao.ProductDao" %>

<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String message = "";
    String redirectUrl = "./sangpumRegist.jsp"; // 기본 리다이렉션 페이지
    ProductDto productDto = new ProductDto();
    // List<ProductOptionDto> optionList = new ArrayList<>(); // 이 변수 초기화는 mrequest 처리 후에 할 것임

    try {
        // 1. 파일 업로드 설정
        String savePath = application.getRealPath("/uploads/products");
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); // 업로드 디렉터리 생성
        }
        int maxSize = 10 * 1024 * 1024; // 최대 업로드 파일 크기: 10MB
        String encoding = "UTF-8";
        MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 2. 폼 데이터 추출
        String productName = mrequest.getParameter("productName");
        String productPriceStr = mrequest.getParameter("productPrice");
        String selectedCategory = mrequest.getParameter("selectedCategory");
        String productDetailContent = mrequest.getParameter("product_detail");
        String formActionType = mrequest.getParameter("form_action_type"); // "register" 또는 "temporary_save"
        String productImageFileName = mrequest.getFilesystemName("productImage"); // 서버에 저장된 실제 파일명
        // 3. ProductDto 기본 정보 채우기 (유효성 검사 전 공통 부분)
        productDto.setProductName(productName);
        productDto.setCategory(selectedCategory);
        productDto.setDescription(productDetailContent);

        // 이미지 파일 바이트 배열로 변환
        if (productImageFileName != null) {
            File imageFile = new File(savePath, productImageFileName);
            if (imageFile.exists()) { // 파일이 실제로 존재하는지 확인
                byte[] imageBytes = new byte[(int) imageFile.length()];
                
                try (FileInputStream fis = new FileInputStream(imageFile)) {
                    fis.read(imageBytes);
                } catch (IOException e) {
                    // 이미지 파일을 읽는 중 오류가 발생했음을 사용자에게 알림
                    throw new IllegalArgumentException("이미지 파일을 읽는 중 오류가 발생했습니다: " + e.getMessage());
                }
                productDto.setMainImage(imageBytes);
            } else {
                 // 파일이 업로드되지 않았거나 경로에 없는 경우 (선택적 처리)
                 // 예를 들어, 임시저장 시 이미지가 필수가 아니라면 처리 로직 변경
                 System.out.println("Warning: Uploaded image file not found at " + imageFile.getAbsolutePath());
                 productDto.setMainImage(null); // 또는 기존 이미지를 유지하는 로직 추가
            }
        }

        // 4. "상품 등록하기" 시 주요 필드 유효성 검사
        if ("register".equals(formActionType)) {
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
            if (productImageFileName == null || productImageFileName.trim().isEmpty()) {
                throw new IllegalArgumentException("상품 메인 이미지를 등록해주세요.");
            }
            if (productDetailContent == null || productDetailContent.trim().isEmpty()) {
                throw new IllegalArgumentException("상품 상세 내용을 입력해주세요.");
            }
        } else { // "임시저장" 또는 기타 경우 가격 처리
            if (productPriceStr != null && !productPriceStr.trim().isEmpty()) {
                try {
                    productDto.setPrice(new BigDecimal(productPriceStr));
                } catch (NumberFormatException e) {
                    productDto.setPrice(BigDecimal.ZERO);
                }
            } else {
                productDto.setPrice(BigDecimal.ZERO);
            }
        }

        // 5. ProductOptionDto 리스트 생성 및 값 설정 (수정된 부분)
        List<ProductOptionDto> optionList = new ArrayList<>(); // 여기에 초기화

        String[] colors = mrequest.getParameterValues("options_color[]"); // 배열로 받기
        String[] sizes = mrequest.getParameterValues("options_size[]");
        String[] quantities = mrequest.getParameterValues("options_quantity[]");

        // 각 배열의 길이가 같고 null이 아닌지 확인 후 처리
        if (colors != null && sizes != null && quantities != null &&
            colors.length == sizes.length && sizes.length == quantities.length) {
            for (int i = 0; i < colors.length; i++) {
                ProductOptionDto optionDto = new ProductOptionDto();
                optionDto.setColor(colors[i]);
                optionDto.setSize(sizes[i]);
                try {
                    optionDto.setStockQuantity(Integer.parseInt(quantities[i]));
                } catch (NumberFormatException e) {
                    optionDto.setStockQuantity(0); // 숫자가 아니면 0으로 처리
                }
                optionList.add(optionDto);
            }
        } else {
            // 옵션 데이터가 없거나, 배열 길이가 일치하지 않을 경우의 처리 (예: 경고 또는 예외)
            System.out.println("Warning: Option data incomplete or mismatched array lengths.");
            // "상품 등록하기" 시에는 옵션이 필수이므로, 여기서 예외를 던질 수 있습니다.
            if ("register".equals(formActionType)) {
                 throw new IllegalArgumentException("상품 옵션 데이터가 올바르지 않습니다.");
            }
        }

        // "상품 등록하기" 시 옵션 항목 자체 및 각 옵션 내부 필드 검사
        if ("register".equals(formActionType)) {
            if (optionList.isEmpty()) {
                throw new IllegalArgumentException("최소 하나 이상의 상품 옵션을 등록해야 합니다.");
            }
            for (int i = 0; i < optionList.size(); i++) {
                ProductOptionDto opt = optionList.get(i);
                if (opt.getColor() == null || opt.getColor().trim().isEmpty()) {
                    throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 색상 정보를 입력해주세요.");
                }
                if (opt.getSize() == null || opt.getSize().trim().isEmpty()) {
                    throw new IllegalArgumentException("옵션 #" + (i + 1) + "의 사이즈 정보를 입력해주세요.");
                }
                // opt.getStockQuantity()는 위에서 0 이상으로 처리됨
            }
        }

        // 6. DAO를 통해 데이터베이스에 저장
        ProductDao productDao = new ProductDao();
        if ("register".equals(formActionType)) {
            productDao.insertProduct(productDto, optionList); // 수정된 DAO 메서드 호출
            message = "상품이 성공적으로 등록되었습니다.";
            redirectUrl = "productListAdmin.jsp";
        } else if ("temporary_save".equals(formActionType)) {
            // TODO: 임시저장 로직 구현
            message = "상품 정보가 임시저장되었습니다. (DB 저장 로직 추가 필요)";
            redirectUrl = "./sangpumRegist.jsp";
        }
    } catch (IllegalArgumentException iae) {
        message = "입력 값 오류: " + iae.getMessage();
        redirectUrl = "./sangpumRegist.jsp";
    } catch (Exception e) {
        e.printStackTrace();
        message = "상품 처리 중 오류가 발생했습니다. 오류: " + e.getClass().getSimpleName();
        redirectUrl = "./sangpumRegist.jsp";
    }

    // 7. 결과 알림 및 페이지 이동 (PRG 패턴 적용)
%>

<script type="text/javascript">
    var alertMessage = '<%= message != null ? message.replace("'", "\\'") : "" %>';
    if (alertMessage) {
        alert(alertMessage);
    }

    var targetUrl = '<%= request.getContextPath() %>';
    var redirectPath = '<%= redirectUrl != null ? redirectUrl : "./sangpumRegist.jsp" %>';

    if (redirectPath.startsWith("./")) {
        targetUrl += redirectPath.substring(1);
    } else if (redirectPath.startsWith("/")) {
        targetUrl += redirectPath;
    } else {
        targetUrl += '/sangpumRegist/sangpumRegist.jsp'; // Fallback
    }

    window.location.href = targetUrl;
</script>