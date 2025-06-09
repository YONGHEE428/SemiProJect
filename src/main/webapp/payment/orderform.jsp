<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao, data.dto.CartListDto, java.util.List, java.util.ArrayList" %>
<%
String idxs = request.getParameter("idxs"); // 예: "2,4,8"
String[] idxArr = idxs.split(",");
CartListDao dao = new CartListDao();
for (String idx : idxArr) {
    dao.markAsPurchased(Integer.parseInt(idx));  // buyok=1로
}
response.sendRedirect("orderform.jsp");

%>
<%
String memberId = (String) session.getAttribute("myid");
CartListDao cartDao = new CartListDao();
// 주문내역만 불러오는 쿼리 (buyok=1)
List<CartListDto> orderList = cartDao.getCartListByBuyok(memberId, 1);
%>
<!-- 주문목록 반복 출력 -->
<% for(CartListDto item : orderList) { %>
    <div class="order-item">
    	<img src="<%=item.getMain_image_url()%>">
        <strong><%=item.getProduct_name()%></strong>
        / <%=item.getColor()%>
        / <%=item.getSize()%>
        / <%=item.getCnt()%>개
        / <%=item.getPrice()%>원
        / <%=item.getWriteday()%>
    </div>
<% } %>
