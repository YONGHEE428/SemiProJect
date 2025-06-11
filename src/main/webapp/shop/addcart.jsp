<<<<<<< HEAD
=======
<%@page import="data.dao.CartListDao"%>
<%@page import="data.dto.CartListDto"%>
>>>>>>> 6cd55fb2480015ec0d1540f56cf7f0ff3686c6f3
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
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
<<<<<<< HEAD
   /*  // 3. DTO 구성
=======
    // 3. DTO 구성
>>>>>>> 6cd55fb2480015ec0d1540f56cf7f0ff3686c6f3
    CartListDto dto = new CartListDto();
    dto.setProduct_id(product_id);
    dto.setMember_id(id);
    dto.setOption_id(option_id);
    dto.setCnt(cnt);

    // 4. DAO 호출
<<<<<<< HEAD
    CartListDao dao = new CartListDao();  */
    
    /*수정바람 dao.addCart(dto); */

    // 5. 장바구니 페이지로 리디렉션
    //response.sendRedirect("cart.jsp");
%>
=======
    CartListDao dao = new CartListDao(); 
    
    dao.InsertCartList(dto);  
%>
<body>
	alert("장바구니에 추가되었습니다.")
</body>
</html>
>>>>>>> 6cd55fb2480015ec0d1540f56cf7f0ff3686c6f3
