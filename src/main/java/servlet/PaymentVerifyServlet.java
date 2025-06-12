package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

//클라이언트가 /payment/verify 경로로 요청할 때 이 서블릿이 동작하도록 설정
//결제 성공 후 아임포트로부터 받은 정보를 서버에서 다시 한 번 검증하고 DB에 저장하는 것입니다.
//이 서블릿은 단순히 "결제 성공" 여부를 클라이언트에 알리는 역할을 합니다.
//여기서 memberNum을 응답 JSON에 포함시키는 것이 좋습니다.
//클라이언트의 processOrder 함수가 이 memberNum을 필요로 할 수 있기 때문
@WebServlet("/payment/verify")

public class PaymentVerifyServlet extends HttpServlet {
    // 서블릿의 버전 번호 설정(1L)
    private static final long serialVersionUID = 1L;
    private final PaymentService service = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 응답 타입을 JSON, 문자 인코딩은 UTF-8로 지정
        response.setContentType("application/json;charset=utf-8");
        
        try {
            
        	 String impUid = request.getParameter("imp_uid");
             String merchantUid = request.getParameter("merchant_uid");
             String amountStr = request.getParameter("amount");
             String addr = request.getParameter("addr");
             String deliveryMsg = request.getParameter("delivery_msg");
             
            // 필수 파라미터 검사
            if (impUid == null || merchantUid == null || amountStr == null) {
                writeJson(response, false, "필수 파라미터가 누락되었습니다.", null); // memberNum 추가
                return;
            }
            
            // 금액 파싱 및 검증
            int amount;
            try {
                amount = Integer.parseInt(amountStr);
                if (amount <= 0) {
                    writeJson(response, false, "유효하지 않은 결제 금액입니다.", null); // memberNum 추가
                    return;
                }
            } catch (NumberFormatException e) {
                writeJson(response, false, "결제 금액이 올바른 숫자 형식이 아닙니다.", null); // memberNum 추가
                return;
            }

            // 세션 검증
            HttpSession session = request.getSession(false);
            if (session == null) {
                writeJson(response, false, "세션이 만료되었습니다. 다시 로그인해주세요.", null); // memberNum 추가
                return;
            }
         // 세션에서 "num" 속성을 String으로 가져옴
            String memberNumStr = (String) session.getAttribute("num");
            Integer memberNum = null; // 초기화

            // null 체크를 먼저 하고, String이 비어있지 않은지 확인 후 숫자로 변환
            if (memberNumStr != null && !memberNumStr.isEmpty()) {
                try {
                    memberNum = Integer.parseInt(memberNumStr);
                } catch (NumberFormatException e) {
                    // 숫자로 변환할 수 없는 경우의 예외 처리
                    writeJson(response, false, "유효하지 않은 회원 번호입니다.", null); // memberNum 추가
                    e.printStackTrace(); // 개발 중에는 로그에 출력하여 원인 파악
                    return;
                }
            }

            // 이후 memberNum이 null인지 검사하는 기존 로직은 그대로 유지
            if (memberNum == null) {
                writeJson(response, false, "로그인이 필요한 서비스입니다.", null); // memberNum 추가
                return;
            }
        

            // XSS 방지를 위한 입력값 정제
            impUid = sanitizeInput(impUid);
            merchantUid = sanitizeInput(merchantUid);
            addr = sanitizeInput(addr);
            deliveryMsg = sanitizeInput(deliveryMsg);
            
            // 결제 검증 처리 및 DB 저장
            boolean isValid = service.processPayment(memberNum, impUid, merchantUid, amount, addr, deliveryMsg);

            if (isValid) {
                writeJson(response, true, "결제가 성공적으로 완료되었습니다.", memberNum); // memberNum 반환
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(response, false, "결제 검증에 실패했습니다.", null); // memberNum 추가
            }
            
        } catch (Exception e) {
        	// 예외 발생 시 서버 로그에 스택 트레이스 출력
            e.printStackTrace();
            // 500 Internal Server Error 상태와 일반 에러 메시지 반환
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(response, false, "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.", null);
        }
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // 특수문자 제거
        return input.replaceAll("[<>\"'&]", "").trim();
    }
 // JSON 형식으로 결과를 작성해 응답 스트림에 출력하는 함수
    @SuppressWarnings("unchecked")
    private void writeJson(HttpServletResponse response, boolean success, String message,Integer memberNum) 
            throws IOException {
        JSONObject json = new JSONObject();
        json.put("status", success ? "success" : "fail");
        json.put("message", message);
        if (memberNum != null) { // memberNum이 있을 경우에만 JSON에 추가
            json.put("memberNum", memberNum);
        }
        response.getWriter().write(json.toString());
       
    }

}