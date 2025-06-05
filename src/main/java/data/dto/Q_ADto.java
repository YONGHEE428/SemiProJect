package data.dto;

public class Q_ADto {
	
	    private int inquiryId;
	    private int productId;
	    private String userId;
	    private String title;
	    private String content;
	    private boolean isPrivate;
	    private String password;
	    private String createdAt;
		public int getInquiryId() {
			return inquiryId;
		}
		public void setInquiryId(int inquiryId) {
			this.inquiryId = inquiryId;
		}
		public int getProductId() {
			return productId;
		}
		public void setProductId(int productId) {
			this.productId = productId;
		}
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public boolean isPrivate() {
			return isPrivate;
		}
		public void setPrivate(boolean isPrivate) {
			this.isPrivate = isPrivate;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(String createdAt) {
			this.createdAt = createdAt;
		}

	 
	}

