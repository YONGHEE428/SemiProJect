<% page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<% page import="data.dao.MemberDao" %>
<% page import="com.google.gson.Gson"%>
<%@ page import="java.util.HashMap"%>

<% response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
response.setHeader("Pragma","no-cache");
response.setContentType("application/json; charset=UTF-8");
%>

<%
String num=request.getParameter("num");

String status="fail"
String message="";
if (num==null||num.isEmpty()){
    memssage="회원 번호(num)가 제공되지 않았습니다.";
}else{try{
    MemberDao dao=new MemberDao();
    dao.deleteMember(num);
    status="success";
    message="회원이 성공적으로 삭제되었습니다.";

}catch(Exception e){
    status="error";
    message="회원 삭제중 오류가 발생했스빈다: "+e.getMessage();
    message="회원 삭제중 오류가 발생했습니다:" +e.getMessage();
    e.printStackTrace();
}
}

Gson gson=new Gson();
HashMap<String,String> responseMap=new HashMap<>();
responseMap.put("status",status);
responseMap.put("message",message);

String json=gson.toJson(responceMap);

out.print(json);
out.flush();
%>