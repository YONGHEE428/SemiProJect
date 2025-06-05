package servlet;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import data.dao.PaymentDao;
import data.dto.PaymentDto;

public class PaymentService {
    private static final String API_KEY = "your-api-key";
    private static final String API_SECRET = "your-api-secret";
    private PaymentDao dao = new PaymentDao();

    public boolean processPayment(String memberNum, String impUid, String merchantUid, int expectedAmount) {
        IamportClient client = new IamportClient(API_KEY, API_SECRET);
        try {
            IamportResponse<Payment> response = client.paymentByImpUid(impUid);
            Payment payment = response.getResponse();

            if (payment != null &&
                payment.getAmount().intValue() == expectedAmount &&
                "paid".equals(payment.getStatus())) {

                // 검증 통과: DB에 저장
                PaymentDto dto = new PaymentDto();
                dto.setImp_uid(impUid);
                dto.setMerchant_uid(merchantUid);
                dto.setMember_num(memberNum);
                dto.setAmount(expectedAmount);
                dto.setStatus("paid");

                dao.insertPayment(dto);
                return true;
            } else {
                // 검증 실패 시 DB에 실패 기록
                dao.updatePaymentStatus(impUid, "failed");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            dao.updatePaymentStatus(impUid, "error");
            return false;
        }
    }
}