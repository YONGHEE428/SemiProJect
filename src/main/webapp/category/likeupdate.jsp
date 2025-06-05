<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pdao" class="data.dao.ProductDao"/>


<%
	request.setCharacterEncoding("utf-8");
	String productIdStr=request.getParameter("productId");
	String action=request.getParameter("action");
	if(productIdStr!=null && action!=null){
		int productId=Integer.parseInt(productIdStr);
		if("like".equals(action)){
			pdao.updateLikeCount(productId);	
		}else if("unlike".equals(action)){
			pdao.decreaseLikeCount(productId);
		}
	}
	
%>