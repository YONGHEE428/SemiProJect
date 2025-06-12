<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="data.dao.MemberDao"%>
<%@ page import="data.dto.MemberDto"%>
<%@ page import="com.google.gson.Gson"%>

<%-- JSON 응답을 위한 설정 --%>
<% response.setHeader("Cache-Control", "no-cache");
   response.setDateHeader("Expires", 0);
   response.setHeader("Pragma", "no-cache");
   response.setContentType("application/json; charset=UTF-8");
%>

<% 
    String role = request.getParameter("role");

    MemberDao dao = new MemberDao();
    List<MemberDto> memberList = dao.getAllMembersByRole(role);

    // Gson 라이브러리를 사용하여 List<MemberDto>를 JSON으로 변환
    Gson gson = new Gson();
    String json = gson.toJson(memberList);

    // JSON 출력
    out.print(json);
    out.flush();
%>