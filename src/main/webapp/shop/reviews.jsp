<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <form action="submitReview.do" method="post">
        <input type="hidden" name="product_num" value="${product_num}">
        <input type="hidden" name="member_num" value="${sessionScope.member_num}">
        <input type="hidden" name="member_id" value="${sessionScope.member_id}">
        <!-- 추가 폼 필드가 필요하면 여기에 작성 -->

        <button type="submit">리뷰작성하기</button>
    </form>

    리뷰 페이지!!!
</body>
</html>
