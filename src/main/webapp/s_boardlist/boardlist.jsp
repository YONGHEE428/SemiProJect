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
<style type="text/css">
body {
	font-family: 'Jua', 'Nanum Myeongjo', 'Gamja Flower', sans-serif;
}

.tapboard {
	position: relative;
	width: 100%;
	max-width: 600px;
	height: 300px;
	border-radius: 20px;
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.07);
	margin-bottom: 30px;
}

.nav-tabs .nav-link.active {
	font-weight: 100;
}

.nav-tabs .nav-link {
	font-size: 1.1rem;
	letter-spacing: 1px;
	border-radius: 10px 10px 0 0;
	transition: background 0.2s, color 0.2s;
}

.accordion-button {
	font-size: 1.05rem;
	font-weight: 500;
}

.accordion-item {
	border-radius: 12px;
	margin-bottom: 10px;
	border: 1px solid;
	overflow: hidden;
}

.card {
	border-radius: 20px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	border: none;
}

.tab-content {
	border-radius: 0 0 20px 20px;
}

.info-right {
	position: absolute;
	right: 20px;
	bottom: 20px;
	font-size: 1.1rem;
	font-weight: bold;
}

.counsel-link {
	display: block;
	width: 100%;
	padding: 18px 0;
	margin-bottom: 12px;
	border-radius: 10px;
	font-size: 1.1rem;
	font-weight: bold;
	text-align: center;
	text-decoration: none;
	border: 1px solid #eee;
	transition: box-shadow 0.2s;
}

.counsel-link.kakao {
	background: #fff3cd;
	color: #856404;
	border-color: #ffe69c;
}

.counsel-link.kakao:hover {
	box-shadow: 0 2px 8px #ffe69c55;
}

.counsel-link.naver {
	background: #d1e7dd;
	color: #0f5132;
	border-color: #a3cfbb;
}

.counsel-link.naver:hover {
	box-shadow: 0 2px 8px #a3cfbb55;
}

.counsel-link.phone {
	background: #cfe2ff;
	color: #084298;
	border-color: #9ec5fe;
}

.counsel-link.phone:hover {
	box-shadow: 0 2px 8px #9ec5fe55;
}

.btn btn-outline-primary {
	float: right;
}
</style>
<script type="text/javascript">
	$(function() {

		//탭 클릭 이벤트
		$('#boardTab button[data-bs-toggle="tab"] ').on(
				'shown.bs.tab',
				function(e) {

					var type = $(e.target).attr('data-bs-target').replace('#',
							''); //faq,qna,notice
					loadboardlist(type);
				});

		//페이지 로딩시 FAQ부터 불러오기
		loadboardlist('faq');

	})
	//게시글 목록 보기
	function loadboardlist(type) {
		$
				.ajax({

					url : "boardlistajax.jsp",
					type : "get",
					data : {
						type : type
					},
					dataType : "json",
					success : function(res) {
						var s = '';
						if (res.length === 0) {
							s = '<div class="text-center text-secondary">등록된 글이 없습니다.</div>';
						} else {
							s += '<div class="accordion" id="'+type+'Accordion">';
							$
									.each(
											res,
											function(i, item) {
												s += '<div class="accordion-item">';
												s += '<h2 class="accordion-header" id="'+type+'Heading'+i+'">';
												s += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#'+type+'Collapse'+i+'">';
												s += '[' + type.toUpperCase()
														+ '] ' + item.title
														+ '</button></h2>';
												s += '<div id="'+type+'Collapse'+i+'" class="accordion-collapse collapse" data-bs-parent="#'+type+'Accordion">';
												s += '<div class="accordion-body">'
														+ item.text
												s += '<div class="mt-3 text-end">';
												s += '<button class="btn btn-primary btn-sm me-2 edit-btn" value="'+item.idx+'">수정</button>';
												s += '<button class="btn btn-warning btn-sm text-white delete-btn" value="'+item.idx+'">삭제</button>';
												s += '</div>';
												s += '</div>';
												s += '</div></div>';
											});
							s += '</div>';
						}
						// 탭별 컨텐츠 영역에 출력
						$('#' + type).html(s);
					},
					error : function() {
						$('#' + type)
								.html(
										'<div class="text-danger">데이터를 불러오지 못했습니다.</div>');
					}

				})
	}
	//팝업 오픈
	function openPopup() {
		window.open("addboardlist.jsp", // 등록 폼 파일명
		"boardAddPopup", "width=500,height=600,scrollbars=yes,resizable=yes");
	}
</script>
</head>
<body>
	<div class="container mt-4">
		<div class="row g-3">
			<!-- 왼쪽: 기존 탭/내용 -->
			<div class="col-md-7">
				<ul class="nav nav-tabs" id="centerTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="tab1-tab" data-bs-toggle="tab"
							data-bs-target="#tab1" type="button" role="tab">고객센터</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="tab2-tab" data-bs-toggle="tab"
							data-bs-target="#tab2" type="button" role="tab">입금계좌안내</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="tab3-tab" data-bs-toggle="tab"
							data-bs-target="#tab3" type="button" role="tab">교환/반품주소</button>
					</li>
				</ul>
				<div
					class="tab-content border-bottom border-start border-end p-3 tapboard"
					id="centerTabContent">
					<div class="tab-pane fade show active" id="tab1" role="tabpanel">
						<div>
							<a>월~금 : 09:00 ~ 18:00 | 점심시간 12:00 ~ 13:00</a>
						</div>
						<br> <br>
						<div>
							<b>[토,일,공휴일 휴무]</b>
						</div>
					</div>
					<div class="tab-pane fade" id="tab2" role="tabpanel">
						<b>쌍용은행: 123-1591-3573-11</b> <br> <br> <b>SY BANK:
							159753-08-148820</b> <br> <br> <br>
						<h5>예금주:(주)SSY.COM</h5>
					</div>
					<div class="tab-pane fade" id="tab3" role="tabpanel">
						<h4>주소지</h4>
						<br> <b>서울특별시 강남구 역삼동 역삼로 1 SSY빌딩 (1층)</b> <br> <b>SSY
							쇼핑담당</b>
					</div>
				</div>
			</div>
			<!-- 오른쪽: 상담 링크 박스 -->
			<div class="col-md-5 d-flex flex-column justify-content-start"
				style="margin-top: 110px;">
				<a href="http://pf.kakao.com/_XsGSn" target="_blank"
					class="counsel-link kakao">카카오톡 1:1 채팅상담</a> <a
					href="https://naver.me/FOZJWeYb" target="_blank"
					class="counsel-link naver">네이버 톡 채팅상담</a> <a href="tel:021231234"
					class="counsel-link phone">전화 상담 02-123-1234</a>
			</div>
		</div>

		<!-- FAQ/QnA/공지사항 탭 -->
		<div class="d-flex align-items-center mb-2">
			<ul class="nav nav-tabs flex-grow-1 justify-content-center"
				id="boardTab" role="tablist" style="margin-bottom: 0;">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="faq-tab" data-bs-toggle="tab"
						data-bs-target="#faq" type="button" role="tab">FaQ</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="qna-tab" data-bs-toggle="tab"
						data-bs-target="#qna" type="button" role="tab">QnA</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="notice-tab" data-bs-toggle="tab"
						data-bs-target="#notice" type="button" role="tab">공지사항</button>
				</li>
			</ul>
			<button type="button" class="btn btn-outline-primary  ms-3"
				onclick="openPopup()">글쓰기</button>
		</div>
		<div
			class="tab-content p-4 border-bottom border-start border-end rounded-bottom-4"
			id="boardTabContent" style="min-height: 300px;">
			<div class="tab-pane fade show active" id="faq" role="tabpanel">
				<div class="accordion" id="faqAccordion">
					<div class="accordion-item">
						<h2 class="accordion-header" id="faqtitle">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#faqtext"></button>
						</h2>
						<div id="faqtext" class="accordion-collapse collapse"
							data-bs-parent="#faqAccordion">
							<div class="accordion-body"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="qna" role="tabpanel">
				<div class="accordion" id="qnahead">
					<div class="accordion-item">
						<h2 class="accordion-header" id="qnaHeadingOne">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#qnatext"></button>
						</h2>
						<div id="qnatext" class="accordion-collapse collapse"
							data-bs-parent="#qnaAccordion">
							<div class="accordion-body"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="notice" role="tabpanel">
				<div class="accordion" id="noticetitle">
					<div class="accordion-item">
						<h2 class="accordion-header" id="noticeHeadingOne">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#noticetext">
							</button>
						</h2>
						<div id="noticetext" class="accordion-collapse collapse"
							data-bs-parent="#noticeAccordion">
							<div class="accordion-body"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>