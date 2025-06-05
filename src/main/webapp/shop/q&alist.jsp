<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.List" %>
<%@ page import="data.dao.Q_ADao" %>
<%@ page import="data.dto.Q_ADto" %>

<%
    // 상품 ID를 파라미터로 받음
    String productIdParam = request.getParameter("product_id");
    int productId = (productIdParam != null && !productIdParam.isEmpty()) 
                    ? Integer.parseInt(productIdParam) : 0;

    Q_ADao dao = new Q_ADao();
    List<Q_ADto> inquiries = dao.getInquiriesByProductId(productId);
%>

<head>
    <title>상품 문의 목록</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>

<h2>상품 문의 목록</h2>

<% if (inquiries.isEmpty()) { %>
    <p>등록된 문의가 없습니다.</p>
<% } else { %>
    <table>
        <thead>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>비공개</th>
            </tr>
        </thead>
        <tbody>
        <% for (Q_ADto dto : inquiries) { %>
            <tr>
                <td>
                    <% if (dto.isPrivate()) { %>
                        🔒 비공개 문의입니다.
                    <% } else { %>
                        <%= dto.getTitle() %>
                    <% } %>
                </td>
                <td><%= dto.getUserId() %></td>
                <td><%= dto.getCreatedAt() %></td>
                <td><%= dto.isPrivate() ? "예" : "아니오" %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
<% } %>

</body>
</html>
</body>
</html>