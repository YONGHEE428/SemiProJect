<%@ page import="java.util.List" %>
<%@ page import="data.dto.Q_ADto" %>
<%@ page import="data.dao.Q_ADao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String pid = request.getParameter("product_id");
    int productId = (pid != null && !pid.isEmpty()) ? Integer.parseInt(pid) : 0;
    Q_ADao dao = new Q_ADao();
    List<Q_ADto> inquiries = dao.getInquiriesByProductId(productId);
%>

<div class="qna-list mt-4">
  <h5>문의 내역 (<%= inquiries.size() %>개)</h5>

  <% if (inquiries.isEmpty()) { %>
    <p class="text-muted">등록된 문의가 없습니다.</p>
  <% } else { 
       for (Q_ADto q : inquiries) { %>
    <div class="border rounded p-3 mb-3">
      <div class="d-flex justify-content-between">
        <strong><%= q.getTitle() %></strong>
        <small class="text-muted"><%= q.getCreatedAt() %></small>
      </div>
      <div class="small text-secondary mb-2">
        작성자: <%= q.getUserId() %>
        <% if (q.isPrivate()) { %>
          (비밀글)
        <% } %>
      </div>
      <p><%= q.getContent() %></p>
    </div>
  <% } } %>
</div>