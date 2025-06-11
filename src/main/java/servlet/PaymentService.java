package servlet;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import data.dao.PaymentDao;
import data.dto.PaymentDto;

public class PaymentService {
    private static final String API_KEY = "5774754460286138";
    private static final String API_SECRET = "M5bNRIC2dbTYZQuTSSjcvKWSw0Z1js7SCwRDeySAs7UQYLbxsGKnlZLvSRgZXI48tRwR4OpGRFLweift";
    private PaymentDao dao = new PaymentDao();

    public boolean processPayment(int memberNum, String impUid, String merchantUid, 
            int expectedAmount, String addr, String deliveryMsg) {
    	//1. 토큰발급->내부적으로 https://api.iamport.kr/users/getToken API를 호출 자동발급 
        IamportClient client = new IamportClient(API_KEY, API_SECRET);
        
        try {
        	//2. 결제 정보 조회
            IamportResponse<Payment> response = client.paymentByImpUid(impUid);
            Payment payment = response.getResponse();

            if (payment != null &&
            	// 3. 금액 검증
                payment.getAmount().intValue() == expectedAmount &&
                "paid".equals(payment.getStatus())) {

                // 검증 통과: DB에 저장
                PaymentDto dto = new PaymentDto();
                dto.setImp_uid(impUid);
                dto.setMerchant_uid(merchantUid);
                dto.setMember_num(memberNum);
                dto.setAmount(expectedAmount);
                dto.setAddr(addr);
                dto.setDelivery_msg(deliveryMsg);
                dto.setStatus("paid");

                dao.insertPayment(dto);
                return true;
            } else {
            	  // 검증 실패 시 DB에 실패 기록
                System.out.println("Payment verification failed:");
                System.out.println("Expected amount: " + expectedAmount + ", Actual: " + 
                    (payment != null ? payment.getAmount() : "null"));
                System.out.println("Expected status: paid, Actual: " + 
                    (payment != null ? payment.getStatus() : "null"));
                
                dao.updatePaymentStatus(impUid, "failed");
                return false;
            }
        } catch (Exception e) {
        	 System.err.println("Payment processing error for imp_uid: " + impUid);
             e.printStackTrace();
             dao.updatePaymentStatus(impUid, "error");
             return false;
        }
    }
 // 결제 상태 조회
    public PaymentDto getPaymentByImpUid(String impUid) {
        return dao.getPaymentByImpUid(impUid);
    }
    
    
    // 결제 취소 처리 (필요시)
    public boolean cancelPayment(String impUid, String reason) {
        IamportClient client = new IamportClient(API_KEY, API_SECRET);
        try {
            // 아임포트 결제 취소 API 호출
            // IamportResponse<Payment> response = client.cancelPaymentByImpUid(new CancelData(impUid, true, reason));
            
            // DB에서 상태 업데이트
            dao.updatePaymentStatus(impUid, "cancelled");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}