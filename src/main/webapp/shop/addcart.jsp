<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, data.dto.CartListDto, data.dao.CartListDao" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 1. 파라미터 받기
    String product_id = request.getParameter("product_id");
    String option_id = request.getParameter("option_id");
    String size = request.getParameter("size");
    String color = request.getParameter("color");
    String cnt = request.getParameter("cnt");

    // 2. 세션에서 member_id 가져오기
    String member_id = (String) session.getAttribute("member_id");
    if (member_id == null) {
        // 로그인 안 된 경우 로그인 페이지로 이동
        response.sendRedirect("login.jsp");
        return;
    }

    // 3. DTO 구성
    CartListDto dto = new CartListDto();
    dto.setProduct_id(product_id);
    dto.setMember_id(member_id);
    dto.setOption_id(option_id);
    dto.setSize(size);
    dto.setColor(color);
    dto.setCnt(cnt);

    // 4. DAO 호출
    CartListDao dao = new CartListDao();
    
    /*수정바람 dao.addCart(dto); */

    // 5. 장바구니 페이지로 리디렉션
    response.sendRedirect("cart.jsp");
%>