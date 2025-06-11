<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dao.OrderListDao" %>
<%
// 주문번호 받기
String orderCode = request.getParameter("order_code");

// 주문 삭제 처리
OrderListDao dao = new OrderListDao();
boolean success = dao.deleteOrder(orderCode);

// 결과에 따른 리다이렉트
if(success) {
    response.sendRedirect("orderlistform.jsp");
} else {
    response.sendRedirect("orderlistform.jsp?error=delete_failed");
}
%>
