<%@page import="data.dto.ProductDto"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.WishListDao"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String category1 = request.getParameter("category1");
    String category2 = request.getParameter("category2");
    int currentPage = 1;
    try {
        currentPage = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {}

    String id = (String) session.getAttribute("myid");
    int memberNum = 0;

    if (id != null) {
        MemberDao mdao = new MemberDao();
        memberNum = mdao.getMemberNumById(id);
    }

    ProductDao dao = new ProductDao();
    WishListDao wdao = new WishListDao();

    List<ProductDto> items = dao.getProductsByCategory(category1, category2, currentPage, 8);

    List<Map<String, Object>> resultList = new ArrayList<>();

    for (ProductDto dto : items) {
        Map<String, Object> map = new HashMap<>();
        map.put("productId", dto.getProductId());
        map.put("productName", dto.getProductName());
        map.put("mainImageUrl", dto.getMainImageUrl());
        map.put("price", dto.getPrice());
        map.put("viewCount", dto.getViewCount());
        map.put("likeCount", dto.getLikeCount());
        map.put("category", dto.getCategory());
        map.put("wish", (memberNum != 0 && wdao.checkWish(memberNum, dto.getProductId())));
        resultList.add(map);
    }

    Gson gson = new Gson();
    String json = gson.toJson(resultList);
    out.print(json);
%>
