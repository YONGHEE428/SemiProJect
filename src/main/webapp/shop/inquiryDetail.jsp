<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dto.Q_ADto" %>
<%
    Q_ADto q = (Q_ADto) request.getAttribute("inquiry");
    if (q == null) {
        out.println("<p>문의 정보를 불러올 수 없습니다.</p>");
        return;
    }
%>
<div class="inquiry-detail p-4 border rounded">
  <h4><%= q.getTitle() %>
    <small class="text-muted">(<%= q.getCreatedAt() %>)</small>
  </h4>
  <p>작성자: <%= q.getUserId() %></p>
  <hr>
  <div><%= q.getContent() %></div>
  <hr>
  <a href="<%= request.getContextPath() %>/shop/sangpumpage.jsp?product_id=<%= q.getProductId() %>#qna"
     class="btn btn-secondary btn-sm">목록으로 돌아가기</a>
</div>