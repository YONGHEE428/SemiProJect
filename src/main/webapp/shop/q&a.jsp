<%@page import="data.dto.Q_ADto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.Q_ADao"%>
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
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "../login/loginform.jsp";
    </script>
<%
        return;
    }
    int productId = Integer.parseInt(request.getParameter("product_id"));
%>

<form action="InsertInquiryServlet" method="post">
    <input type="hidden" name="product_id" value="<%= productId %>">
    제목: <input type="text" name="title" required><br>
    내용: <textarea name="content" required></textarea><br>
    공개여부:
    <input type="radio" name="is_private" value="false" checked>공개
    <input type="radio" name="is_private" value="true">비공개<br>
    비밀번호(선택): <input type="password" name="password"><br>
    <input type="submit" value="등록">
</form>

</table>
</body>
</html>