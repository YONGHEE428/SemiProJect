package data.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class TakebackDto {
    private int takebackId;
    private int orderId;
    private int paymentIdx;
    private int memberNum;
    private String receiverName;
    private String receiverHp;
    private String receiverAddr;
    private int refundAmount;
    private Timestamp returnDate;
    private Date pickupDate;
    private String pickupRequest;
    private String takebackStatus;
    private int orderSangpumId;
  
    public int getOrderSangpumId() { return orderSangpumId; }
    public void setOrderSangpumId(int orderSangpumId) { this.orderSangpumId = orderSangpumId; }
    public int getTakebackId() { return takebackId; }
    public void setTakebackId(int takebackId) { this.takebackId = takebackId; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getPaymentIdx() { return paymentIdx; }
    public void setPaymentIdx(int paymentIdx) { this.paymentIdx = paymentIdx; }
    public int getMemberNum() { return memberNum; }
    public void setMemberNum(int memberNum) { this.memberNum = memberNum; }
    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }
    public String getReceiverHp() { return receiverHp; }
    public void setReceiverHp(String receiverHp) { this.receiverHp = receiverHp; }
    public String getReceiverAddr() { return receiverAddr; }
    public void setReceiverAddr(String receiverAddr) { this.receiverAddr = receiverAddr; }
    public int getRefundAmount() { return refundAmount; }
    public void setRefundAmount(int refundAmount) { this.refundAmount = refundAmount; }
    public Timestamp getReturnDate() { return returnDate; }
    public void setReturnDate(Timestamp returnDate) { this.returnDate = returnDate; }
    public Date getPickupDate() { return pickupDate; }
    public void setPickupDate(Date pickupDate) { this.pickupDate = pickupDate; }
    public String getPickupRequest() { return pickupRequest; }
    public void setPickupRequest(String pickupRequest) { this.pickupRequest = pickupRequest; }
    public String getTakebackStatus() { return takebackStatus; }
    public void setTakebackStatus(String takebackStatus) { this.takebackStatus = takebackStatus; }
}
