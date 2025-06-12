<%@page import="data.dao.TakebackDao"%>
<%@page import="data.dto.TakebackDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String orderIdStr = request.getParameter("order_id");
String paymentIdxStr = request.getParameter("payment_idx");
String orderSangpumIdStr = request.getParameter("order_sangpum_id");
String memberNumStr = (String)session.getAttribute("member_num");
String receiverName = (String)session.getAttribute("name");
String receiverHp = request.getParameter("receiver_hp");
String receiverAddr = request.getParameter("receiver_addr");
String refundAmountStr = request.getParameter("refund_amount");
String pickupDate = request.getParameter("pickup_date");
String pickupRequest = request.getParameter("pickup_place");

// 파라미터 체크
if(orderIdStr == null || paymentIdxStr == null || orderSangpumIdStr == null || memberNumStr == null) {
    out.print("<script>alert('잘못된 접근입니다.');history.back();</script>");
    return;
}

// 1. DTO 세팅
TakebackDto dto = new TakebackDto();
dto.setOrderId(Integer.parseInt(orderIdStr));
dto.setPaymentIdx(Integer.parseInt(paymentIdxStr));
dto.setOrderSangpumId(Integer.parseInt(orderSangpumIdStr));
dto.setMemberNum(Integer.parseInt(memberNumStr));
dto.setReceiverName(receiverName);
dto.setReceiverHp(receiverHp);
dto.setReceiverAddr(receiverAddr);
dto.setRefundAmount(Integer.parseInt(refundAmountStr));
dto.setPickupDate(java.sql.Date.valueOf(pickupDate));
dto.setPickupRequest(pickupRequest);
dto.setTakebackStatus("신청");

TakebackDao dao = new TakebackDao();

// 2. 반품신청 인서트
boolean isInserted = dao.insertTakeback(dto); // (insertTakeback가 boolean 리턴)

if(isInserted) {
    // 3. 주문상품 테이블 상태 변경 (반품접수로)
    dao.updateOrderSangpumStatus(dto.getOrderSangpumId(), "반품접수");
    // (buyok 값도 바꾸고 싶으면 orderListDao.updateBuyokToTakeback(dto.getOrderSangpumId()); 추가) 일단 보류 
    %>
   	<script>
  		location.href = '<%=request.getContextPath()%>/index.jsp?main=orderlist/orderlistform.jsp';
	</script>
   <%

} else {
    out.print("<script>alert('반품 db저장 실패 ! 관리자에게 문의하세요.');history.back();</script>");
}
%>
