package data.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

public class ProductDto{
	private int productId;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getViewCount() {
		return viewCount;
	}
	public void setViewCount(String viewCount) {
		this.viewCount = viewCount;
	}
	public String getLikeCount() {
		return likeCount;
	}
	public void setLikeCout(String likeCount) {
		this.likeCount = likeCount;

	}
	public Timestamp getRegisteredAt() {
		return registeredAt;
	}
	public void setRegisteredAt(Timestamp registeredAt) {
		this.registeredAt = registeredAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	private String productName;
	private BigDecimal price;
	
	public String getMainImageUrl() {
		return mainImageUrl;
	}
	public void setMainImageUrl(String mainImageUrl) {
		this.mainImageUrl = mainImageUrl;
	}
	
	private String mainImageUrl;
	private String description;
	private String category;
	private String viewCount;
	private String likeCount;
	private Timestamp registeredAt;
	private Timestamp updatedAt;
	private List<ProductOptionDto> options;

	public ProductDto() {
		this.options = new ArrayList<>();
	}

	public List<ProductOptionDto> getOptions() {
		return options;
	}

	public void setOptions(List<ProductOptionDto> options) {
		this.options = options;
	}
}

