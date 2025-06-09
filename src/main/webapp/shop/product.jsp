<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <!-- 플레이어가 삽입될 div -->
  <div id="player"></div>

  <!-- 1. IFrame Player API 스크립트 로드 -->
  <script src="https://www.youtube.com/iframe_api"></script>

  <script>
    let player;

    // 2. API가 로드되면 호출되는 함수
    function onYouTubeIframeAPIReady() {
      player = new YT.Player('player', {
        height: '300',
        width: '600',
        // 단일 영상 재생 방법:
        // videoId: 'F2ijaBkDPTc',

        // 플레이리스트 내 특정 영상 재생 방법:
        videoId: 'F2ijaBkDPTc'
      });
    }

    // 플레이어 준비 후 실행되는 함수
    function onPlayerReady(event) {
      // 자동재생을 원하면 아래 주석 해제
      // event.target.playVideo();
    }
  </script>
</body>
</html>
</body>
</html>