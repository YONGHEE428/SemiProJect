<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
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

  <%  // 1) 리스트 비었을 때
      if (list.isEmpty()) {
  %>
    <p class="text-muted">등록된 문의가 없습니다.</p>
  <%  
      } else {  // 2) 리스트가 있을 때
          // for문을 열고
          for (Q_ADto q : list) {
  %>
    <div class="border rounded p-3 mb-3">
      <div class="d-flex justify-content-between">
        <strong><%= q.isPrivate() ? "[비밀글]" : q.getTitle() %></strong>
        <small class="text-muted"><%= q.getCreatedAt() %></small>
      </div>

      <% if (!q.isPrivate()) { %>
        <!-- 공개 글 -->
        <div class="small text-secondary mb-2">작성자: <%= q.getUserId() %></div>
        <p><%= q.getContent() %></p>
      <% } else { %>
        <!-- 비공개 글 -->
        <p><em class="text-muted">비밀글입니다. 비밀번호를 입력하세요.</em></p>
        <form action="<%= request.getContextPath() %>/CheckInquiryServlet"
      method="post" class="d-flex">
  <input type="hidden" name="inquiryId" value="<%= q.getInquiryId() %>">
          <input type="password" name="password" placeholder="비밀번호" required
                 class="form-control form-control-sm me-2" style="max-width:150px;">
          <button type="submit" class="btn btn-sm btn-primary">확인</button>
        </form>
      <% } %>
    </div>
  <%    }  // for문 닫기
      }   // else 닫기
  %>
</div>