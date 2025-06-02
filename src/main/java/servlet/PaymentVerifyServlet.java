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

@WebServlet("/payment/verify")
public class PaymentVerifyServlet extends HttpServlet {
	
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 세션에서 회원 정보 가져오기
        HttpSession session = request.getSession();
        String memberNum = (String) session.getAttribute("member_num");
        
        // 결제 정보 가져오기
        String impUid = request.getParameter("imp_uid");
        String merchantUid = request.getParameter("merchant_uid");
        int amount = Integer.parseInt(request.getParameter("amount"));
        
        PaymentDao dao = new PaymentDao();
        PaymentDto dto = new PaymentDto();
        
        // DTO에 결제 정보 설정
        dto.setImp_uid(impUid);
        dto.setMerchant_uid(merchantUid);
        dto.setMember_num(memberNum);
        dto.setAmount(amount);
        dto.setStatus("paid"); // 초기 상태는 결제 완료
        
        // 결제 정보 저장
        dao.insertPayment(dto);
        
        // 결제 검증
        boolean isValid = dao.verifyPayment(impUid, amount);
        
        response.setContentType("application/json;charset=utf-8");
        if (isValid) {
            response.getWriter().write("{\"status\":\"success\"}");
        } else {
            // 검증 실패 시 상태 업데이트
            dao.updatePaymentStatus(impUid, "failed");
            response.getWriter().write("{\"status\":\"fail\",\"message\":\"Payment verification failed\"}");
        }
    }
}