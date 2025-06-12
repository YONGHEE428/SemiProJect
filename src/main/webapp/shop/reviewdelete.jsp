<%@page import="data.dao.ReviewDAO"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 체크
String loginId = (String)session.getAttribute("myid");
if(loginId == null) {%>
    <script>
    	alert("로그인 후 삭제할 수 있습니다.");
    	history.back();
    <%return;
}

// 파라미터 받기
String reviewId = request.getParameter("review_id");
String productId = request.getParameter("product_id");

// ReviewDAO와 MemberDao 인스턴스 생성
ReviewDAO reviewDao = new ReviewDAO();
MemberDao memberDao = new MemberDao();

// 현재 로그인한 사용자의 이름 가져오기
String loginMemberName = memberDao.getName(loginId);

// 리뷰 작성자 이름 확인
String reviewMemberName = reviewDao.getReviewMemberName(reviewId);

if(!loginMemberName.equals(reviewMemberName)) {
    %>
    <script>
        alert("본인이 작성한 리뷰만 삭제할 수 있습니다.");
        history.back();
    </script>
    <%
    return;
}

// 리뷰 삭제
reviewDao.deleteReview(reviewId);

// 리뷰 목록 페이지로 리다이렉트
response.sendRedirect("../index.jsp?main=shop/sangpumpage.jsp&product_id=" + productId);
%> 