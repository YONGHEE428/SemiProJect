<%@page import="data.dto.ProductDto"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String category1 = request.getParameter("category1");
	String category2 = request.getParameter("category2");
    int currentPage=1;
    try {
    	currentPage = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {
    	
    }

    ProductDao dao = new ProductDao();
    List<ProductDto> items = dao.getProductsByCategory(category1, category2, currentPage, 8);

    //System.out.println("요청된 page 값: " + currentPage + "/요청된 category : " + category1 + "," + category2);  // 여기가 핵심!
    Gson gson = new Gson();
    String json = gson.toJson(items);
    out.print(json);
%>
