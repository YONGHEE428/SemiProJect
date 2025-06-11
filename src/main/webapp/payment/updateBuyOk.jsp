<%@page import="data.dao.PaymentDao"%>
<%@page import="data.dto.PaymentDto"%>
<%@page import="data.dao.CartListDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // *** 중요: 파라미터 읽기 전에 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 이 JSP 파일은 AJAX 요청으로 호출되므로, 직접 접근 시 처리 필요 (선택 사항이지만 좋은 습관)
    if (request.getMethod().equalsIgnoreCase("GET")) {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST 방식만 허용됩니다.");
        return;
    }

    // -------------------------------------------------------------
    // 1. 요청 파라미터 받기 및 디버깅
    // -------------------------------------------------------------

    // 모든 파라미터가 정확히 넘어오는지 확인 (디버깅용)
    java.util.Map<String, String[]> params = request.getParameterMap();
    System.out.println("--- updateBuyOk.jsp: Received Parameters ---");
    if (params.isEmpty()) {
        System.out.println("  No parameters received.");
    } else {
        for (String key : params.keySet()) {
            String[] values = params.get(key);
            for (String value : values) {
                System.out.println("  " + key + " = " + value);
            }
        }
    }
    System.out.println("---------------------------------------------");

    // 클라이언트에서 전달받을 결제 관련 정보
    String imp_uid = request.getParameter("imp_uid");        // 아임포트 결제 고유번호
    String merchant_uid = request.getParameter("merchant_uid"); // 주문번호
    String addr = request.getParameter("addr");             // 배송 주소
    String delivery_msg = request.getParameter("delivery_msg"); // 배송 메시지
    String hp = request.getParameter("hp");                 // 연락처
    String status = "paid";                                 // 결제 상태 (성공 시 'paid'로 고정)
    String member_Id = request.getParameter("member_Id"); // member_Id (이것은 session에서 가져온 "myid"입니다.)

    // member_num 파라미터 처리 (가장 중요한 부분)
    String memberNumParam = request.getParameter("member_num");
    Integer member_num = null;

    System.out.println("updateBuyOk.jsp: Raw member_num parameter received = " + memberNumParam);

    // memberNumParam 유효성 검사 및 Integer 변환
    if (memberNumParam != null && !memberNumParam.isEmpty() && !memberNumParam.equals("null")) {
        try {
            member_num = Integer.parseInt(memberNumParam);
            System.out.println("updateBuyOk.jsp: Successfully parsed member_num = " + member_num);
        } catch (NumberFormatException e) {
            System.err.println("updateBuyOk.jsp: member_num 파라미터가 유효한 숫자가 아닙니다: " + memberNumParam + ", Error: " + e.getMessage());
            response.getWriter().write("error:Invalid member_num format");
            return;
        }
    } else {
        System.err.println("updateBuyOk.jsp: member_num 파라미터가 유효하지 않습니다 (null, empty, or 'null' string): " + memberNumParam);
        response.getWriter().write("error:Member number is missing or invalid");
        return; // member_num이 없으면 더 이상 진행하지 않음
    }

    // totalPrice 문자열을 int로 변환
    int amount = 0;
    String totalPriceStr = request.getParameter("totalPrice");
    System.out.println("updateBuyOk.jsp: Raw totalPrice parameter received = " + totalPriceStr);
    if (totalPriceStr != null && !totalPriceStr.trim().isEmpty()) {
        try {
            amount = Integer.parseInt(totalPriceStr);
            System.out.println("updateBuyOk.jsp: Successfully parsed amount = " + amount);
        } catch (NumberFormatException e) {
            System.err.println("updateBuyOk.jsp: totalPrice 변환 오류 - " + e.getMessage());
            response.getWriter().write("error:Invalid total price format");
            return;
        }
    } else {
        System.err.println("updateBuyOk.jsp: totalPrice 파라미터가 누락되었거나 비어있습니다.");
        response.getWriter().write("error:Total price is missing");
        return;
    }

    // -------------------------------------------------------------
    // 2. PaymentDto 객체 생성 및 값 설정
    // -------------------------------------------------------------
    PaymentDto pdto = new PaymentDto();
    pdto.setImp_uid(imp_uid);
    pdto.setMerchant_uid(merchant_uid);
    pdto.setMember_num(member_num); // 이제 이 시점에서는 member_num이 null이 아닐 것입니다.
    pdto.setAmount(amount);
    pdto.setAddr(addr);
    pdto.setDelivery_msg(delivery_msg);
    pdto.setStatus(status);
    pdto.setHp(hp);

    System.out.println("updateBuyOk.jsp: PaymentDto contents before DB insert:");
    System.out.println("  imp_uid: " + pdto.getImp_uid());
    System.out.println("  merchant_uid: " + pdto.getMerchant_uid());
    System.out.println("  member_num: " + pdto.getMember_num());
    System.out.println("  amount: " + pdto.getAmount());
    System.out.println("  addr: " + pdto.getAddr());
    System.out.println("  delivery_msg: " + pdto.getDelivery_msg());
    System.out.println("  status: " + pdto.getStatus());
    System.out.println("  hp: " + pdto.getHp());

    // -------------------------------------------------------------
    // 3. DAO를 사용하여 DB에 데이터 삽입 또는 업데이트
    // -------------------------------------------------------------
    PaymentDao pdao = new PaymentDao();
    CartListDao dao = new CartListDao(); // CartListDao는 여기서 인스턴스 생성

    try {
        // Payment 테이블에 결제 정보 저장
        pdao.insertPayment(pdto);
        System.out.println("updateBuyOk.jsp: 결제 정보가 payment 테이블에 성공적으로 저장되었습니다.");
		
        // 전체상품 주문인지 체크
        String all = request.getParameter("all");
        String idxs = request.getParameter("idxs"); // 개별 선택 상품 주문 시

        if ("true".equals(all)) {
            // 전체상품 주문인 경우
            // session.getAttribute("member_Id")는 보통 String타입 id이므로, DAO 메서드 시그니처와 일치하는지 확인
            String sessionMemberId = (String) session.getAttribute("myid"); // payment.jsp에서 member_Id로 보냄
            if (sessionMemberId != null) {
                dao.markAllAsPurchased(sessionMemberId); // markAllAsPurchased(String memberId) 메서드 사용 가정
                System.out.println("updateBuyOk.jsp: 장바구니 전체 상품(member_Id: " + sessionMemberId + ")이 구매 처리되었습니다.");
            } else {
                System.err.println("updateBuyOk.jsp: 전체 상품 구매 처리 실패 - 세션 member_Id가 null입니다.");
            }
        } else if (idxs != null && !idxs.trim().isEmpty()) {
            // 선택상품 주문인 경우
            String[] idxArray = idxs.split(",");
            List<Integer> idxList = new ArrayList<>();

            for (String idx : idxArray) {
                try {
                    idxList.add(Integer.parseInt(idx.trim())); // 공백 제거 후 파싱
                } catch (NumberFormatException e) {
                    System.err.println("updateBuyOk.jsp: idxs 파라미터 내 유효하지 않은 숫자: " + idx + ", Error: " + e.getMessage());
                }
            }

            if (!idxList.isEmpty()) {
                dao.markAsPurchased(idxList); // markAsPurchased(List<Integer> idxList) 메서드 사용 가정
                System.out.println("updateBuyOk.jsp: 선택된 상품들(idxs: " + idxs + ")이 구매 처리되었습니다.");
            } else {
                System.err.println("updateBuyOk.jsp: 선택 상품 구매 처리 실패 - 유효한 idx가 없습니다.");
            }
        }

        // 모든 처리가 성공했을 경우 "success" 문자열 반환
        response.getWriter().write("success");

    } catch (Exception e) {
        System.err.println("updateBuyOk.jsp: 주문 처리 중 치명적인 오류 발생: " + e.getMessage());
        e.printStackTrace(); // 상세한 스택 트레이스 출력 (디버깅용)
        response.getWriter().write("error:Internal server error during order processing"); // 클라이언트에 오류 응답 반환
    }
%>