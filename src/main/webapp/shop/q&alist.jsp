<%@ page import="java.util.List" %>
<%@ page import="data.dto.Q_ADto" %>
<%@ page import="data.dao.Q_ADao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.List,data.dto.Q_ADto,data.dao.Q_ADao" %>
<%
    String pid = request.getParameter("product_id");
    if (pid == null || pid.isEmpty()) {
        out.println("<p>잘못된 접근입니다: product_id가 없습니다.</p>");
        return;
    }
    int productId = Integer.parseInt(pid);
    List<Q_ADto> list = new Q_ADao().getInquiriesByProductId(productId);
%>

<div class="qna-list mt-4">
  <h5>문의 내역 (<%= list.size() %>개)</h5>

  <% if (list.isEmpty()) { %>
    <p class="text-muted">등록된 문의가 없습니다.</p>
  <% } else {
       for (Q_ADto q : list) { %>
    <div class="border rounded p-3 mb-3">
      <div class="d-flex justify-content-between">
        <strong><%= q.getTitle() %></strong>
        <small class="text-muted"><%= q.getCreatedAt() %></small>
      </div>
      <div class="small text-secondary mb-2">
        작성자: <%= q.getUserId() %>
        <% if (q.isPrivate()) { %>
          <span style="color:red;">(비밀글)</span>
        <% } %>
      </div>
      <% if (!q.isPrivate()) { %>
        <p><%= q.getContent() %></p>
      <% } else { %>
        <p><em style="color:gray;">[비밀문의입니다]</em></p>
      <% } %>
    </div>
  <%   }
     } %>
</div>