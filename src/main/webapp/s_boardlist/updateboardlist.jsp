<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="data.dao.boardlistDao"%>
<%@page import="data.dto.boardlistDto"%>
<%
    // 관리자 권한 체크
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
%>
    <script>
        alert("관리자만 수정할 수 있습니다.");
        window.close();
    </script>
<%
        return;
    }
    // 게시글 정보 불러오기
    String idx = request.getParameter("idx");
    boardlistDao dao = new boardlistDao();
    boardlistDto dto = dao.getBoardByIdx(idx); // getBoardByIdx 메서드 필요
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div class="container mt-4">
    <h4 class="mb-4">게시글 수정</h4>
    <form id="updateform" action="updateaction.jsp" method="post">
        <input type="hidden" name="idx" value="<%=dto.getIdx()%>">
        <div class="mb-3">
            <label for="type" class="form-label fw-bold">게시판 종류</label>
            <select class="form-select" id="type" name="type" required disabled>
                <option value="faq" <%=dto.getType().equals("faq") ? "selected" : ""%>>FAQ</option>
                <option value="qna" <%=dto.getType().equals("qna") ? "selected" : ""%>>QnA</option>
                <option value="notice" <%=dto.getType().equals("notice") ? "selected" : ""%>>공지사항</option>
            </select>
            <input type="hidden" name="type" value="<%=dto.getType()%>">
        </div>
        <div class="mb-3">
            <label for="title" class="form-label fw-bold">제목</label>
            <input type="text" class="form-control" id="title" name="title"
                maxlength="200" required value="<%=dto.getTitle()%>">
        </div>
        <div class="mb-3">
            <label for="text" class="form-label fw-bold">내용</label>
            <textarea class="form-control" id="text" name="text" rows="7"
                required><%=dto.getText()%></textarea>
        </div>
        <div class="text-end">
            <button type="button" class="btn btn-secondary" onclick="window.close();">취소</button>
            <button type="submit" class="btn btn-primary">수정</button>
        </div>
    </form>
</div>
<script>
$("#updateform").on("submit", function(e){
    e.preventDefault();
    $.ajax({
        url: "updateaction.jsp",
        type: "post",
        data: $(this).serialize(),
        success: function(res){
            alert("수정 완료!");
            if(window.opener){
                window.opener.location.reload();
            }
            window.close();
        },
        error: function(){
            alert("수정 실패!");
        }
    });
});
</script>
</body>
</html>