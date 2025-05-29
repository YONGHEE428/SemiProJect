<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<htmlasdfaf>
<head>
<meta charset="UTF-8">
<title>Category Main</title>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <style>
        /* Header styles */
        .header {
            padding: 20px 0;
            border-bottom: 1px solid #ddd;
        }
        
        .search-bar {
            width: 440px;
            border-radius: 20px;
        }
        
        /* Category navigation */
        .category-nav {
            padding: 20px 0;
            border-bottom: 1px solid #ddd;
        }
        
        .category-nav .btn {
            width: 120px;
            margin: 0 10px;
        }
        
        /* Product grid */
        .product-card {
            border: 1px solid #ddd;
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
        
        /* Recently viewed */
        .recently-viewed {
            position: fixed;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1000;
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
		}
		.dropdown-menu {
  			display: none;
  			transition: opacity 0.3s ease;
  			opacity: 0;
  			visibility: hidden;
  			margin-top: 0;
		}

/* 호버 시 드롭다운 메뉴 보이기 */
		.dropdown:hover > .dropdown-menu {
  			display: block;
  			opacity: 1;
  			visibility: visible;
  			
		}

/* 오른쪽 토글 화살표 없앰  */
		.category-link.dropdown-toggle::after {
 	 		display: none !important;
		}
		.dropdown-item:hover {
 			color: #fff !important;
 			background-color: darkgray !important;
		}
		
    </style>
    
</head>
<body>
   

    <!-- Category Navigation -->
   <!-- 카테고리 -->
<div class="main-category" style="width: 100%; background-color: white; left: 0;">
    <ul>
  <li class="nav-item dropdown">
  <a class="dropdown-toggle category-link" href="" role="button" data-bs-toggle="dropdown" aria-expanded="false">
    TOP
  </a>
  <!-- TOP에서 드랍다운 -->
  		<ul class="dropdown-menu">
    		<li><a class="dropdown-item" href="index.jsp?main=category/top.jsp">T-shirts</a></li>
    		<li><a class="dropdown-item" href="#">Shirts</a></li>
    		<li><a class="dropdown-item" href="#">Jackets</a></li>
    		<li><a class="dropdown-item" href="#">Outer</a></li>
  		</ul>
 </li>

        <li class="divider"></li>
        <li class="dropdown">
            <a href="#" class="category-link">BOTTOM</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Pants</a></li>
                <li><a class="dropdown-item" href="#">Skirts</a></li>
            </ul>
        </li>
        <li class="divider"></li>
        <li class="dropdown">
            <a href="#" class="category-link">ACCESORIES</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Bags</a></li>
                <li><a class="dropdown-item" href="#">Hats</a></li>
            </ul>
        </li>
        <li class="divider"></li>
        <li class="dropdown">
            <a href="#" class="category-link">JEWELrY</a>
        </li>
        <li class="divider"></li>
        <li class="dropdown">
            <a href="#" class="category-link">SHOES</a>
          
        </li>
    </ul>
</div>
    <!-- Product Grid -->
    <div class="container my-5">
        <div class="row">
            <!-- Product Card Template - Repeated 16 times (4x4 grid) -->
            <% for(int i = 0; i < 16; i++) { %>
            <div class="col-3">
                <div class="product-card" >
                    <img src="SemiImg/footerLogo.png" alt="Product Image" class="product-image"
                    style="width: 100%; height: 100%;">
                    <div class="product-info">
                        <div class="product-company"><b>SSY</b></div>
                        <div class="product-name">상품명</div>
                        <div class="product-price"><b>99,000원</b></div>
                        <i class="bi bi-suit-heart">0</i>
                        
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Recently Viewed Button -->
    <div class="recently-viewed">
        <button class="btn btn-outline-dark">최근 본 상품</button>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>