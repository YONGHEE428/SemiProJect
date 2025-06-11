<%@page import="data.dao.TakebackDao"%>
<%@page import="data.dto.TakebackDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String orderIdStr = request.getParameter("order_id");
String paymentIdxStr = request.getParameter("payment_idx");
String orderSangpumIdStr = request.getParameter("order_sangpum_id");
String memberNumStr = (String)session.getAttribute("member_num"); // 세션에서 받거나 hidden에서 받음
String receiverName = (String)session.getAttribute("name");       // 세션에서 받거나 hidden에서 받음
String receiverHp = request.getParameter("receiver_hp");
String receiverAddr = request.getParameter("receiver_addr");
String refundAmountStr = request.getParameter("refund_amount");
String pickupDate = request.getParameter("pickup_date");
String pickupRequest = request.getParameter("pickup_place");

if(orderIdStr == null || paymentIdxStr == null || orderSangpumIdStr == null || memberNumStr == null) {
    out.print("<script>alert('잘못된 접근입니다.');history.back();</script>");
    return;
}

TakebackDto dto = new TakebackDto();
dto.setOrderId(Integer.parseInt(orderIdStr));
dto.setPaymentIdx(Integer.parseInt(paymentIdxStr));
dto.setOrderSangpumId(Integer.parseInt(orderSangpumIdStr)); // 반품 상품 id 저장!
dto.setMemberNum(Integer.parseInt(memberNumStr));
dto.setReceiverName(receiverName);
dto.setReceiverHp(receiverHp);
dto.setReceiverAddr(receiverAddr);
dto.setRefundAmount(Integer.parseInt(refundAmountStr));
dto.setPickupDate(java.sql.Date.valueOf(pickupDate));
dto.setPickupRequest(pickupRequest);
dto.setTakebackStatus("신청");

TakebackDao dao = new TakebackDao();
dao.insertTakeback(dto);

out.print("<script>alert('반품 신청이 완료되었습니다.');location.href='takebacklist.jsp';</script>");
%>
