<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 (목데이터 예시)</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body { background: #f8f9fa; }
.order-container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 20px; box-shadow: 0 4px 16px rgba(0,0,0,0.07); padding: 30px; }
.order-title { font-size: 2rem; font-weight: bold; }
.section-title { font-size: 1.2rem; font-weight: bold; margin-top: 30px; }
.table th, .table td { vertical-align: middle; }
</style>
</head>
<body>
<div class="order-container">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <span class="order-title"><i class="bi bi-receipt"></i> 주문 상세</span>
        <a href="#" class="btn btn-outline-secondary btn-sm"><i class="bi bi-list"></i> 주문목록</a>
    </div>
    <!-- 주문 기본 정보 -->
    <div>
        <div class="section-title">주문정보</div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">주문번호</div>
            <div class="col-8">ORD20240619-0001</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">주문일시</div>
            <div class="col-8">2024-06-19 14:23:11</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">주문자</div>
            <div class="col-8">홍길동 (010-1234-5678)</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">주문상태</div>
            <div class="col-8"><span class="badge bg-info">결제완료</span></div>
        </div>
    </div>
    <!-- 상품 목록 -->
    <div>
        <div class="section-title">주문 상품</div>
        <table class="table table-bordered align-middle">
            <thead class="table-light">
                <tr>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>합계</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>나이키 에어맥스 270</td>
                    <td>1</td>
                    <td>159,000원</td>
                    <td>159,000원</td>
                </tr>
                <tr>
                    <td>아디다스 반팔티</td>
                    <td>2</td>
                    <td>29,000원</td>
                    <td>58,000원</td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="3" class="text-end">총 결제금액</th>
                    <th class="text-danger">217,000원</th>
                </tr>
            </tfoot>
        </table>
    </div>
    <!-- 배송 정보 -->
    <div>
        <div class="section-title">배송 정보</div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">수령인</div>
            <div class="col-8">홍길동</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">연락처</div>
            <div class="col-8">010-1234-5678</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">주소</div>
            <div class="col-8">서울특별시 강남구 테헤란로 123, 4층</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">배송메시지</div>
            <div class="col-8">부재시 경비실에 맡겨주세요.</div>
        </div>
    </div>
    <!-- 결제 정보 -->
    <div>
        <div class="section-title">결제 정보</div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">결제수단</div>
            <div class="col-8">신용카드</div>
        </div>
        <div class="row mb-2">
            <div class="col-4 text-secondary">결제상태</div>
            <div class="col-8"><span class="badge bg-success">결제완료</span></div>
        </div>
    </div>
    <!-- 하단 버튼 -->
    <div class="mt-4 text-end">
        <a href="#" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> 목록으로</a>
    </div>
</div>
</body>
</html>