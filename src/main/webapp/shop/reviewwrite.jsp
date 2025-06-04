<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <style>
        .review-container {
            width: 400px;
            max-height: 600px;
            overflow-y: scroll;
            padding: 20px;
            margin: 0 auto;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .review-container input, 
        .review-container textarea,
        .review-container select,
        .review-container button {
            width: 100%;
            margin: 10px 0;
            padding: 10px;
            border-radius: 4px;
        }

        .star-rating {
            font-size: 20px;
            color: gold;
        }
    </style>
</head>
<body>
<div class="review-container">
  <form action="${pageContext.request.contextPath}/submitReview.do" method="post">
        <p><strong>${memberName} 고객님</strong>, 구매하신 상품은 어떠셨나요?</p>

        
        <label>리뷰 작성란</label>
        <textarea name="content" placeholder="리뷰를 남겨주세요."></textarea>

        <label>만족도</label>
        <select name="rating">
            <option value="5">아주 좋아요 ★★★★★</option>
            <option value="4">좋아요 ★★★★</option>
            <option value="3">보통 ★★★</option>
            <option value="2">별로예요 ★★</option>
            <option value="1">별로예요 ★</option>
        </select>

        <label>사이즈 어땠나요?</label>
        <div>
            <input type="radio" name="size_fit" value="많이 작아요"> 많이 작아요
            <input type="radio" name="size_fit" value="조금 작아요"> 조금 작아요
            <input type="radio" name="size_fit" value="잘 맞아요"> 잘 맞아요
            <input type="radio" name="size_fit" value="조금 커요"> 조금 커요
            <input type="radio" name="size_fit" value="많이 커요"> 많이 커요
        </div>

        <label>사이즈 한줄평</label>
        <input type="text" name="size_comment" />

        <label>키</label>
        <input type="text" name="height" />

        <label>몸무게</label>
        <input type="text" name="weight" />

        <label>평소 사이즈 - 상의</label>
        <div>
            <input type="radio" name="usual_size" value="XS"> XS
            <input type="radio" name="usual_size" value="S"> S
            <input type="radio" name="usual_size" value="M"> M
            <input type="radio" name="usual_size" value="L"> L
            <input type="radio" name="usual_size" value="XL"> XL
            <input type="radio" name="usual_size" value="2XL"> 2XL
        </div>

        <button type="submit">리뷰 작성하고 적립금 받기</button>
    </form>
</div>
</body>
</html>
</body>
</html>