<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String productIdStr = request.getParameter("productId");
    String imageUrl = null;

    if (productIdStr != null && !productIdStr.trim().isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDao productDao = new ProductDao();
            imageUrl = productDao.getProductImageUrl(productId); // 이 메서드는 이미 ProductDao에 있을 것입니다.
        } catch (NumberFormatException e) {
            // 숫자 형식 오류 처리
        }
    }

    Map<String, String> jsonResponse = new HashMap<>();
    jsonResponse.put("imageUrl", imageUrl);

    Gson gson = new Gson();
    out.print(gson.toJson(jsonResponse));
    out.flush();
%>