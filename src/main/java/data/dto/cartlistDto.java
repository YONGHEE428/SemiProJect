package data.dto;

import java.sql.Timestamp;

public class cartlistDto {
	private String idx;
	private String product_id;
	private String member_id;
	private String cnt;
	private Timestamp writeday;
	private int buyok;
	
	
	// product 테이블 조인용
    private String product_name;
    private int price;
    private String main_image;
    private String description;
    private String category;
    
    
    // 옵션 정보 product_option 조인용
    private String option_id; // 옵션 PK
    private String color; // 옵션 색상
    private String size;  // 옵션 사이즈
    
    
    
	public String getOption_id() {
		return option_id;
	}
	public void setOption_id(String option_id) {
		this.option_id = option_id;
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
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	public int getBuyok() {
		return buyok;
	}
	public void setBuyok(int buyok) {
		this.buyok = buyok;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMain_image() {
		return main_image;
	}
	public void setMain_image(String main_image) {
		this.main_image = main_image;
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
    
    

}
