package data.dto;

public class ProductOptionDto {
	private int optionId;
	private int productId;
	private String color;
	private String size;
	private int stockQuantity;

	public ProductOptionDto() {}

	public ProductOptionDto(int optionId, int productId, String color, String size, int stockQuantity) {
		this.optionId = optionId;
		this.productId = productId;
		this.color = color;
		this.size = size;
		this.stockQuantity = stockQuantity;
	}

	public int getOptionId() {
		return optionId;
	}
	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
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
	public int getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
}
