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
<title>고객센터/SSY쇼핑몰</title>


</head>
<body>
	
	<!-- 등록 모달창 -->
	<div class="modal fade" id="boardModal" tabindex="-1"
		aria-labelledby="boardModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<form id="boardForm">
					<div class="modal-header" style="background: #e3f2fd;">
						<h5 class="modal-title" id="boardModalLabel">게시글 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="닫기"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="type" class="form-label fw-bold">게시판 종류</label> <select
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
					</div>
					<div class="modal-footer" style="background: #e3f2fd;">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS (이미 포함되어 있다면 중복 추가 X) -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 예시: 폼 제출 시 ajax로 데이터 전송 (실제 구현에 맞게 수정) -->
	<script>
		$("#boardForm").on("submit", function(e) {
			e.preventDefault();
			// 데이터 수집
			const data = {
				type : $("#type").val(),
				title : $("#title").val(),
				text : $("#text").val()
			};
			// ajax로 서버에 전송 (예시)
			$.ajax({
				url : "insertBoardList.do",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(res) {
					alert("등록 완료!");
					location.reload();
				},
				error : function() {
					alert("등록 실패!");
				}
			});
		});
	</script>
</body>
</html>
