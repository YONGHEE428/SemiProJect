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
<body>
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
		height: 250px;
		margin-bottom: 50px;
		border: 2px solid black;
		padding: 5px 5px;
	}
	
	.main-items> ul > li > .item{
		width: 100%;
		height: 60%;
		border: 1px solid red;
	}
	.main-items> ul > li > .item-coment{
		width: 100%;
		height: 40%;
		border: 1px solid blue;
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
		height: 250px;
		margin-bottom: 50px;
		border: 2px solid black;
		padding: 5px 5px;
	}
	
	.main-LikeItems> ul > li > .item{
		width: 100%;
		height: 60%;
		border: 1px solid red;
	}
	.main-LikeItems> ul > li > .item-coment{
		width: 100%;
		height: 40%;
		border: 1px solid blue;
	}
</style>

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
<div class="main-item">
  <div class="LikeItem-conttent"><span><strong style="font-size: 1.7em;">Popular Listings</strong><br><b>인기 상품</b></span><br></div>
  <div class="main-LikeItems">
  <ul>
  	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	<li>
	  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
	  	<div class="item-coment"></div>
  	</li>
 	</ul>
  </div>
 <div class="main-items">
	 <ul>
	 	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  	<li>
		  	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
		  	<div class="item-coment"></div>
	  	</li>
	  </ul>
 </div> 
 </div>
</body>
</html>