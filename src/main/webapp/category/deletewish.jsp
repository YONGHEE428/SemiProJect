<%@page import="data.dao.WishListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script><title>Insert title here</title>
</head>
<body>
	<%
		WishListDao wdao=new WishListDao();
	 	String productId = request.getParameter("productId"); // 전달된 num 값
	 	String memberId = request.getParameter("memberId");
	    if (productId != null && !productId.isEmpty()) {
	        int num = Integer.parseInt(productId);
			int membernum = Integer.parseInt(memberId);
			System.out.print("제품넘버"+num +"멤버값"+ membernum);
	        // 위시리스트 삭제 작업 수행
	        boolean result = wdao.deleteWishList(membernum, num); // DAO에서 삭제 메소드 호출
			
	        if (result) {
	            // 삭제 성공시 처리
	            System.out.print("success");
	        } else {
	            // 삭제 실패시 처리
	            System.out.print("error");
	        }
	    } else {
	        out.print("invalid num");
	    }
		
	%>
	
	
</body>
</html>