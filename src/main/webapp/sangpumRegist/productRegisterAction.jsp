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
    List<ProductOptionDto> optionList = new ArrayList<>();

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

        // 1. 파일 업로드 후 이미지 파일을 바이트 배열로 변환
        if (productImageFileName != null) {
            File imageFile = new File(savePath, productImageFileName);
            byte[] imageBytes = new byte[(int) imageFile.length()];
            
            try (FileInputStream fis = new FileInputStream(imageFile)) {
                fis.read(imageBytes); // 파일 내용을 바이트 배열로 읽기
            } catch (IOException e) {
                throw new IllegalArgumentException("이미지 파일을 읽는 중 오류가 발생했습니다: " + e.getMessage());
            }
            
            productDto.setMainImage(imageBytes); // 바이트 배열을 setMainImage 메서드에 전달
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
                productDto.setPrice(tempPrice); // 유효성 검사 통과 시 가격 설정
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
                    productDto.setPrice(BigDecimal.ZERO); // 임시저장 시 숫자 변환 실패하면 0으로
                }
            } else {
                productDto.setPrice(BigDecimal.ZERO); // 임시저장 시 가격 없으면 0으로
            }
        }

        // 5. ProductOptionDto 리스트 생성 및 값 설정
        Map<String, ProductOptionDto> optionsMap = new HashMap<>();
        Enumeration<String> paramNames = mrequest.getParameterNames();
        Pattern optionPattern = Pattern.compile("options\\[(\\d+)\\]\\[(color|size|quantity)\\]");

        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            Matcher matcher = optionPattern.matcher(paramName);
            if (matcher.matches()) {
                String optionIndex = matcher.group(1);
                String fieldType = matcher.group(2);
                String value = mrequest.getParameter(paramName);

                // "상품 등록하기" 시 옵션 필드 값 필수 검사 (수량 0은 허용)
                if ("register".equals(formActionType) && (value == null || value.trim().isEmpty())) {
                    if (!("quantity".equals(fieldType) && "0".equals(value.trim()))) {
                        throw new IllegalArgumentException("옵션 #" + (Integer.parseInt(optionIndex) + 1) + "의 " + fieldType + " 값을 입력해주세요.");
                    }
                } else if (value == null || value.trim().isEmpty()) {
                    // 임시저장 시 값 없으면 건너뜀
                    continue;
                }

                ProductOptionDto currentOption = optionsMap.computeIfAbsent(optionIndex, k -> new ProductOptionDto());
                if ("color".equals(fieldType)) {
                    currentOption.setColor(value);
                } else if ("size".equals(fieldType)) {
                    currentOption.setSize(value);
                } else if ("quantity".equals(fieldType)) {
                    try {
                        int quantity = Integer.parseInt(value);
                        if ("register".equals(formActionType) && quantity < 0) {
                            throw new IllegalArgumentException("옵션 #" + (Integer.parseInt(optionIndex) + 1) + "의 수량은 0 이상이어야 합니다.");
                        }
                        currentOption.setStockQuantity(quantity);
                    } catch (NumberFormatException e) {
                        if ("register".equals(formActionType)) {
                            throw new IllegalArgumentException("옵션 #" + (Integer.parseInt(optionIndex) + 1) + "의 수량은 숫자로 입력해주세요.");
                        }
                        currentOption.setStockQuantity(0); // 임시저장 시 숫자 변환 실패면 0으로
                    }
                }
            }
        }

        optionList.addAll(optionsMap.values()); // 옵션 리스트에 추가

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
        ProductDao productDao = new ProductDao(); // 실제 환경에서는 DI 또는 싱글톤 고려
        if ("register".equals(formActionType)) {
            productDao.insertProduct(productDto, optionList);
            message = "상품이 성공적으로 등록되었습니다.";
            redirectUrl = "./productList.jsp"; // 성공 시 상품 목록 페이지로 이동
        } else if ("temporary_save".equals(formActionType)) {
            // TODO: 임시저장 로직 구현
            // 예: productDto.setStatus("TEMPORARY");
            // productDao.saveOrUpdateTemporaryProduct(productDto, optionList);
            message = "상품 정보가 임시저장되었습니다. (DB 저장 로직 추가 필요)";
            redirectUrl = "./sangpumRegist.jsp"; // 다시 등록 폼으로
        }
    } catch (IllegalArgumentException iae) {
        message = "입력 값 오류: " + iae.getMessage();
        redirectUrl = "./sangpumRegist.jsp"; // 오류 발생 시 입력 폼으로 다시 이동
    } catch (Exception e) {
        e.printStackTrace(); // 개발 중 상세 오류 확인
        message = "상품 처리 중 오류가 발생했습니다. 오류: " + e.getClass().getSimpleName();
        redirectUrl = "./sangpumRegist.jsp"; // 오류 발생 시 입력 폼으로 다시 이동
    }

    // 7. 결과 알림 및 페이지 이동 (PRG 패턴 적용)
%>

<script type="text/javascript">
    var alertMessage = '<%= message != null ? message.replace("'", "\\\\'") : "" %>';
    if (alertMessage) { // 메시지가 있을 경우에만 alert
        alert(alertMessage);
    }

    var targetUrl = '<%= request.getContextPath() %>';
    var redirectPath = '<%= redirectUrl != null ? redirectUrl : "./sangpumRegist.jsp" %>';

    if (redirectPath.startsWith("./")) {
        targetUrl += redirectPath.substring(1); // ./ 제거하고 contextPath에 바로 붙임
    } else if (redirectPath.startsWith("/")) {
        targetUrl += redirectPath; // 이미 contextPath 포함된 절대경로 또는 루트 상대경로
    } else {
        // 예기치 않은 형식의 redirectUrl 처리 (기본 페이지로 이동 등)
        targetUrl += '/sangpumRegist/sangpumRegist.jsp';
    }

    window.location.href = targetUrl;
</script>

<% // 스크립트 실행 후 JSP의 나머지 부분 처리 중단 %>
