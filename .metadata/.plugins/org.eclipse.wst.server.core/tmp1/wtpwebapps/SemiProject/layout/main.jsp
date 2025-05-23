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
	.main-items{
	 	display: grid;
  		grid-template-columns: repeat(5, 1fr); /* 한 줄에 4개씩 */
  		justify-content: center;
	 	gap : 20px;
		width: 100%;
		height: 70%;
		padding: 0 400px;

	}
	.main-items > .item{
		width: 200px;
		height: 300px;
		margin-bottom: 50px;
		border: 2px solid black;
		padding: 5px 5px;

	}
	.item >img{
	width: 185px;
	height: 200px;
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
  
 <div class="main-items">
 	<div class="item"><img alt="" src="image/쇼핑몰사진/1.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/2.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/3.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/4.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/5.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/6.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/7.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/8.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/9.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/10.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/11.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/12.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/18.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/19.jpg" ></div>
 	<div class="item"><img alt="" src="image/쇼핑몰사진/20.jpg" ></div>
 	
 	
 </div>
</body>
</html>