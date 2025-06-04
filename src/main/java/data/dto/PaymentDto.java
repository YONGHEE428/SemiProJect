package data.dto;

import java.sql.Timestamp;

public class PaymentDto {
    private String idx;
    private String imp_uid;        // 아임포트 결제 고유번호
    private String merchant_uid;    // 주문번호
    private String member_num;      // 회원번호
    private int amount;            // 결제금액
    private String addr;
    private String delivery_msg;
    private String status;         // 결제상태
    private Timestamp paymentday;   // 결제일시
    
    // Getters and Setters
    public String getIdx() {
        return idx;
    }
    public void setIdx(String idx) {
        this.idx = idx;
    }
    public String getImp_uid() {
        return imp_uid;
    }
    public void setImp_uid(String imp_uid) {
        this.imp_uid = imp_uid;
    }
    public String getMerchant_uid() {
        return merchant_uid;
    }
    public void setMerchant_uid(String merchant_uid) {
        this.merchant_uid = merchant_uid;
    }
    public String getMember_num() {
        return member_num;
    }
    public void setMember_num(String member_num) {
        this.member_num = member_num;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Timestamp getPaymentday() {
        return paymentday;
    }
    public void setPaymentday(Timestamp paymentday) {
        this.paymentday = paymentday;
    }
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDelivery_msg() {
		return delivery_msg;
	}
	public void setDelivery_msg(String delivery_msg) {
		this.delivery_msg = delivery_msg;
	}
}