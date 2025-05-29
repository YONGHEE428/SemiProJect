<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- Bootstrap JS (Popper 포함) CDN 추가 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>고객센터/SSY쇼핑몰 add폼</title>
<script>
	$(function(){
		$("#addform").on("submit",function (e){
			e.preventDefault(); //폼의 기본제출 (새로고침)을 막는 메서드
			console.log(type);
			const data={
				type:$("#type").val(),
				title:$("#title").val(),
				text:$("#text").val()		
			};
			$.ajax({
				url:"addaction.jsp",
				type:"post",
				data:data,
				dataType:"html",
				success:function(res){
					
					alert("등록완료!");
				if(window.opener){
					
					 window.opener.location.reload();
				}
					window.close();
					//opner.location.reload();
				},
				error:function(){
					
					alert("등록실패!");
				}
				
			})
		});
	})
	
}
</script>

</head>
<body>
	<div class="container mt-4">
		<h4 class="mb-4">게시글 등록</h4>
		<form id="addform" action="./addaction.jsp" method="post">
			<div class="mb-3">
				<label for="type" class="form-label fw-bold">게시판 종류</label>
				<select
					class="form-select" id="type" name="type" required>
					<option value="">선택하세요</option>
					<option value="faq">FAQ</option>
					<option value="qna">QnA</option>
					<option value="notice">공지사항</option>
				</select>
			</div>
			<div class="mb-3">
				<label for="title" class="form-label fw-bold">제목</label> <input
					type="text" class="form-control" id="title" name="title"
					maxlength="200" required placeholder="제목을 입력하세요">
			</div>
			<div class="mb-3">
				<label for="text" class="form-label fw-bold">내용</label>
				<textarea class="form-control" id="text" name="text" rows="7"
					required placeholder="내용을 입력하세요"></textarea>
			</div>
			<div class="text-end">
				<button type="button" class="btn btn-secondary"
					onclick="window.close();">취소</button>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</form>
	</div>

</body>
</html>
