<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.dao.CartListDao" %>
<%
    String[] idxs = request.getParameterValues("idxs");
    CartListDao dao = new CartListDao();

    if (idxs != null) {
        for (String idx : idxs) {
            dao.markAsPurchased(Integer.parseInt(idx));
        }
        out.print("success");
    } else {
        out.print("no_items");
    }
%>
