<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="data.dao.MemberDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %> <%-- HashMap 임포트 추가 --%>

<%-- JSON 응답을 위한 설정 --%>
<% 
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    response.setContentType("application/json; charset=UTF-8");
%>

<% 
    String num = request.getParameter("num");

    String status = "fail";
    String message = "";

    if (num == null || num.isEmpty()) {
        message = "회원 번호(num)가 제공되지 않았습니다.";
    } else {
        try {
            MemberDao dao = new MemberDao();
            dao.deleteMember(num);
            status = "success";
            message = "회원이 성공적으로 삭제되었습니다.";
        } catch (Exception e) {
            status = "error";
            message = "회원 삭제 중 오류가 발생했습니다: " + e.getMessage();
            e.printStackTrace();
        }
    }

    // Gson 라이브러리를 사용하여 응답을 JSON으로 변환
    Gson gson = new Gson();
    HashMap<String, String> responseMap = new HashMap<>(); // HashMap 객체 생성
    responseMap.put("status", status);
    responseMap.put("message", message);
    
    String json = gson.toJson(responseMap); // HashMap을 JSON으로 변환

    // JSON 출력
    out.print(json);
    out.flush();
%>
