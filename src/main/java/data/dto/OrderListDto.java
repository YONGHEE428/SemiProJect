package data.dto;

import java.sql.Timestamp;
import java.util.List;

public class OrderListDto {
	    private int orderId;             // 주문번호 (orders.order_id)
	    private int memberNum;           // 회원번호 (orders.member_num)
	    private Timestamp orderDate;     // 주문날짜
	    private String orderStatus;      // 주문상태
	    private int totalPrice;   // 총 가격

	    private List<OrderItem> items;   // 주문된 상품들 리스트

	    
	    
	    public int getOrderId() {
			return orderId;
		}



		public void setOrderId(int orderId) {
			this.orderId = orderId;
		}



		public int getMemberNum() {
			return memberNum;
		}



		public void setMemberNum(int memberNum) {
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
			private int productId;       // 상품 ID
		    private int optionId;        // 옵션 ID
		    private int cnt;             // 수량
		    private int price;           // 해당 상품 가격(수량 포함)
		    private String productName;  // 상품명
		    private String productImage; // 상품 대표 이미지 (URL 또는 파일명)
		    private String color;        // 옵션 색상
		    private String size;         // 옵션 사이즈
	        
	        
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
			public String getProductName() {
				return productName;
			}
			public void setProductName(String productName) {
				this.productName = productName;
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

	        
	    }
	


}
