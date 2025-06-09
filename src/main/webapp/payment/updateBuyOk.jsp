<%@page import="data.dao.CartListDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 전체상품 주문인지 체크
String all = request.getParameter("all");
String member_id = request.getParameter("member_id");

// CartListDao 객체 생성
CartListDao dao = new CartListDao();

if ("true".equals(all)) {
    // 전체상품 주문인 경우
    dao.markAllAsPurchased(member_id);
} else {
    // 선택상품 주문인 경우
    String idxs = request.getParameter("idxs");
    if (idxs != null && !idxs.trim().isEmpty()) {
        // idxs 문자열을 배열로 분리
        String[] idxArray = idxs.split(",");
        List<Integer> idxList = new ArrayList<>();
        
        // String 배열을 Integer List로 변환
        for (String idx : idxArray) {
            idxList.add(Integer.parseInt(idx));
        }
        
        // markAsPurchased 메서드 호출하여 buyok 값을 1로 업데이트
        dao.markAsPurchased(idxList);
    }
}
%> 