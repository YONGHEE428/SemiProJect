package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.dao.PaymentDao;
import data.dto.PaymentDto;

import org.json.simple.JSONObject;

//클라이언트가 /payment/verify 경로로 요청할 때 이 서블릿이 동작하도록 설정
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
            // 파라미터 유효성 검사
            String impUid = request.getParameter("imp_uid");
            String merchantUid = request.getParameter("merchant_uid");
            String amountStr = request.getParameter("amount");
            
            // 필수 파라미터 검사
            if (impUid == null || merchantUid == null || amountStr == null) {
                writeJson(response, false, "필수 파라미터가 누락되었습니다.");
                return;
            }
            
            // 금액 파싱 및 검증
            int amount;
            try {
                amount = Integer.parseInt(amountStr);
                if (amount <= 0) {
                    writeJson(response, false, "유효하지 않은 결제 금액입니다.");
                    return;
                }
            } catch (NumberFormatException e) {
                writeJson(response, false, "결제 금액이 올바른 숫자 형식이 아닙니다.");
                return;
            }

            // 세션 검증
            HttpSession session = request.getSession(false);
            if (session == null) {
                writeJson(response, false, "세션이 만료되었습니다. 다시 로그인해주세요.");
                return;
            }

            Integer memberNum = (Integer) session.getAttribute("member_num");
            if (memberNum == null) {
                writeJson(response, false, "로그인이 필요한 서비스입니다.");
                return;
            }

            // XSS 방지를 위한 입력값 정제
            impUid = sanitizeInput(impUid);
            merchantUid = sanitizeInput(merchantUid);

            // 결제 검증 처리
            boolean isValid = service.processPayment(memberNum, impUid, merchantUid, amount);
            
            if (isValid) {
                writeJson(response, true, "결제가 성공적으로 완료되었습니다.");
            } else {
            	  // 검증 실패 시 400 Bad Request 상태와 에러 메시지 전송
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(response, false, "결제 검증에 실패했습니다.");
            }
            
        } catch (Exception e) {
        	// 예외 발생 시 서버 로그에 스택 트레이스 출력
            e.printStackTrace();
            // 500 Internal Server Error 상태와 일반 에러 메시지 반환
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(response, false, "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
        }
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // 특수문자 제거
        return input.replaceAll("[<>\"'&]", "");
    }
 // JSON 형식으로 결과를 작성해 응답 스트림에 출력하는 함수
    @SuppressWarnings("unchecked")
    private void writeJson(HttpServletResponse response, boolean success, String message) 
            throws IOException {
        JSONObject json = new JSONObject();
        json.put("status", success ? "success" : "fail");
        json.put("message", message);
        
        response.getWriter().write(json.toString());
       
    }

}