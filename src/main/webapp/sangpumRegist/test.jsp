<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao"%>
<%@ page import="data.dto.CartListDto"%>
<%@ page import="data.dao.ProductOptionDao"%>
<%@ page import="data.dto.ProductOptionDto"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="java.util.HashMap"%> <%-- HashMap 임포트 추가 (원래 코드에는 없었지만 필요) --%>
<%@ page import="java.util.Map"%>   <%-- Map 인터페이스 임포트 (HashMap과 함께 사용) --%>

<%-- 장바구니 수량 업데이트 API --%>

<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

String idxParam=request.getParameter("idx");
String cntparam=request.getParameter("idx 

int idx=0;
int requestedCnt=0;
String message="success";
int actualCnt=0;

if(idxParam !=null&& idxParam.isEmpty()){
    try{
        idx=Integer.parseInt(idxParam);
    }catch(NumberFormatException e){
        message="error:Invalid idx format";
        System.err.println("[ERROR]"+message+"-Received idx: "+idxParam);
    }
}else{
    message = "error: idx is missing";
}

if(message.equals("sucess")){
    if(cntParam !=null && !cntParam.isEmpty()){
        try{
            requestedCnt =Integer.parseInt(cntParam);
        }catch(NumberFormatException e){
            message="error:Invalid count format";
        }
    }else{
        message="error: cout is missing";
        System.err.println("[ERROR]"+message);
    }
}

if(message.equals("success")){
    CartListDao carDao=new CartListDao();
    PRoductOptionDao
}


if(idxParam)")