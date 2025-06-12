<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>관리자 페이지</title>
    <style>
      body {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
      }
      .button-container {
        display: flex;
        gap: 20px;
        margin-top: 20px;
      }
      .admin-button {
        padding: 15px 30px;
        font-size: 1.2em;
        color: white;
        background-color: #007bff;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        transition: background-color 0.3s ease;
      }
      .admin-button:hover {
        background-color: #0056b3;
      }
    </style>
  </head>
  <body>
    <div class="button-container">
      <a href="productListAdmin.jsp" class="admin-button">상품 관리</a>
      <a href="../member/memberAdmin.jsp" class="admin-button">회원 관리</a>
    </div>
  </body>
</html>
