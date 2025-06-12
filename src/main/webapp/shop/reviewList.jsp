<%@page import="data.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDAO"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<title>리뷰 목록</title>

<style>
.delete-btn {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
}

.delete-btn:hover {
    background-color: #c82333;
}
</style>
</head>
<body>
<%
    String idParam = request.getParameter("product_id");
    int productId = 0;
    if (idParam != null && !idParam.trim().isEmpty()) {
        productId = Integer.parseInt(idParam);
    }
    
    // 현재 로그인한 사용자의 정보 가져오기
    String loginId = (String)session.getAttribute("myid");
    String loginMemberName = null;
    if(loginId != null) {
        MemberDao memberDao = new MemberDao();
        loginMemberName = memberDao.getName(loginId);
    }

    ReviewDAO dao = new ReviewDAO();
    List<ReviewDTO> list = dao.getReviewsByProductId(productId);
    
    
%>
<script>
function deleteReview(reviewId) {
    if (confirm('작성하신 리뷰를 삭제하시겠습니까?')) {
        location.href = 'shop/reviewdelete.jsp?review_id=' + reviewId + '&product_id=<%= productId %>';
    }
}
</script>
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
                    <div>
                        <small class="text-muted me-2"><%= dto.getRegdate() %></small>
                        <% if (loginMemberName != null && loginMemberName.equals(dto.getMemberName())) { %>
                            <button type="button" class="delete-btn" onclick="deleteReview('<%= dto.getId() %>')">
                                삭제
                            </button>
                        <% } %>
                    </div>
                </div>

                <div class="mb-1">
                    <span class="badge bg-secondary">옵션: <%= dto.getPurchaseOption() %></span>
                    <span class="badge bg-info text-dark">만족도: <%= dto.getSatisfactionText() %></span>
                </div>

                <p class="mt-2"><%= dto.getContent() %></p>

                <div class="small text-muted">
                    <b>사이즈:</b> <%= dto.getSizeFit() %> ,
                    <b>키:</b> <%= dto.getHeight() %> ,
                    <b>몸무게:</b> <%= dto.getWeight() %> ,
                    <b>평소사이즈:</b> <%= dto.getUsualSize() %>
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