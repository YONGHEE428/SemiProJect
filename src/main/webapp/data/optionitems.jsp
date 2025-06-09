<%@page import="data.dto.ProductDto"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String categoryName = request.getParameter("category");
    int currentPage=1;
    try {
    	currentPage = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {
    	
    }

    ProductDao dao = new ProductDao();
    List<ProductDto> items = dao.getProductsWithOptionsByCategoryWithPaging(categoryName, currentPage, 16);

    Gson gson = new Gson();
    String json = gson.toJson(items);
    out.print(json);
%>
