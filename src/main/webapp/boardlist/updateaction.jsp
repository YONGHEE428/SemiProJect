<%@page import="data.dao.boardlistDao"%>
<%@page import="data.dto.boardlistDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    String idx = request.getParameter("idx");
    String title = request.getParameter("title");
    String text = request.getParameter("text");

    boardlistDto dto = new boardlistDto();
    dto.setIdx(idx);
    dto.setTitle(title);
    dto.setText(text);

    boardlistDao dao = new boardlistDao();
    dao.updateBoardList(dto);
%>