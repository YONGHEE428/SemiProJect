<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dto.boardlistDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.boardlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String type=request.getParameter("type");
	boardlistDao dao=new boardlistDao();
	List<boardlistDto> list=dao.getListByType(type);  //type별로 가져오기
	
	JSONArray arr=new JSONArray();
	for(boardlistDto dto:list)
	{
		JSONObject ob=new JSONObject();
		ob.put("title",dto.getTitle());
		ob.put("text",dto.getText());
		arr.add(ob);
	}
	
	out.print(arr.toString());
%>
