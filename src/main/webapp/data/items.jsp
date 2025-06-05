<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    int currentPage = 1;
    try {
        currentPage = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {}
    
    ProductDao dao = new ProductDao();
    List<ProductDto> items = dao.getProductsByPage(currentPage, 8);
    
    Gson gson = new Gson();
    String json = gson.toJson(items);
    
    System.out.println("요청된 page 값: " + currentPage);  // 여기가 핵심!
    out.print(json);
%>
 