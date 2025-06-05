<%@page import="data.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    ReviewDAO dao = new ReviewDAO();
    List<ReviewDTO> list = dao.getAllReviews();
%>

<div class="container mt-4">
    <h5 class="mb-3">리뷰 목록</h5>

    <% if (list == null || list.isEmpty()) { %>
        <p class="text-muted">작성된 리뷰가 없습니다.</p>
    <% } else { %>
        <% for (ReviewDTO dto : list) { %>
            <div class="border rounded p-3 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <strong><%= dto.getMemberName() %></strong>
                    <small class="text-muted"><%= dto.getRegdate() %></small>
                </div>

                <div class="mb-1">
                    <span class="badge bg-secondary">옵션: <%= dto.getPurchaseOption() %></span>
                    <span class="badge bg-info text-dark">만족도: <%= dto.getSatisfactionText() %></span>
                </div>

                <p class="mt-2"><%= dto.getContent() %></p>

                <div class="small text-muted">
                    사이즈: <%= dto.getSizeFit() %>,
                    키: <%= dto.getHeight() %>,
                    몸무게: <%= dto.getWeight() %>,
                    평소사이즈: <%= dto.getUsualSize() %>
                    <% if (dto.getSizeComment() != null && !dto.getSizeComment().isEmpty()) { %>
                        , 한줄평: "<%= dto.getSizeComment() %>"
                    <% } %>
                </div>

                <% if (dto.getPhotoPath() != null && !dto.getPhotoPath().isEmpty()) { %>
                    <div class="mt-3">
                        <img src="<%= request.getContextPath() %>/<%= dto.getPhotoPath() %>" class="img-thumbnail" style="max-width: 200px;" alt="리뷰 이미지">
                    </div>
                <% } %>
            </div>
        <% } %>
    <% } %>
</div>
</body>
</html>