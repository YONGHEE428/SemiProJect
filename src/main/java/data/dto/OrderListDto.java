// data.dto.OrderListDto.java

package data.dto;

import java.sql.Timestamp;
import java.util.List;

public class OrderListDto {
    private int orderId;            // 주문번호 (orders.order_id)
    private String orderCode;       // 주문번호 (orders.order_code)
    private int memberNum;          // 회원번호 (orders.member_num) - int로 변경
    private Timestamp orderDate;    // 주문일시 (orders.order_date)
    private String orderStatus;     // 주문상태
    private int totalPrice;         // 총 가격
    private List<OrderItem> items;  // 주문된 상품들 리스트    
    private String memberName;

    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public String getOrderCode() {
        return orderCode;
    }
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }
    public int getMemberNum() { // 변경된 getter
        return memberNum;
    }
    public void setMemberNum(int memberNum) { // 변경된 setter
        this.memberNum = memberNum;
    }
    public Timestamp getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    public String getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    public int getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    public List<OrderItem> getItems() {
        return items;
    }
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public static class OrderItem {
        private int productId;      // 상품번호
        private int optionId;       // 옵션번호
        private int cnt;            // 수량
        private int price;          // 가격
        private String productName; // 상품명
        private String productImage;// 상품이미지
        private String color;       // 옵션 색상
        private String size;        // 옵션 사이즈
        private int orderSangpumId;
        
        public int getOrderSangpumId() {
            return orderSangpumId;
        }
        public void setOrderSangpumId(int orderSangpumId) {
            this.orderSangpumId = orderSangpumId;
        }      
        public int getProductId() {
            return productId;
        }
        public void setProductId(int productId) {
            this.productId = productId;
        }
        public int getOptionId() {
            return optionId;
        }
        public void setOptionId(int optionId) {
            this.optionId = optionId;
        }
        public int getCnt() {
            return cnt;
        }
        public void setCnt(int cnt) {
            this.cnt = cnt;
        }
        public int getPrice() {
            return price;
        }
        public void setPrice(int price) {
            this.price = price;
        }
        public String getProductName() {
            return productName;
        }
        public void setProductName(String productName) {
            this.productName = productName;
        }
        public String getProductImage() {
            return productImage;
        }
        public void setProductImage(String productImage) {
            this.productImage = productImage;
        }
        public String getColor() {
            return color;
        }
        public void setColor(String color) {
            this.color = color;
        }
        public String getSize() {
            return size;
        }
        public void setSize(String size) {
            this.size = size;
        }
    }
}