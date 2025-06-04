<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
     /* 리모컨 */
        .recently-viewed-remote {
		   	position: fixed;
		    right: 10px;
		    top: 50%;
		    transform: translateY(-50%);
		    display: flex;
		    flex-direction: column;
		    gap: 15px;
		    z-index: 1100;
		}
		
		.remote-btn {
		    background-color: #fff;
		    border: 1px solid #ccc;
		    border-radius: 50%;
		    width: 50px;
		    height: 50px;
		    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: #333;
		    font-size: 24px;
		    transition: background-color 0.3s, color 0.3s;
		}
		
		.remote-btn:hover {
		    background-color: #c9a797;  /* 카테고리 bg 색 참고 */
		    color: white;
		    box-shadow: 0 6px 12px rgba(0,0,0,0.3);
		}
</style>

</head>
<body>
	
	 <!-- 컨트롤러 -->
 	  <div class="recently-viewed-remote">
    	<button class="remote-btn" title="위로" onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    	<i class="bi bi-caret-up" style="font-size: 20px;"></i>
    	</button>
        <button class="remote-btn" title="최근 본 상품">
        <i class="bi bi-eye"></i>
        </button>
        <button class="remote-btn" title="위시리스트" id="wishchk">
        <!-- location.href='index.jsp?main=category/catewish.jsp' -->
        <i class="bi bi-heart"></i>
        </button>
        <button class="remote-btn" title="장바구니" id="mycart" onclick="location.href='index.jsp?main=cart/cartform.jsp'">
        	<i class="bi bi-cart4" style="font-size: 20px;"></i>
        </button>
        
        <button	onclick="location.href='http://pf.kakao.com/_XsGSn'" 
					class="counsel-link kakao remote-btn" >
					<img alt="" src="SemiImg/kakao.png" style="width: 135%; height:110%; border-radius: 100%;">
	    </button>
	    <!--window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
	      document.body.scrollHeight 는 문서 전체 높이(스크롤 가능한 최대 높이) 페이지 맨 아래로 부드럽게 이동-->
	    <button class="remote-btn" title="아래로" onclick="window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });">
    	<i class="bi bi-caret-down" style="font-size: 20px;"></i>
    	</button>
    </div>
</body>
</html>