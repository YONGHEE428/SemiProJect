package data.dto;

import java.sql.Timestamp;

public class PaymentDto {
    private String idx; // String 타입으로 유지
    private String imp_uid;        // 아임포트 결제 고유번호
    private String merchant_uid;    // 주문번호
    private int member_num;      // 회원번호
    private int amount;            // 결제금액

    // 새로 추가될 필드: 누적 취소 금액 (payment 테이블의 `cancelled_amount`와 매핑)
    private int cancelled_amount;

    private String addr;
    private String delivery_msg;
	private String status;         // 결제상태
    private Timestamp paymentday;   // 결제일시

    // 새로 추가될 필드: 마지막 환불 처리 일시 (payment 테이블의 `last_refund_date`와 매핑)
    private Timestamp last_refund_date;

    private String hp;             // 연락처

    // --- 기존 필드들에 대한 Getter/Setter ---
    public String getIdx() { // String 타입 유지
		return idx;
	}
	public void setIdx(String idx) { // String 타입 유지
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
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}

    // --- 새로 추가될 필드들에 대한 Getter/Setter ---
    public int getCancelled_amount() {
        return cancelled_amount;
    }

    public void setCancelled_amount(int cancelled_amount) {
        this.cancelled_amount = cancelled_amount;
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

    public Timestamp getLast_refund_date() {
        return last_refund_date;
    }

    public void setLast_refund_date(Timestamp last_refund_date) {
        this.last_refund_date = last_refund_date;
    }

	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
}