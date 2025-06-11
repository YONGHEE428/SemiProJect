<%@page import="data.dao.TakebackDao"%>
<%@page import="data.dto.TakebackDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

// 1. 파라미터 받아오기
String orderIdStr = request.getParameter("order_id");
String paymentIdxStr = request.getParameter("payment_idx");
String memberNumStr = (String)session.getAttribute("member_num"); // 세션에서 받거나 hidden에서 받음
String receiverName = (String)session.getAttribute("name");       // 세션에서 받거나 hidden에서 받음
String receiverHp = request.getParameter("receiver_hp");          // 폼에서 받거나 결제 정보에서 꺼냄
String receiverAddr = request.getParameter("receiver_addr");      // 폼에서 받거나 결제 정보에서 꺼냄
String refundAmountStr = request.getParameter("refund_amount");   // 계산해서 폼에서 hidden으로 보내도 됨
String pickupDate = request.getParameter("pickup_date");          // form radio
String pickupRequest = request.getParameter("pickup_place");      // form radio/textarea

if(orderIdStr == null || paymentIdxStr == null || memberNumStr == null) {
    out.print("<script>alert('잘못된 접근입니다.');history.back();</script>");
    return;
}

// 2. DTO에 값 넣기
TakebackDto dto = new TakebackDto();
dto.setOrderId(Integer.parseInt(orderIdStr));
dto.setPaymentIdx(Integer.parseInt(paymentIdxStr)); 
dto.setMemberNum(Integer.parseInt(memberNumStr));
dto.setReceiverName(receiverName);
dto.setReceiverHp(receiverHp);
dto.setReceiverAddr(receiverAddr);
dto.setRefundAmount(Integer.parseInt(refundAmountStr));
dto.setPickupDate(java.sql.Date.valueOf(pickupDate)); // pickupDate가 yyyy-MM-dd이면 가능
dto.setPickupRequest(pickupRequest);
dto.setTakebackStatus("신청");

// 3. DB 저장
TakebackDao dao = new TakebackDao();
dao.insertTakeback(dto);

// 4. 완료 후 이동
out.print("<script>alert('반품 신청이 완료되었습니다.');location.href='takebacklist.jsp';</script>");
%>
