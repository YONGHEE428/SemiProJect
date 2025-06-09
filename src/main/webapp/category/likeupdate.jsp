<%@page import="data.dao.WishListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pdao" class="data.dao.ProductDao"/>
<jsp:useBean id="wdao" class="data.dao.WishListDao"/>
<jsp:useBean id="mdao" class="data.dao.MemberDao"/>
<%
	request.setCharacterEncoding("utf-8");

	String productIdStr=request.getParameter("productId");
	String action=request.getParameter("action");
		
	int memberId=mdao.getMemberNumById((String)session.getAttribute("myid"));
	System.out.println("세션 아이디: " + memberId);
	System.out.println("물품아이디 " + productIdStr);		
	String optionIdStr=request.getParameter("optionId");
	
	if(productIdStr!=null && action!=null){
		
		int productId=Integer.parseInt(productIdStr);
		int optionId= optionIdStr !=null?Integer.parseInt(optionIdStr):0;
		System.out.println(memberId+","+productId);	
		if("like".equals(action)){
			pdao.updateLikeCount(productId);
						
			boolean isInserted = wdao.insertWishList(memberId, productId);
			if(isInserted){
				//위시리스트에 추가되었을때 처리할 로직(예:메시지 출력)
				response.getWriter().write("추가되었습니다.");
			}else{
				response.getWriter().write("실패");
			}
            
		}else if("unlike".equals(action)){
			pdao.decreaseLikeCount(productId);
			
		}
	}
	
%>
