<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.math.BigDecimal" %> <%-- Base64 import 제거 --%>
<%-- ======== 실제 프로젝트의 DTO 및 DAO 패키지 경로로 수정하세요. ======== --%>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dto.ProductOptionDto" %>
<%@ page import="data.dao.ProductDao" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 카테고리 목록 정의
    String[] categories = {"전체", "티셔츠", "아우터", "팬츠", "치마", "악세서리", "신발"};
    // 요청 파라미터에서 선택된 카테고리 가져오기
    String selectedCategoryParam = request.getParameter("category");
    String currentCategoryName = (selectedCategoryParam == null || selectedCategoryParam.trim().isEmpty() || "전체".equals(selectedCategoryParam)) ? null : selectedCategoryParam;

    ProductDao productDao = new ProductDao();
    List<ProductDto> productList = null;
    String pageErrorMessage = null;

    try {
        // DAO를 통해 카테고리별 상품 목록 (옵션 포함) 가져오기
        productList = productDao.getProductsWithOptionsByCategory(currentCategoryName);
    } catch (Exception e) {
        e.printStackTrace(); // 콘솔에 오류 로깅
        pageErrorMessage = "상품 목록을 불러오는 중 오류가 발생했습니다. 관리자에게 문의하세요.";
        // pageErrorMessage = "상품 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage(); // 상세 오류(개발시)
    }

    // productList가 null일 경우 빈 리스트로 초기화 (NullPointerException 방지)
    if (productList == null) {
        productList = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 - 상품 목록</title>
    <style>
        /* ... (기존 style 내용) ... */

        /* 새로 추가할 버튼 스타일 */
        .register-btn-container {
            text-align: right; /* 버튼을 오른쪽으로 정렬 */
            margin-bottom: 20px; /* 아래 여백 */
        }
        .register-btn {
            background-color: #28a745; /* 녹색 계열 */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            font-weight: 600;
            transition: background-color 0.2s ease;
            border: none; /* 버튼처럼 보이게 하기 위해 */
            cursor: pointer;
        }
        .register-btn:hover {
            background-color: #218838;
        }
    </style>
    <style>
    
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 20px; background-color: #f8f9fa; color: #212529; }
        .container { max-width: 1200px; margin: auto; background-color: #ffffff; padding: 25px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        h1 { color: #343a40; text-align: center; margin-bottom: 25px; font-weight: 600; }
        .category-nav { margin-bottom: 25px; text-align: center; padding-bottom: 15px; border-bottom: 1px solid #dee2e6;}
        .category-nav a {
            margin: 0 8px;
            padding: 10px 18px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 20px; /* 좀 더 부드러운 형태 */
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }
        .category-nav a:hover, .category-nav a.active {
            background-color: #007bff;
            color: white;
            box-shadow: 0 2px 4px rgba(0,123,255,0.25);
        }
        table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.03); border-radius: 6px; overflow: hidden; }
        th, td { border-bottom: 1px solid #e9ecef; padding: 12px 15px; text-align: left; vertical-align: middle; }
        th { background-color: #6c757d; color: white; font-weight: 600; text-transform: uppercase; font-size: 0.9em; letter-spacing: 0.05em;}
        tr:last-child td { border-bottom: none; }
        tr:nth-child(even) { background-color: #fdfdfe; } /* 매우 연한 배경 */
        tr:hover { background-color: #e9f5ff; } /* 호버 시 연한 파란색 */
        .product-image { width: 60px; height: 60px; border-radius: 4px; object-fit: cover; border: 1px solid #eee; }
        .actions a, .actions button {
            margin-right: 6px; padding: 7px 12px; text-decoration: none; border-radius: 5px; font-size: 0.85em; cursor: pointer; border: none; transition: opacity 0.2s;
        }
        .actions a:hover, .actions button:hover { opacity: 0.85; }
        .edit-btn { background-color: #20c997; color: white; } /* 민트색 계열 */
        .delete-btn { background-color: #e63946; color: white; } /* 부드러운 빨강 */
        .no-data { text-align: center; padding: 30px; color: #6c757d; font-size: 1.1em; }
        .error-message { color: #dc3545; text-align: center; margin-bottom: 20px; font-weight: 500; padding: 10px; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 5px;}
    </style>
    <script>
        function confirmDelete(productId, optionId, productName, optionColor, optionSize) {
            let message = "";
            if (optionId && optionId !== 'null' && optionId !== '') { // optionId가 유효한 값일 때 (null 문자열도 체크)
                message = `상품 '${productName}'의 옵션 (색상: ${optionColor || '-'}, 사이즈: ${optionSize || '-'})을(를) 정말 삭제하시겠습니까?`;
            } else {
                message = `상품 '${productName}' 전체(모든 옵션 포함)를 정말 삭제하시겠습니까?`;
            }

            if (confirm(message)) {
                // ======== 삭제 처리를 위한 URL (실제 환경에 맞게 수정) ========
                let url = '<%= request.getContextPath() %>/sangpumRegist/deleteProductAction.jsp?productId=' + productId;
                if (optionId && optionId !== 'null' && optionId !== '') {
                    url += '&optionId=' + optionId;
                }
                window.location.href = url;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>상품 목록 관리</h1>

        <% if (pageErrorMessage != null) { %>
            <p class="error-message"><%= pageErrorMessage %></p>
        <% } %>
 <div class="register-btn-container">
            <a  href=http://localhost:8080/SemiProject/sangpumRegist/sangpumRegist.jsp class="register-btn">
                <i class="bi bi-plus-circle-fill"></i> 상품 등록
            </a>
        </div>
        <div class="category-nav">
           <% for (String category : categories) { %>
                <a href="<%= request.getContextPath() %>/sangpumRegist/productListAdmin.jsp?category=<%= java.net.URLEncoder.encode(category, "UTF-8") %>"
                   class="<%= ( (currentCategoryName == null && "전체".equals(category)) || category.equals(currentCategoryName) ) ? "active" : "" %>">
                    <%= category %>
                </a>
            <% } %>
        </div>

        <table>
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>상품이름</th>
                    <th>가격</th>
                    <th>카테고리</th>
                    <th>색상</th>
                    <th>사이즈</th>
                    <th>수량</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <% if (productList.isEmpty() && pageErrorMessage == null) { %>
                    <tr>
                        <td colspan="8" class="no-data">해당 카테고리에 표시할 상품이 없습니다.</td>
                    </tr>
                <% } else { %>
                    <% for (ProductDto product : productList) { %>
                        <% List<ProductOptionDto> options = product.getOptions(); %>
                        <% String imageUrl = product.getMainImageUrl(); %> <%-- URL을 직접 가져옵니다. --%>
                        
                        <% if (options != null && !options.isEmpty()) { // 옵션이 있는 경우, 각 옵션별로 행 생성 %>
                            <% for (ProductOptionDto option : options) { %>
                                <tr>
                                    <td>
                                        <% if (imageUrl != null && !imageUrl.trim().isEmpty()) { %> <%-- URL이 유효한지 확인 --%>
                                            <img src="<%= imageUrl %>" alt="<%= product.getProductName() %>" class="product-image">
                                        <% } else { %>
                                            <span>No Image</span>
                                        <% } %>
                                    </td>
                                    <td><%= product.getProductName() != null ? product.getProductName() : "-" %></td>
                                    <td><%= product.getPrice() != null ? product.getPrice().toPlainString() + " 원" : "-" %></td>
                                    <td><%= product.getCategory() != null ? product.getCategory() : "-" %></td>
                                    <td><%= option.getColor() != null ? option.getColor() : "-" %></td>
                                    <td><%= option.getSize() != null ? option.getSize() : "-" %></td>
                                    <td><%= option.getStockQuantity() %></td>
                                    <td class="actions">
                                        <%-- ======== 수정 페이지 URL (실제 환경에 맞게 수정) ======== --%>
                                        <a href="<%= request.getContextPath() %>/sangpumRegist/productModify.jsp?productId=<%= product.getProductId() %>&optionId=<%= option.getOptionId() %>" class="edit-btn">수정</a>
                                        <button onclick="confirmDelete('<%= product.getProductId() %>', '<%= option.getOptionId() %>', '<%= product.getProductName() %>', '<%= option.getColor() %>', '<%= option.getSize() %>')" class="delete-btn">삭제</button>
                                    </td>
                                </tr>
                            <% } // 옵션 루프 끝 %>
                        <% } else { // 옵션이 없는 상품의 경우, 상품 정보만 한 줄로 표시 %>
                            <tr>
                                <td>
                                    <% if (imageUrl != null && !imageUrl.trim().isEmpty()) { %> <%-- URL이 유효한지 확인 --%>
                                        <img src="<%= imageUrl %>" alt="<%= product.getProductName() %>" class="product-image">
                                    <% } else { %>
                                        <span>No Image</span>
                                    <% } %>
                                </td>
                                <td><%= product.getProductName() != null ? product.getProductName() : "-" %></td>
                                <td><%= product.getPrice() != null ? product.getPrice().toPlainString() + " 원" : "-" %></td>
                                <td><%= product.getCategory() != null ? product.getCategory() : "-" %></td>
                                <td>-</td> <%-- 색상 --%>
                                <td>-</td> <%-- 사이즈 --%>
                                <td>-</td> <%-- 수량 --%>
                                <td class="actions">
                                    <a href="<%= request.getContextPath() %>/sangpumRegist/productModify.jsp?productId=<%= product.getProductId() %>" class="edit-btn">수정</a>
                                    <button onclick="confirmDelete('<%= product.getProductId() %>', null, '<%= product.getProductName() %>', null, null)" class="delete-btn">삭제</button>
                                </td>
                            </tr>
                        <% } // 옵션 유무 분기 끝 %>
                    <% } // 상품 루프 끝 %>
                <% } // 상품 목록 유무 분기 끝 %>
            </tbody>
        </table>
    </div>
</body>
</html>