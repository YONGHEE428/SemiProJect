<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.CartListDao"%>
<%@ page import="data.dto.CartListDto"%>
<%@ page import="data.dao.ProductOptionDao"%>
<%@ page import="data.dto.ProductOptionDto"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="java.util.HashMap"%> <%-- HashMap 임포트 추가 (원래 코드에는 없었지만 필요) --%>
<%@ page import="java.util.Map"%>   <%-- Map 인터페이스 임포트 (HashMap과 함께 사용) --%>

<%-- 장바구니 수량 업데이트 API --%>

<%
// 1. 응답 설정
// JSON 응답을 위한 Content-Type 및 문자 인코딩 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

// 2. 파라미터 유효성 검사 및 초기화
String idxParam = request.getParameter("idx");
String cntParam = request.getParameter("cnt");

int idx = 0;             // 장바구니 항목 ID
int requestedCnt = 0;    // 클라이언트가 요청한 수량
String message = "success"; // 응답 메시지 상태
int actualCnt = 0;       // 최종적으로 장바구니에 적용될 수량

// idx 파라미터 유효성 검사 및 변환
if (idxParam != null && !idxParam.isEmpty()) {
    try {
        idx = Integer.parseInt(idxParam);
    } catch (NumberFormatException e) {
        message = "error: Invalid idx format";
        System.err.println("[ERROR] " + message + " - Received idx: " + idxParam);
    }
} else {
    message = "error: idx is missing";
    System.err.println("[ERROR] " + message);
}

// cnt 파라미터 유효성 검사 및 변환
if (message.equals("success")) { // idx 파라미터가 유효할 때만 cnt 파라미터 검사
    if (cntParam != null && !cntParam.isEmpty()) {
        try {
            requestedCnt = Integer.parseInt(cntParam);
        } catch (NumberFormatException e) {
            message = "error: Invalid count format";
            System.err.println("[ERROR] " + message + " - Received cnt: " + cntParam);
        }
    } else {
        message = "error: count is missing";
        System.err.println("[ERROR] " + message);
    }
}

// 3. 장바구니 수량 업데이트 로직
if (message.equals("success")) {
    CartListDao cartDao = new CartListDao();
    ProductOptionDao productOptionDao = new ProductOptionDao();

    // 장바구니 항목 조회
    CartListDto cartItem = cartDao.getCartItemByIdx(idx);

    if (cartItem != null) {
        int optionId = cartItem.getOption_id();
        // 상품 옵션(재고) 정보 조회
        ProductOptionDto productOption = productOptionDao.getProductOptionById(optionId);

        if (productOption != null) {
            int stockQuantity = productOption.getStockQuantity();

            // 요청 수량과 재고 수량 비교 및 조정
            if (requestedCnt > stockQuantity) {
                actualCnt = stockQuantity; // 요청 수량이 재고보다 많으면 재고 수량으로 조정
                message = "limited_by_stock"; // 재고 제한 메시지
                System.out.println("[INFO] 재고 초과: 요청 수량 " + requestedCnt + ", 재고 수량 " + stockQuantity + " (cart_idx: " + idx + ")");
            } else if (requestedCnt <= 0) {
                actualCnt = 1; // 최소 수량 1로 조정 (0 이하 요청 시)
                message = "min_count_one"; // 최소 수량 1 메시지
                System.out.println("[INFO] 수량 0 이하 요청: 요청 수량 " + requestedCnt + ", 최소 수량 1로 조정 (cart_idx: " + idx + ")");
            } else {
                actualCnt = requestedCnt; // 재고 범위 내이면 요청 수량 그대로 사용
            }
        } else {
            // 상품 옵션 정보를 찾을 수 없을 경우 (예: 삭제된 옵션)
            actualCnt = requestedCnt; // 재고 확인 없이 요청 수량 그대로 사용
            message = "no_option_info"; // 옵션 정보 없음 메시지
            System.err.println("[WARNING] Product option info not found for option_id " + optionId + " (cart_idx: " + idx + "). Skipping stock check.");
        }

        // 데이터베이스에 장바구니 수량 업데이트
        cartDao.updateCnt(idx, actualCnt);

    } else {
        // 장바구니 항목을 찾을 수 없는 경우
        message = "error: Cart item not found";
        System.err.println("[ERROR] " + message + " - cart_idx: " + idx);
    }
}

// 4. JSON 응답 생성 및 출력
Gson gson = new Gson();
Map<String, Object> responseMap = new HashMap<>(); // Map 인터페이스 사용 권장 (다형성)

responseMap.put("message", message);
responseMap.put("actualCnt", actualCnt);

// JSON 문자열로 변환하여 클라이언트에 출력
out.print(gson.toJson(responseMap));
out.flush(); // 버퍼 비우기
%>