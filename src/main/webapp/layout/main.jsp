
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="java.util.List"%>
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
  loadMoreItems();

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
	  document.getElementById("loadingMessage").style.display = "block";

	  $.ajax({
	    type: "GET",
	    dataType: "json",
	    url: "/SemiProject/data/items.jsp?page=" + page,
	    success: function(data) {
	      setTimeout(() => {
	        data.forEach(item => {
	          const el = document.createElement("li");
	          el.innerHTML =
	            "<div class='item'>" +
	              "<a href='/Semiproject/shop/sangpumpage.jsp'>" +
	                "<img src='" + item.mainImageUrl + "' alt=''>" +  // 이미지 경로
	              "</a>" +
	            "</div>" +
	            "<div class='item-coment'>" +
	              "<div class='item-category'>" + item.category + "</div>" +
	              "<div class='item-name'>" + item.productName + "</div>" +
	              "<div class='item-price'>" + formatPrice(item.price) + "</div>" +
	              "<div class='item-heart'>" +
	                "<i class='bi bi-heart'></i>&nbsp; " + item.likeCount + " &nbsp;" +
	                "<i class='bi bi-eye' style='font-size: 16px;'></i>&nbsp; " + item.viewCount +
	              "</div>" +
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

	// 가격 쉼표 찍기용 함수
	function formatPrice(price) {
	  return new Intl.NumberFormat('ko-KR').format(price) + "원";
	}



</script>

<style>
	.carousel-item > img{
		width: 100%;
		height: 100%;

	}
	.eventImg > ul{
		display: flex; 
		gap : 100px;
		padding-left: 0px;
		padding-bottom:100px;
	}
	.eventImg> ul >li{
		width: 100%;
		height: 600px;
	}
	.smalleventimg > a >img{
		width: 100%;
		height: 600px;
	}
	.smalleventimg {
    position: relative;
    display: inline-block;
  }

  .smalleventimg img {
    display: block;
    width: 100%;
    height: auto;
  }

  .hover-text {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    color: white;
    font-size: 1.2em;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none; /* 클릭 이벤트 방해 방지 */
  }

  .smalleventimg:hover .hover-text {
    opacity: 1;
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
		width: 25%;
		height: 400px;
		padding: 5px 5px;
	}
	
	.main-items> ul > li > .item{
		width: 100%;
		height: 60%;
	}
	.main-items> ul > li > .item > a >img{
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
	.main-LikeItems> ul > li > .item > a >img{
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
	
	img:hover{
		cursor: pointer;
		filter: brightness(70%);
		transition: 0.3s ease;
	}
	img.no-hover:hover {
	  filter: none;
	  cursor: pointer;
	  transition: none;
}
</style>
<body>
<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel"data-bs-interval="5000">
  <div class="carousel-inner" style="height: 550px;">
    <div class="carousel-item active">
      <a href="index.jsp?main=category/accesories.jsp"><img src="SemiImg/test.png" class="no-hover d-block w-100" alt="..."></a>
    </div>
    <div class="carousel-item">
      <a href="index.jsp?main=category/accesories.jsp"><img src="SemiImg/test2.png" class="no-hover d-block w-100" alt="..."></a>
    </div>
    <div class="carousel-item">

      <a href="index.jsp?main=category/top.jsp"><img src="SemiImg/test3-1.jpg" class="no-hover d-block w-100" alt="..."></a>
    </div>
    <div class="carousel-item">
      <a href="index.jsp?main=category/category.jsp"><img src="SemiImg/main.png" class="no-hover d-block w-100" alt="..."></a>
    </div>
     <div class="carousel-item">
      <a href="index.jsp?main=category/shoes.jsp"><img src="SemiImg/main2.png" class="no-hover d-block w-100" alt="..."></a>

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

<%	String root = request.getContextPath(); 
	ProductDao dao = new ProductDao();
	List<ProductDto> list = dao.getTopLikedProducts();
%>
<div class="main-item">

  <div class="LikeItem-conttent"><span><strong style="font-size: 1.7em;">Popular Listings</strong><br><b>인기 상품</b></span><br></div>
  <div class="main-LikeItems">
  <ul>
  	<% for (ProductDto dto : list) { %>
<li>
    <div class="item">
        <a href="<%=request.getContextPath()%>/shop/sangpumpage.jsp?product_id=<%=dto.getProductId()%>">
            <img alt="" src="<%=dto.getMainImageUrl()%>">
        </a>
    </div>
    <div class="item-coment">
        <div class="item-category"><%=dto.getCategory()%></div>
        <div class="item-name"><%=dto.getProductName()%></div>
        <div class="item-price"><%=dto.getPrice()%>원</div>
        <div class="item-heart">
            <i class="bi bi-heart"></i>&nbsp; <%=dto.getLikeCount()%> &nbsp;
            <i class="bi bi-eye" style="font-size: 16px;"></i>&nbsp; <%=dto.getViewCount()%>
        </div>
    </div>
</li>
<% } %>
 	</ul>
  </div>
  
  <!-- 광고 -->
  <div class="BigeventTitle"><span><strong>SPOTLIGHT</strong></span></div>
  <div class="Bigeventimg" style="text-align: center;"><a href="#"><img src="<%=root%>/SemiImg/bigeventimg2.jpg" class="no-hover"style="width: 100%;"></a></div>
  <div class="Bigeventcoment" style="padding-bottom: 50px;"><span><strong style="font-size: 1.5em;">#걸즈 올여름 어떤 컬러 티셔츠를 입을래?</strong>
  <br><b style="color:gray;">본격적인 여름이 시작되면 가볍고 시원한 스타일을 찾게 되기 마련이다. 스타일이 단순해질수록 컬러의 존재감은 커진다.<br> 
  티셔츠 컬러만 잘 골라도 룩의 분위기는 물론이고 기분 전환까지 가능하기 때문. 여름을 책임질 컬러 티셔츠 코디, 지금 만나보자.</b></span><br></div>
  
  <div class="SmalleventTitle"><span><strong>Today Hot Pick</strong></span></div>
  <div class="eventImg">
  <ul>
    <li>
      <div class="smalleventimg">
        <a href="<%=root%>/shop/sangpumpage.jsp">
          <img src="<%=root%>/SemiImg/eventimg3.jpg">
          <div class="hover-text"></div>
        </a>
      </div>
      <div class="smalleventcoment">
        <span>
          <strong style="font-size: 1.5em;">[한소희 Pick]</strong><br>
          <b style="color:gray">자연스러운 크롭기장의 반팔티</b>
        </span>
      </div>
    </li>

    <li>
      <div class="smalleventimg">
        <a href="<%=root%>/shop/sangpumpage.jsp">
          <img src="<%=root%>/SemiImg/eventimg5_1.png">
          <div class="hover-text"></div>
        </a>
      </div>
      <div class="smalleventcoment">
        <span>
          <strong style="font-size: 1.5em;">[카리나 Pick]</strong><br>
          <b style="color:gray">빈티지 스트릿을 느낄 수 있는 과감한 데미지 효과</b>
        </span>
      </div>
    </li>
  </ul>
</div>
  
 <!-- 메인 아이템목록 -->
 <div class="main-items">
 <div class="main-item-conttent"><span><strong style="font-size: 1.7em;">We Love</strong><br><b>쌍용 픽</b></span><br></div>
	 <ul>
	 	
	  </ul>
 </div> 
 </div>
 <div id="loadingMessage" style="display:none; text-align:center; padding:10px; font-weight:bold;">로딩중...</div>
 <div id="observerTarget"></div>
</body>
</html>