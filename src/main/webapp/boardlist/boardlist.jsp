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
<%
    String loginId = (String)session.getAttribute("myid");
    String role = (String)session.getAttribute("role");
%>
<script type="text/javascript">
    var loginId = '<%=loginId%>';
    var role = '<%=role%>';
</script>
<style>
body {
  background: #fafbfc;
  font-family: 'Noto Serif KR', 'Nanum Gothic Coding', sans-serif;
  color: #222;
}
.container {
  max-width: 900px;
}

/* 상단 제목/검색 등 */
.faq-header {
  font-size: 1.6rem;
  font-weight: bold;
  margin-top: 30px;
  margin-bottom: 16px;
  color: #222;
}
.faq-search {
  width: 100%;
  padding: 13px 16px;
  border-radius: 12px;
  border: 1.2px solid #e3e5e8;
  font-size: 1.08rem;
  margin-bottom: 28px;
  background: #f5f6fa;
  color: #222;
}

/* 상단 탭 메뉴 */
.faq-tabs {
  display: flex;
  gap: 8px;
  border-bottom: 1.5px solid #e3e5e8;
  margin-bottom: 18px;
  margin-top: 5px;
}
.faq-tab {
  background: none;
  border: none;
  outline: none;
  color: #888;
  font-weight: 500;
  font-size: 1.09rem;
  padding: 0 14px 13px 14px;
  border-bottom: 2.5px solid transparent;
  cursor: pointer;
  transition: color 0.15s, border-color 0.15s;
}
.faq-tab.active, .faq-tab:focus, .faq-tab:hover {
  color: #222;
  font-weight: 700;
  border-bottom: 2.5px solid #222;
  background: none;
}

/* 서브 필터 버튼 (전체, 교환, 환불 등) */
.faq-filter-group {
  display: flex;
  gap: 8px;
  margin: 10px 0 18px 0;
}
.faq-filter-btn {
  padding: 7px 18px;
  border-radius: 6px;
  border: 1.2px solid #e3e5e8;
  background: #fff;
  color: #333;
  font-weight: 500;
  font-size: 1.02rem;
  cursor: pointer;
  transition: background 0.15s, color 0.15s, border-color 0.15s;
}
.faq-filter-btn.active, .faq-filter-btn:focus {
  background: #222;
  color: #fff;
  border-color: #222;
}

/* 아코디언 리스트 */
.faq-list {
  margin-top: 12px;
  border-radius: 11px;
}
.faq-item {
  border-bottom: 1.1px solid #f1f1f1;
  background: #fff;
  transition: background 0.15s;
}
.faq-item:last-child { border-bottom: none; }
.faq-question {
  padding: 17px 6px 17px 0;
  font-size: 1.07rem;
  font-weight: 500;
  color: #222;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #fff;
}
.faq-question.open {
  font-weight: 700;
  color: #222;
}
.faq-answer {
  display: none;
  background: #fcfcfc;
  padding: 18px 3px 18px 0;
  color: #444;
  font-size: 1.02rem;
  line-height: 1.6;
  border-top: 1px solid #f4f4f4;
}
.faq-question.open + .faq-answer {
  display: block;
}

.faq-tag {
  font-size: 0.97rem;
  color: #bbb;
  margin-right: 12px;
  font-weight: 500;
  letter-spacing: 0.02em;
}

/* 카카오/네이버 브랜드 컬러 버튼 */
.counsel-link.kakao {
  background: #ffe066;
  color: #3d2600;
  border: 1.2px solid #ffe066;
}
.counsel-link.kakao:hover, .counsel-link.kakao:focus {
  background: #ffcd38;
  color: #3d2600;
  border-color: #ffcd38;
}
.counsel-link.naver {
  background: #63e6be;
  color: #034f1a;
  border: 1.2px solid #63e6be;
}
.counsel-link.naver:hover, .counsel-link.naver:focus {
  background: #20c997;
  color: #034f1a;
  border-color: #20c997;
}

/* 일반 상담 버튼 (밝은 톤) */
.counsel-link {
  display: block;
  width: 100%;
  padding: 15px 0;
  margin-bottom: 10px;
  border-radius: 10px;
  font-size: 1.04rem;
  font-weight: 600;
  text-align: center;
  text-decoration: none;
  background: #fff;
  color: #222;
  border: 1.2px solid #e3e5e8;
  transition: background 0.16s, color 0.16s, border-color 0.16s;
}
.counsel-link.phone:hover, .counsel-link.phone:focus {
  background: #222;
  color: #fff;
  border-color: #222;
}
</style>



<script type="text/javascript">
	$(function() {
		
		//add폼 닫히기
		

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
		
		
		
		// 삭제 버튼 클릭 이벤트 (이벤트 위임)
		$(document).on('click', '#btndel', function() {
		    if(!confirm("정말 삭제하시겠습니까?")) return;
		    var idx = $(this).val();
		   
		    $.ajax({
		        url: "boardlist/deleteaction.jsp",
		        type: "post",
		        data: { idx: idx},
		        success: function(res) {
		            alert("삭제가 완료되었습니다.");
		            // 현재 활성화된 탭의 type을 구해서 다시 불러오기
		            var activeType = $('#boardTab .nav-link.active').data('bs-target').replace('#', '');
		            loadboardlist(activeType);
		        },
		        error: function() {
		            alert("삭제에 실패했습니다.");
		        }
		    });
		});
		
		$(document).on('click', '#btnupdate', function() {
		    var idx = $(this).val();
		    window.open("boardlist/updateboardlist.jsp?idx=" + idx, "updatePopup", "width=500,height=600,scrollbars=yes,resizable=yes");
		});

	})
	
	//게시글 목록 보기
	function loadboardlist(type) {
		
				$.ajax({

					url : "boardlist/boardlistajax.jsp",
					type : "get",
					data : {type : type},
					dataType : "json",
					success : function(res) {
						var s = '';
						if (res.length === 0) {
							s = '<div class="text-center text-secondary">등록된 글이 없습니다.</div>';
						} else {
							s += '<div class="accordion" id="'+type+'Accordion">';
							$.each(res,function(i, item) {
								var texts = item.text.replace(/\r?\n/g, "<br>");
												s += '<div class="accordion-item">';
												s += '<h2 class="accordion-header" id="'+type+'Heading'+i+'">';
												s += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#'+type+'Collapse'+i+'">';
												s += '[' + type.toUpperCase()
														+ '] ' + item.title
														+ '</button></h2>';
												s += '<div id="'+type+'Collapse'+i+'" class="accordion-collapse collapse" data-bs-parent="#'+type+'Accordion">';
												s += '<div class="accordion-body">' + texts;
												s += '<div class="mt-3 text-end">';
												if(role === 'admin') {
												    s += '<button class="btn btn-primary btn-sm me-2 edit-btn" value="'+item.idx+'" id="btnupdate">수정</button>';
												    s += '<button class="btn btn-warning btn-sm text-white delete-btn" value="'+item.idx+'" id="btndel">삭제</button>';
												}
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
		var popup=window.open("boardlist/addboardlist.jsp", // 등록 폼 파일명
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
					class="counsel-link kakao">카카오톡 1:1 채팅상담</a> 
					<a href="https://naver.me/FOZJWeYb" target="_blank"
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
						data-bs-target="#qna" type="button" role="tab">자주묻는 QnA</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="notice-tab" data-bs-toggle="tab"
						data-bs-target="#notice" type="button" role="tab">공지사항</button>
				</li>
			</ul>
			<button type="button" class="btn btn-outline-primary ms-3" onclick="openPopup()" 
      		<% if(role == null || !role.equals("admin")) { %> style="display:none;" <% } %>>							
      		글쓰기</button>
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