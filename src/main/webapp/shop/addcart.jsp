<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, data.dto.CartListDto, data.dao.CartListDao" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 1. 파라미터 받기
    int product_id = Integer.parseInt(request.getParameter("product_id"));
    String size = request.getParameter("size");
    String color = request.getParameter("color");
    String cnt = request.getParameter("quantity");
	
	String id = (String)session.getAttribute("myid");
     //2. 세션에서 member_id 가져오기
    if (id == null) {
        // 로그인 안 된 경우 로그인 페이지로 이동
        response.sendRedirect("login.jsp");
        return;
    }
    ProductDao pdao = new ProductDao();
    int option_id = pdao.option_num(color, size, product_id);
    System.out.println("제품넘버: " + product_id + "사이즈:" + size + "색상" + color + "갯수" + cnt + "옵션 넘버"+ option_id);
   /*  // 3. DTO 구성
    CartListDto dto = new CartListDto();
    dto.setProduct_id(product_id);
    dto.setMember_id(member_id);
    dto.setOption_id(option_id);
    dto.setSize(size);
    dto.setColor(color);
    dto.setCnt(cnt);

    // 4. DAO 호출
    CartListDao dao = new CartListDao();  */
    
    /*수정바람 dao.addCart(dto); */

    // 5. 장바구니 페이지로 리디렉션
    //response.sendRedirect("cart.jsp");
%>