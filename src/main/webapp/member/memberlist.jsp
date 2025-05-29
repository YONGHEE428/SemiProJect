<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
   function delfunc(num){
	   var yes=confirm("정말 강퇴처리하시겠어요?");
	   if(yes)
		   location.href="member/memberdelete.jsp?num="+num;
   }
</script>
</head>
<%
   //전체멤버 가져오기
   MemberDao dao=new MemberDao();
   List<MemberDto> list=dao.getAllMembers();
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
   int no=1;
%>
<body>
<div  style="margin: 100px 100px; width: 900px;">
   <table class="table table-bordered">
      <tr class="table-success">
        <th width="100">번호</th>
        <th width="150">이름</th>
        <th width="150">아이디</th>
        <th width="200">이메일</th>
        <th width="200">가입일</th>
        <th width="200">비고</th>
       
      </tr>
      <%
        for(MemberDto dto:list)
        {%>
        	<tr align="center">
        	  <td><%=no++ %></td>
        	  <td><%=dto.getName() %></td>
        	  <td><%=dto.getId() %></td>
        	  <td><%=dto.getEmail() %></td>
        	  <td><%=sdf.format(dto.getGaipday()) %></td>
        	  <td><button type="button" class="btn btn-danger btn-sm"
        	  onclick="delfunc('<%=dto.getNum()%>')">강퇴</button></td>
        	</tr>
        <%}
      %>
   </table>
</div>
</body>
</html>