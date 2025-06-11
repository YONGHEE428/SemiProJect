<%@page import="data.dao.CartListDao"%>
<%@page import="data.dto.CartListDto"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<%
    // 1. 파라미터 받기
    request.setCharacterEncoding("UTF-8");
    int product_id = Integer.parseInt(request.getParameter("product_id"));
    String size = request.getParameter("size");
    String color = request.getParameter("color");
    String cnt = request.getParameter("quantity");
    String redirect = request.getParameter("redirect"); // 리다이렉트 파라미터 추가
	
	String id = (String)session.getAttribute("myid");
     //2. 세션에서 member_id 가져오기
    if (id == null) {
        // 로그인 안 된 경우 alert 창을 보여주고 로그인 페이지로 이동
%>
        <script>
            alert("로그인 후 이용 가능합니다.");
            location.href = "../index.jsp?main=login/loginform.jsp";
        </script>
<%
        return;
    }
    ProductDao pdao = new ProductDao();
    int option_id = pdao.option_num(color, size, product_id);
    System.out.println("제품넘버: " + product_id + "사이즈:" + size + "색상" + color + "갯수" + cnt + "옵션 넘버"+ option_id);
    // 3. DTO 구성
    CartListDto dto = new CartListDto();
    dto.setProduct_id(product_id);
    dto.setMember_id(id);
    dto.setOption_id(option_id);
    dto.setCnt(cnt);

    // 4. DAO 호출
    CartListDao dao = new CartListDao(); 
    dao.InsertCartList(dto);  

    // 5. 리다이렉트 처리
    if("payment".equals(redirect)) {
        // 가장 최근에 추가된 장바구니 항목의 idx 가져오기
        int latest_idx = dao.getLatestCartIdx(id);
        // 바로구매인 경우 결제 페이지로 이동
        response.sendRedirect("../payment/payment.jsp?idxs=" + latest_idx);
        return;
    }
%>
<script>
    if(confirm("장바구니에 추가되었습니다. 이동하시겠습니까?")) {
        location.href = "../index.jsp?main=cart/cartform.jsp";
    } else {
        history.back();
    }
</script>
</body>
</html>