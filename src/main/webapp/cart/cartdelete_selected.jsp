<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao" %>
<%@ page import="java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String[] idxs = request.getParameterValues("idxs");

    if (idxs != null && idxs.length > 0) {
        CartListDao dao = new CartListDao();
        List<Integer> idxList = new ArrayList<>();
        for (String idx : idxs) {
            if (idx != null && !idx.trim().isEmpty())
                idxList.add(Integer.parseInt(idx));
        }
        dao.deleteCartItems(idxList); // 여러개 한 번에 삭제
        out.print("success");
    } else {
        out.print("no idxs");
    }
%>
