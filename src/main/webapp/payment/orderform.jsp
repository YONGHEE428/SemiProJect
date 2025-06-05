<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao, data.dto.CartListDto, java.util.List, java.util.ArrayList" %>
<%
    String idxs = request.getParameter("idxs"); // "1,3,7"
    List<CartListDto> orderItems = new ArrayList<>();
    if (idxs != null && !idxs.trim().isEmpty()) {
        String[] arr = idxs.split(",");
        CartListDao cartDao = new CartListDao();
        for (String idx : arr) {
            CartListDto dto = cartDao.getCartItemByIdx(Integer.parseInt(idx));
            if (dto != null) orderItems.add(dto);
        }
    }
%>

<section class="order-section">
    <h2>주문목록</h2>
    <div class="order-list">
        <% for(CartListDto item : orderItems) { %>
            <div class="order-item">
                <strong><%=item.getProduct_name()%></strong> /
                <%=item.getColor()%> /
                <%=item.getSize()%> /
                <%=item.getCnt()%>개 /
                <%=item.getPrice()%>원
            </div>
        <% } %>
    </div>
</section>
