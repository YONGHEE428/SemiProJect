<%@page import="data.dao.WishListDao"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
    request.setCharacterEncoding("UTF-8");

    String productIdStr = request.getParameter("productId");
    String action = request.getParameter("action");
    String optionIdStr = request.getParameter("optionId");

    ProductDao pdao = new ProductDao();
    WishListDao wdao = new WishListDao();
    MemberDao mdao = new MemberDao();

    String userId = (String) session.getAttribute("myid");
    int memberId = 0;
    boolean success = false;
    String message = "";

    if (userId == null) {
        message = "로그인이 필요합니다.";
    } else if (productIdStr == null || action == null) {
        message = "필수 파라미터가 없습니다.";
    } else {
        try {
            memberId = mdao.getMemberNumById(userId);
            int productId = Integer.parseInt(productIdStr);
            int optionId = optionIdStr != null ? Integer.parseInt(optionIdStr) : 0;

            if ("like".equals(action)) {
                pdao.updateLikeCount(productId);
                success = wdao.insertWishList(memberId, productId);
                message = success ? "위시리스트에 추가되었습니다." : "추가에 실패했습니다.";
            } else if ("unlike".equals(action)) {
                pdao.decreaseLikeCount(productId);
                success = wdao.deleteWishList(memberId, productId);
                message = success ? "위시리스트에서 삭제되었습니다." : "삭제에 실패했습니다.";
            } else {
                message = "잘못된 action 값입니다.";
            }
        } catch (NumberFormatException e) {
            message = "상품 ID 또는 옵션 ID가 올바르지 않습니다.";
        } catch (Exception e) {
            message = "서버 오류가 발생했습니다.";
        }
    }

    // JSON 응답
    out.print("{\"success\":" + success + ", \"message\":\"" + message + "\"}");
%>
