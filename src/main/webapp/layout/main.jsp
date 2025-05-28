<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
let page = 1;
let isLoading = false;

$(function() {
  // 최초 로딩
  //loadMoreItems();

  // IntersectionObserver로 감지
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
});

function loadMoreItems() {
	  // 로딩 메시지 보이기
	  document.getElementById("loadingMessage").style.display = "block";

	  $.ajax({
	    type: "GET", // 또는 "POST"
	    dataType: "json",
	    url: "/SemiProject/data/items-page" + page + ".json",
	    success: function(data) {
	      setTimeout(() => {
	        data.forEach(item => {
	          const el = document.createElement("li");
	          el.innerHTML =
	            "<div class=\"item\"><img alt=\"\" src=\"/SemiProject" + item.img + "\"></div>" +
	            "<div class=\"item-coment\">" +
	              "<div class=\"item-category\">" + item.category + "</div>" +
	              "<div class=\"item-name\">" + item.name + "</div>" +
	              "<div class=\"item-price\">" + item.price + "</div>" +
	              "<div class=\"item-heart\"><i class=\"bi bi-heart\"></i>&nbsp; " + item.heart + "</div>" +
	            "</div>";
	          document.querySelector(".main-items ul").appendChild(el);
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


</script>

<style>
	.carousel-item >img{
		max-width: 100%;
		max-height: 50%;
	}
	.main-item{
		width: 100%;
		height: 100%;
		padding: 0 400px;
	}
	.main-items{
  		justify-content: center;
	 	gap : 20px;
		width: 100%;
		height: 70%;
	}
	.main-items >  ul{
		width: 100%;
		 display: flex;
		 flex-wrap: wrap;           /* 줄바꿈 가능하게 */
		 list-style: none;
		 padding: 0;
	
	}
	.main-items >  ul > li{
		width: 20%;
		height: 300px;
		margin-bottom: 50px;
		padding: 5px 5px;
	}
	
	.main-items> ul > li > .item{
		width: 100%;
		height: 60%;
	}
	.main-items> ul > li > .item > img{
		width: 100%;
		height: 100%;
		transition: 0.3s ease;
	}
	.main-items> ul > li > .item-coment{
		width: 100%;
		height: 40%;
	}
	
	.main-LikeItems {
		display: flex;
  		justify-content: center; 
	}
	.main-LikeItems >  ul{
		 width: 100%;
		 display: flex;
		 flex-wrap: wrap;           /* 줄바꿈 가능하게 */      
		 list-style: none;
		 padding: 0;
	
	}
	.main-LikeItems >  ul > li{
		width: 16.66%;
		height: 300px;
		margin-bottom: 50px;
		padding: 5px 5px;
	}
	
	.main-LikeItems> ul > li > .item{
		width: 100%;
		height: 60%;
	}
	.main-LikeItems> ul > li > .item > img{
		width: 100%;
		height: 100%;
		transition: 0.3s ease;
	}
	.main-LikeItems> ul > li > .item-coment{
		width: 100%;
		height: 40%;
	}
	.item-coment > .item-category {
		font-weight: bold;
	}
	.item-coment > .item-name{
		font-size: 0.8em;
		color: gray;
	}
	.item-coment > .item-price{
		margin-top: 10px;
		font-weight: bold;
	}
	.item-coment > .item-heart{
		font-size: 0.8em;
		color: gray;
	}
	.item > img:hover{
		cursor: pointer;
		filter: brightness(70%);
		transition: 0.3s ease;
	}
</style>
<body>
<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel"data-bs-interval="5000">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="SemiImg/test.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="SemiImg/test2.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="SemiImg/test.png" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div><br>
<%String root = request.getContextPath(); %>
<div class="main-item">
  <div class="LikeItem-conttent"><span><strong style="font-size: 1.7em;">Popular Listings</strong><br><b>인기 상품</b></span><br></div>
  <div class="main-LikeItems">
  <ul>
  	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/top/a81.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">TOP</div>
		  	<div class="item-name">스트릿 긴팔크롭티</div>
		  	<div class="item-price">111,000원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 135</div>
		</div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/bottom/c11.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">BOTTOM</div>
		  	<div class="item-name">스트링 지퍼 조거팬츠</div>
		  	<div class="item-price">127,000원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 105</div>
		</div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/hat/a31.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">HAT</div>
		  	<div class="item-name">KOUNTRY 볼캡</div>
		  	<div class="item-price">72,000원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 98</div>
		</div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/outer/e61.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">OUTER</div>
		  	<div class="item-name">STARGIRL 클래식 자켓</div>
		  	<div class="item-price">232,500원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 91</div>
		</div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/top/d81.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">TOP</div>
		  	<div class="item-name">KAPITAL cat 티셔츠</div>
		  	<div class="item-price">147,000원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 74</div>
		</div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/shoes/a71.jpg" ></div>
	  	<div class="item-coment">
	  		<div class="item-category">SHOES</div>
		  	<div class="item-name">TOGA x VANS 콜라보 슈즈</div>
		  	<div class="item-price">211,000원</div>
		  	<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 64</div>
		</div>
  	</li>
 	</ul>
  </div>
 <div class="main-items">
	 <ul>
	 	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/accessory/a1.jpg" ></div>
		  	<div class="item-coment">
		  		<div class="item-category">ACCESSORY</div>
		  		<div class="item-name">KEPANI 스웨터장갑</div>
		  		<div class="item-price">31,000원</div>
		  		<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 25</div>
		  	</div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/bag/a21.jpg" ></div>
		  	<div class="item-coment">
		  		<div class="item-category">BAG</div>
		  		<div class="item-name">로쿠욘 크로스 소형 배낭</div>
		  		<div class="item-price">121,000원</div>
		  		<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 74</div>
		  	</div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/bottom/a11.jpg" ></div>
		  	<div class="item-coment">
		  		<div class="item-category">BOTTOM</div>
		  		<div class="item-name">KAPITAL 데님팬츠</div>
		  		<div class="item-price">440,000원</div>
		  		<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 31</div>
		  	</div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/jewelley/b41.jpg" ></div>
		  	<div class="item-coment">
		  		<div class="item-category">ACCESSORY</div>
		  		<div class="item-name">TOGA 팔찌</div>
		  		<div class="item-price">262,000원</div>
		  		<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 44</div>
		  	</div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/top/e81.jpg" ></div>
		  	<div class="item-coment">
		  		<div class="item-category">TOP</div>
		  		<div class="item-name">GU X UNDERCOVER 콜라보레이션 반팔티</div>
		  		<div class="item-price">352,500원</div>
		  		<div class="item-heart"><i class="bi bi-heart"></i>&nbsp; 98</div>
		  	</div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/bottom/d11.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/top/f81.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/hat/a31.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/bag/c21.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/outer/a61.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/jewelley/c41.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/keyring/a51.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/wallet/a91.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/hat/b31.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="<%=root%>/SemiImg/category/shoes/c71.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  </ul>
 </div> 
 </div>
 <div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
 <div id="observerTarget"></div>
</body>
</html>