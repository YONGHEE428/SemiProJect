<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .cart-item { border-radius: 15px; border: 1px solid #eee; margin-bottom: 20px; padding: 20px; background: #fff; display: flex; align-items: center; }
        .cart-img { width: 100px; }
        .cart-summary { background: #fafafa; border-radius: 10px; padding: 20px; margin-top: 30px; }
        .cart-btn { background: #ff7e7e; color: #fff; border: none; border-radius: 5px; padding: 10px 30px; }
        .cart-btn:hover { background: #ff5e5e; }
    </style>
</head>
<body>
<div class="container mt-5">
    <!-- 상단 경로 -->
    <div class="mb-3 text-secondary">홈 &gt; 마이페이지 &gt; <b>장바구니</b></div>
    <h2 class="mb-4">장바구니 <span style="font-size:16px; color:#aaa;">ⓘ</span></h2>
    <div class="mb-3">
        <input type="checkbox" id="allCheck"> 전체선택
        <button class="btn btn-outline-secondary btn-sm float-end">선택삭제</button>
    </div>
    <!-- 장바구니 상품 목록 (샘플 2개) -->
    <div class="cart-item">
        <input type="checkbox" class="form-check-input me-3">
        <img src="https://via.placeholder.com/100x120.png?text=상품이미지" class="cart-img me-4">
        <div class="flex-grow-1">
            <div class="fw-bold">[오늘출발] 슬렉스</div>
            <div class="text-secondary" style="font-size:14px;">블랙 / Free</div>
            <div class="text-danger" style="font-size:13px;">특가! 12시간 00분 남음</div>
            <div class="mt-2">
                <span class="badge bg-light text-dark">옵션: 블랙 / Free</span>
                <button class="btn btn-outline-secondary btn-sm ms-2">옵션변경</button>
            </div>
        </div>
        <div class="d-flex align-items-center ms-4">
            <button class="btn btn-outline-secondary btn-sm">-</button>
            <span class="mx-2">1</span>
            <button class="btn btn-outline-secondary btn-sm">+</button>
        </div>
        <div class="ms-4 text-end">
            <div style="text-decoration:line-through; color:#aaa;">15,000원</div>
            <div class="fw-bold" style="font-size:18px;">8,000원</div>
        </div>
        <button class="btn btn-link text-danger ms-3">×</button>
    </div>
    <div class="cart-item">
        <input type="checkbox" class="form-check-input me-3">
        <img src="https://via.placeholder.com/100x120.png?text=상품이미지" class="cart-img me-4">
        <div class="flex-grow-1">
            <div class="fw-bold">[오늘출발] 맨투맨 무지/기본</div>
            <div class="text-secondary" style="font-size:14px;">블랙 / L</div>
            <div class="text-danger" style="font-size:13px;">특가! 12시간 00분 남음</div>
            <div class="mt-2">
                <span class="badge bg-light text-dark">옵션: 블랙 / L</span>
                <button class="btn btn-outline-secondary btn-sm ms-2">옵션변경</button>
            </div>
        </div>
        <div class="d-flex align-items-center ms-4">
            <button class="btn btn-outline-secondary btn-sm">-</button>
            <span class="mx-2">1</span>
            <button class="btn btn-outline-secondary btn-sm">+</button>
        </div>
        <div class="ms-4 text-end">
            <div style="text-decoration:line-through; color:#aaa;">15,000원</div>
            <div class="fw-bold" style="font-size:18px;">8,000원</div>
        </div>
        <button class="btn btn-link text-danger ms-3">×</button>
    </div>
    <!-- 하단 요약 -->
    <div class="cart-summary d-flex justify-content-between align-items-center">
        <div>선택한 상품 <span class="fw-bold">0</span>개 | <span class="fw-bold">0</span>원</div>
        <div>배송비 <span class="fw-bold">0</span>원 <span class="text-secondary">(8만원 이상 무료배송)</span></div>
        <div>총 결제 예상금액 <span class="fw-bold">0</span>원</div>
    </div>
    <div class="mt-4 d-flex gap-3">
        <button class="cart-btn">선택상품 주문하기</button>
        <button class="cart-btn">전체상품 주문하기</button>
    </div>
</div>
</body>
</html>