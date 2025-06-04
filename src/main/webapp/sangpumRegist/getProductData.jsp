<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dto.ProductOptionDto" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %> // BigDecimal 임포트 추가

<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String productIdStr = request.getParameter("productId");
    Map<String, Object> jsonResponse = new HashMap<>();

    if (productIdStr != null && !productIdStr.trim().isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDao productDao = new ProductDao();
            // 상품 기본 정보 조회
            ProductDto productDto = productDao.getProductById(productId);
            // 상품 옵션 정보 조회
            List<ProductOptionDto> optionList = productDao.getProductOptionsByProductId(productId);

            if (productDto != null) {
                // ProductDto에서 가져온 데이터를 JSON 응답 맵에 추가
                jsonResponse.put("productId", productDto.getProductId());
                jsonResponse.put("productName", productDto.getProductName());
                jsonResponse.put("price", productDto.getPrice()); // BigDecimal은 Gson이 잘 변환
                jsonResponse.put("mainImageUrl", productDto.getMainImageUrl());
                jsonResponse.put("description", productDto.getDescription());
                jsonResponse.put("category", productDto.getCategory());
                // 등록 및 업데이트 시간은 필요하다면 추가 (현재 프론트엔드에서 사용하지 않는다면 생략 가능)
                // jsonResponse.put("registeredAt", productDto.getRegisteredAt());
                // jsonResponse.put("updatedAt", productDto.getUpdatedAt());

                // 옵션 리스트도 함께 전달
                jsonResponse.put("options", optionList);
            } else {
                // 해당 ID의 상품이 없을 경우 (선택 사항: 에러 메시지 포함)
                // jsonResponse.put("error", "Product not found for ID: " + productId);
            }

        } catch (NumberFormatException e) {
            // productId가 숫자가 아닌 경우
            System.err.println("Invalid productId format: " + productIdStr);
            jsonResponse.put("error", "Invalid product ID format.");
        } catch (Exception e) {
            // 데이터 조회 중 기타 예외 발생 시
            System.err.println("Error fetching product data: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.put("error", "Failed to retrieve product data: " + e.getMessage());
        }
    } else {
        // productId 파라미터가 없는 경우 (선택 사항: 에러 메시지 포함)
        // jsonResponse.put("error", "Product ID parameter is missing.");
    }

    Gson gson = new Gson();
    out.print(gson.toJson(jsonResponse));
    out.flush();
%>