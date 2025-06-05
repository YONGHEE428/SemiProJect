<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("UTF-8");

    String productIdStr = request.getParameter("productId");
    String optionIdStr = request.getParameter("optionId"); // "null" 문자열로 올 수 있음

    String redirectUrl = request.getContextPath() + "/sangpumRegist/productListAdmin.jsp"; // 성공/실패 시 돌아갈 페이지
    String errorMessage = null;
    String successMessage = null;

    if (productIdStr == null || productIdStr.trim().isEmpty()) {
        errorMessage = "오류: 상품 ID가 제공되지 않았습니다.";
    } else {
        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDao productDao = new ProductDao();
            boolean success = false;

            // optionId가 존재하고, "null" 문자열이 아니고, 비어있지 않은 경우 옵션 삭제
            if (optionIdStr != null && !optionIdStr.trim().isEmpty() && !"null".equalsIgnoreCase(optionIdStr)) {
                try {
                    int optionId = Integer.parseInt(optionIdStr);
                    success = productDao.deleteProductOption(optionId);
                    if (success) {
                        successMessage = "상품 옵션이 성공적으로 삭제되었습니다.";
                    } else {
                        errorMessage = "상품 옵션 삭제에 실패했습니다. 해당 옵션이 이미 삭제되었거나 존재하지 않을 수 있습니다.";
                    }
                } catch (NumberFormatException nfe) {
                    errorMessage = "오류: 유효하지 않은 옵션 ID 형식입니다.";
                }
            } else { // optionId가 없는 경우 상품 전체 삭제
                success = productDao.deleteProduct(productId);
                if (success) {
                    successMessage = "상품(모든 옵션 포함)이 성공적으로 삭제되었습니다.";
                } else {
                    errorMessage = "상품 삭제에 실패했습니다. 해당 상품이 이미 삭제되었거나 존재하지 않을 수 있습니다.";
                }
            }

            // 처리 후 메시지를 세션에 담아 리다이렉트 (productListAdmin.jsp에서 이 메시지를 표시하도록 수정 필요)
            // 간단하게 하기 위해 여기서는 메시지 없이 바로 리다이렉트합니다.
            // 만약 메시지를 전달하고 싶다면:
            // if (successMessage != null) session.setAttribute("successMessage", successMessage);
            // if (errorMessage != null) session.setAttribute("errorMessage", errorMessage);


        } catch (NumberFormatException e) {
            errorMessage = "오류: 유효하지 않은 상품 ID 형식입니다.";
            // session.setAttribute("errorMessage", errorMessage);
        } 
         catch (Exception e) {
            errorMessage = "처리 중 예기치 않은 오류가 발생했습니다: " + e.getMessage();
            e.printStackTrace();
            // session.setAttribute("errorMessage", errorMessage);
        }
    }

    // 에러 메시지가 있으면 쿼리 파라미터로 전달 (간단한 방법)
    // 더 나은 방법은 세션을 사용하는 것입니다.
    if (errorMessage != null) {
        redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "errorMessage=" + java.net.URLEncoder.encode(errorMessage, "UTF-8");
    } else if (successMessage != null) {
         redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "successMessage=" + java.net.URLEncoder.encode(successMessage, "UTF-8");
    }


    response.sendRedirect(redirectUrl);
%>
