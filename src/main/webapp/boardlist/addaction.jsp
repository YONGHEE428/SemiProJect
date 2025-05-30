<%@page import="data.dto.boardlistDto"%>
<%@page import="data.dao.boardlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String type=request.getParameter("type");
	String title=request.getParameter("title");
	String text=request.getParameter("text");
	
	boardlistDto dto=new boardlistDto();
	dto.setType(type);
	dto.setTitle(title);
	dto.setText(text);
	
	boardlistDao dao=new boardlistDao();
	dao.insertBoardList(dto);
	
	//response.sendRedirect("s_boardlist/addboardlist.jsp");
	
%>

