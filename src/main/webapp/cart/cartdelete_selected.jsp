<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao" %>
<%@ page import="java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String[] idxs = request.getParameterValues("idxs[]");

    if (idxs != null && idxs.length > 0) {
        CartListDao dao = new CartListDao();
        for (String idx : idxs) {
            dao.deleteCartItem(Integer.parseInt(idx)); // 단일 삭제 메서드 재사용
        }
    }
%>
