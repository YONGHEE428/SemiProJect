<%@page import="data.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<title>리뷰 목록</title>
</head>
<body>
<%
    String idParam = request.getParameter("product_id");
    int productId = 0;
    if (idParam != null && !idParam.trim().isEmpty()) {
        productId = Integer.parseInt(idParam);
    }

    ReviewDAO dao = new ReviewDAO();
    List<ReviewDTO> list = dao.getReviewsByProductId(productId);
%>

<div class="container mt-4">
    <h5 class="mb-2">리뷰 목록 (<%= list.size() %>개)</h5>

    <%
    double avgRating = dao.getAverageRatingByProductId(productId); // 평균 별점 예: 3.6
    int fullStars = (int) avgRating;            // 꽉 찬 별 개수
    boolean halfStar = (avgRating - fullStars) >= 0.5; // 반 별 여부
    int emptyStars = 5 - fullStars - (halfStar ? 1 : 0); // 나머지 빈 별
%>

<div style="font-size: 20px; margin-bottom: 10px;">
    <strong>평균 만족도: </strong>

    <%-- 꽉 찬 별 --%>
    <% for (int i = 0; i < fullStars; i++) { %>
        <i class="bi bi-star-fill"></i>
    <% } %>

    <%-- 반 별 --%>
    <% if (halfStar) { %>
        <i class="bi bi-star-half"></i>
    <% } %>

    <%-- 빈 별 --%>
    <% for (int i = 0; i < emptyStars; i++) { %>
        <i class="bi bi-star"></i>
    <% } %>

    <span style="font-size: 16px; color: #333;">(<%= String.format("%.1f", avgRating) %> / 5.0)</span>
</div>

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
                    사이즈: <%= dto.getSizeFit() %> ,
                    키: <%= dto.getHeight() %> ,
                    몸무게: <%= dto.getWeight() %> ,
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