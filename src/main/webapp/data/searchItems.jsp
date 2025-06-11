<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.WishListDto"%>
<%@page import="data.dao.WishListDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
    
    String keyword = request.getParameter("keyword");
    int pageNum = Integer.parseInt(request.getParameter("page"));
    int itemsPerPage = 16;
    int start = (pageNum - 1) * itemsPerPage;
    
    ProductDao dao = new ProductDao();
    List<ProductDto> list = dao.searchProducts(keyword, start, itemsPerPage);
    
    // 로그인한 사용자의 위시리스트 정보 가져오기
    String loginok = (String)session.getAttribute("loginok");
    String myid = (String)session.getAttribute("myid");
    List<Integer> wishList = null;
    
    if(loginok != null && myid != null) {
        MemberDao mdao = new MemberDao();
        int memberId = mdao.getMemberNumById(myid);
        WishListDao wdao = new WishListDao();
        List<WishListDto> wishItems = wdao.getWishList(memberId);
        wishList = new java.util.ArrayList<>();
        for(WishListDto item : wishItems) {
            wishList.add(item.getProductId());
        }
    }
    
    JSONArray arr = new JSONArray();
    
    for(ProductDto dto : list) {
        JSONObject ob = new JSONObject();
        
        ob.put("productId", dto.getProductId());
        ob.put("category", dto.getCategory());
        ob.put("productName", dto.getProductName());
        ob.put("price", dto.getPrice());
        ob.put("mainImageUrl", dto.getMainImageUrl());
        ob.put("viewCount", dto.getViewCount());
        ob.put("likeCount", dto.getLikeCount());
        
        // 위시리스트에 있는지 확인
        if(wishList != null) {
            ob.put("wish", wishList.contains(dto.getProductId()));
        } else {
            ob.put("wish", false);
        }
        
        arr.add(ob);
    }
%>
<%=arr.toString()%> 