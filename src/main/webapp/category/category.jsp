<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Main</title>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <style>
		.alldiv {
			background-color: #f4f4f4;
		}
        /* Product grid */
        .product-card {
            border: 0px solid #ddd;
            margin-bottom: 30px;
            transition: transform 0.2s;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            cursor: pointer;
      		filter: brightness(70%);
      		transition: 0.3s ease;
        }
        
        .product-image {
            height: 200px;
            object-fit: cover;
        }
        
        .product-info {
            padding: 15px;
        }
        
        .product-title {
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        
        .product-price {
            font-weight: bold;
            color: #333;
        }
        
        /* User menu */
        .user-menu .btn {
            margin: 0 5px;
            font-size: 0.9rem;
        }
        
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
        
        .main-category ul {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        .main-category li {
         position: relative;
            padding: 15px 30px;
        }
        
        .main-category a {
            text-decoration: none;
            color: black;
            font-size: 20px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .main-category a:hover
         {
            color: #fff;
        }

        .main-category .divider {
            width: 1px;
            margin: 15px 0;
            color: #fff;
        }
        .category-link {   			 
    			color: white;
    			text-shadow: 1px 1px 1px gray;
    			text-decoration: none;
		}
		
		.dropdown {
 		   position: relative;
		}
		.dropdown-menu {
  			 display: none;
    		 opacity: 0;
    		 visibility: hidden;
    		 transition: opacity 0.3s ease;
    		 position: absolute;
    		 top: 100%;
    		 left: 50%; 
		 	 transform: translateX(-50%);  /* 레이어 가운데 수평 정렬 */
		 	
    		 background-color: white;
    		 padding: 10px 20px;
    		 display: flex;
    	  	 flex-direction:column; /* 세로정렬 */
    		 gap: 10px;		/* 아이템간 간격 */
    		 z-index: 999;
    		 box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		}
		.dropdown-menu li {
    		list-style: none;
    		text-align: center;
		}
/* 호버 시 드롭다운 메뉴 보이기 */
		.dropdown:hover > .dropdown-menu {
  			  display: flex;
   			  opacity: 1;
    		  visibility: visible;
		}
		.dropdown-menu a {
   			 text-decoration: none;
    		 font-size: 20px;
    		 font-weight: bold;
    		 color: black;
    		 padding: 10px 20px;
    		 display: block;
    		 transition: background-color 0.2s, color 0.2s;
		}
		.dropdown-menu a:hover{
			background-color: #c9a797;
			border-radius: 20px;
		}
			
    </style>
     <%
	    	String id=(String)session.getAttribute("myid");
	  %>
  <script type="text/javascript">
  $(function () {
	    // 하트 클릭 (동적 요소 대응)
	    $(document).on("click", ".heart", function () {
	        let isFilled = $(this).hasClass("bi-suit-heart-fill");
	        let count = parseInt($(this).text());
		
	        if(id===""){
    			alert("로그인 후 이용해주세요.");
			    location.href="index.jsp?main=login/loginform.jsp";
    		}else{
    			 if (isFilled) {
    		            $(this)
    		                .removeClass("bi-suit-heart-fill")
    		                .addClass("bi-suit-heart")
    		                .css("color", "black")
    		                .text(count - 1);
    		            	
    		        } else {
    		            $(this)
    		                .removeClass("bi-suit-heart")
    		                .addClass("bi-suit-heart-fill")
    		                .css("color", "red")
    		                .text(count + 1);
    		            document.querySelector("#liveToast .toast-body").innerText = "위시리스트에 추가되었습니다!";

    		            const toastLiveExample = document.getElementById('liveToast');
    		            const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample);

    		            toastBootstrap.show();
    		            
    		        }
    		}
	       
	    });

	    // 무한스크롤
	    let page = 1;
	    let isLoading = false;
	    const target = document.getElementById("observerTarget");
	    const observer = new IntersectionObserver(entries => {
	        entries.forEach(entry => {
	            if (entry.isIntersecting && !isLoading) {
	                isLoading = true;
	                loadMoreItems();
	            }
	        });
	    });
	    observer.observe(target);

	    function loadMoreItems() {
	        // 로딩 메시지 보이기
	        document.getElementById("loadingMessage").style.display = "block";

	        $.ajax({
	            type: "GET",
	            dataType: "json",
	            url: "/SemiProject/data/items-page" + page + ".json",
	            success: function(data) {
	                setTimeout(() => {
	                	//새 상품 추가
	                	  const container = document.getElementById("product-list");
	                	  if (!container) {
	                	    console.warn("#product-list 요소가 없습니다.");
	                	    return;
	                	  }
	                    data.forEach(item => {
	                        const el = document.createElement("div");
	                        el.classList.add("col-3");
	                        el.innerHTML =
	                        	 "<div class=\"product-card\" data-product-id=\"" + item.name + "\">" +
	                             "<div class=\"item\">" +
	                               "<img alt=\"\" src=\"/SemiProject" + item.img + "\" class=\"product-image\" style=\"width: 100%; height: 100%;\">" +
	                             "</div>" +
	                             "<div class=\"item-coment\">" +
	                               "<div class=\"item-category\"><b>" + item.category + "</b></div>" +
	                               "<div class=\"item-name\">" + item.name + "</div>" +
	                               "<div class=\"item-price\"><b>" + item.price + "</b></div>" +
	                               "<div class=\"item-heart\"><i class=\"bi bi-suit-heart heart\" style=\"cursor: pointer; color: black;\">" + item.heart + "</i></div>" +
	                             "</div>" +
	                           "</div>";
	                        container.appendChild(el);
	                    });
	                    page++;
	                    isLoading = false;
	                    document.getElementById("loadingMessage").style.display = "none";
	                }, 500);
	            },
	            error: function(xhr, status, error) {
	                console.error("불러오기 실패", error);
	                isLoading = false;
	                document.getElementById("loadingMessage").style.display = "none";
	            }
	        });
	    }
	   
    	const id="<%=id!=null?id:""%>"

	    $("#wishchk").click(function(){
	    		if(id===""){
	    			alert("로그인 후 이용해주세요.");
				    location.href="index.jsp?main=login/loginform.jsp";
	    		}else{
				    location.href="index.jsp?main=category/catewish.jsp";
	    		}
	    });
	    <!-- location.href='index.jsp?main=category/catewish.jsp' -->
	});
 

</script>
    
</head>

<body>
<%
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div class="alldiv">
  <!-- 알림창 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="SemiImg/footerLogo.png" width="20px;" class="rounded me-2" alt="...">
      <strong class="me-auto">!알림</strong>
      <small>Now</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" 
      aria-label="Close"></button>
    </div>
    <div class="toast-body">
      
    </div>
  </div>
</div>
   
   

    <!-- Category Navigation -->
   <!-- 카테고리 -->
<div class="main-category" style="width: 100%; background-color: white; left: 0;">
<div id="selectedCategory" style="text-align:center; font-size: 24px; font-weight: bold; margin-top: 20px;"></div>

   		 <ul>
   		  <li class="dropdown" style="background-color: #c9a797; border-radius: 20px;">
            <a href="index.jsp?main=category/category.jsp" class="category-link">ALL</a>
        </li>
    <li class="divider"></li>  
  <li class="nav-item dropdown">
  <a class="category-link" href="index.jsp?main=category/top.jsp" role="button" >TOP</a>
  <!-- TOP에서 드랍다운 -->
  		<ul class="dropdown-menu">
    		<li><a class="dropdown-item" href="#">티셔츠</a></li>
    		<li><a class="dropdown-item" href="#">아우터</a></li>
    		
  		</ul>
 </li>

        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/bottom.jsp" class="category-link">BOTTOM</a>
            <ul class="dropdown-menu">
                <li><a href="#">팬츠</a></li>
                <li><a href="#">치마</a></li>
                
            </ul>
        </li>
        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/accesories.jsp" class="category-link">ACCESORIES</a>
           
        </li>
       
        <li class="divider"></li>
        <li class="dropdown">
            <a href="index.jsp?main=category/shoes.jsp" class="category-link">SHOES</a>
        </li>
    </ul>
</div>
    <!-- Product Grid -->
    <div class="container my-5">
        <div id="product-list" class="row">
            <!-- Product Card Template - Repeated 16 times (4x4 grid) -->
            <% for(int i = 0; i < 16; i++) { %>
            <div class="col-3">
                <div class="product-card"  data-product-id="<%=i%>">
                    <img src="SemiImg/footerLogo.png" alt="Product Image" class="product-image"
                    style="width: 100%; height: 100%;">
                    <div class="product-info">
                        <div class="product-company"><b>SSY</b></div>
                        <div class="product-name">상품명</div>
                        <div class="product-price"><b>99,000원</b></div>
                        <i class="bi bi-suit-heart heart" id="liveToastBtn"
                        style="cursor: pointer; color: black;">0</i>
                        
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
	
    <!-- Recently Viewed Button -->
 	  <div class="recently-viewed-remote">
    	<button class="remote-btn" title="위로" onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    	<i class="bi bi-caret-up"></i>
    	</button>
        <button class="remote-btn" title="최근 본 상품">
        <i class="bi bi-eye"></i>
        </button>
        <button class="remote-btn" title="위시리스트" id="wishchk">
        <!-- location.href='index.jsp?main=category/catewish.jsp' -->
        <i class="bi bi-heart"></i>
        </button>
        <button	onclick="location.href='http://pf.kakao.com/_XsGSn'" 
					class="counsel-link kakao remote-btn" >
					<img alt="" src="SemiImg/kakao.png" style="width: 135%; height:110%; border-radius: 100%;">
	    </button>
	    <!--window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
	      document.body.scrollHeight 는 문서 전체 높이(스크롤 가능한 최대 높이) 페이지 맨 아래로 부드럽게 이동-->
	    <button class="remote-btn" title="아래로" onclick="window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });">
    	<i class="bi bi-caret-down"></i>
    	</button>
    </div>
	
    <div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
 	<div id="observerTarget"></div>
    
   </div> 
 <script type="text/javascript">
/* 5시방향 메세지 뜨는 트리거 */
const toastTrigger = document.getElementById('liveToastBtn')
const toastLiveExample = document.getElementById('liveToast')

if (toastTrigger) {
  const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
  if(id===""){
	toastBootstrap.hide()	
  }else{
	  toastTrigger.addEventListener('click', () => {
		    toastBootstrap.show()
		  })  
  }
  
}

</script>
</body>
</html>