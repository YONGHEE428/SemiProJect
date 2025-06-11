
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form action="InsertInquiryServlet" method="post">
    <input type="hidden" name="product_id" value="${param.product_id}">
    제목: <input type="text" name="title" required><br>
    내용: <textarea name="content" required></textarea><br>
    공개여부:
    <input type="radio" name="is_private" value="false" checked>공개
    <input type="radio" name="is_private" value="true">비공개<br>
    비밀번호(선택): <input type="password" name="password"><br>
    <input type="submit" value="등록">
</form>