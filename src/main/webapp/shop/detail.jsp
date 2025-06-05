<%@page import="data.dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
</head>
<body>

<%
    ProductDto product = (ProductDto) request.getAttribute("product"); // product 객체가 전달되었는지 확인
    String category = product.getCategory();
    String categoryName = "";

    switch (category) {
        case "top": categoryName = "상의"; break;
        case "bottom": categoryName = "하의"; break;
        case "shoes": categoryName = "신발"; break;
        case "accesories": categoryName = "악세서리"; break;
        default: categoryName = "카테고리"; break;
    }
%>

<div class="breadcrumb">
    <a href="<%= request.getContextPath() %>/index.jsp">HOME</a> &gt;
    <a href="<%= request.getContextPath() %>/category/<%= category %>.jsp"><%= categoryName %></a>
</div>

</body>
</html>