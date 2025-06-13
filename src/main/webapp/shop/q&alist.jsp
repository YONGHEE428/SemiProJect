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
<style>
.qna-list {
    max-width: 800px;
    margin: 0 auto;
}

.qna-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 2px solid #f0f0f0;
}

.qna-header h5 {
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
    margin: 0;
}

.qna-count {
    color: #666;
    font-size: 0.9rem;
}

.qna-item {
    background: #fff;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 1rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    transition: all 0.2s ease;
}

.qna-item:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    transform: translateY(-1px);
}

.qna-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.8rem;
}

.qna-title strong {
    font-size: 1.1rem;
    color: #333;
}

.qna-date {
    color: #888;
    font-size: 0.9rem;
}

.qna-author {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 1rem;
}

.qna-content {
    color: #444;
    line-height: 1.6;
    margin: 0;
}

.private-form {
    display: flex;
    gap: 0.8rem;
    margin-top: 1rem;
    align-items: center;
}

.private-form input[type="password"] {
    width: 180px;
    padding: 0.7rem 1rem;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    font-size: 0.95rem;
    transition: all 0.2s ease;
    background-color: #f8f9fa;
}

.private-form input[type="password"]:focus {
    outline: none;
    border-color: #333;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.05);
    background-color: #fff;
}

#passsubmit {
    padding: 0.7rem;
    background: #333;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 0.9rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    white-space: nowrap;
    max-width: 60px;
    height: 42px;
    margin: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.private-form button:hover {
    background: #222;
    transform: translateY(-1px);
}

.empty-message {
    text-align: center;
    padding: 3rem 0;
    color: #888;
    font-size: 1.1rem;
}

.private-message {
    color: #666;
    font-style: italic;
    margin: 0.5rem 0;
}
</style>

<div class="qna-list">
    <div class="qna-header">
        <h5>문의 내역</h5>
        <span class="qna-count"><%= list.size() %>개의 문의</span>
    </div>

    <% if (list.isEmpty()) { %>
        <div class="empty-message">
            등록된 문의가 없습니다.
        </div>
    <% } else {
        for (Q_ADto q : list) { %>
            <div class="qna-item">
                <div class="qna-title">
                    <strong><%= q.isPrivate() ? "[비밀글]" : q.getTitle() %></strong>
                    <span class="qna-date"><%= q.getCreatedAt() %></span>
                </div>

                <% if (!q.isPrivate()) { %>
                    <div class="qna-author">작성자: <%= q.getUserId() %></div>
                    <p class="qna-content"><%= q.getContent() %></p>
                <% } else { %>
                    <p class="private-message">비밀글입니다. 비밀번호를 입력하세요.</p>
                    <form action="<%= request.getContextPath() %>/CheckInquiryServlet"
                          method="post" class="private-form">
                        <input type="hidden" name="inquiryId" value="<%= q.getInquiryId() %>">
                        <input type="password" name="password" placeholder="비밀번호" required>
                        <button type="submit" id= "passsubmit">확인</button>
                    </form>
                <% } %>
            </div>
        <% }
    } %>
</div>