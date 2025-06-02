package data.dto;

import java.security.Timestamp;

public class ReviewsDto {

	
	private String review_num;
	private String product_num;
	private String  member_num;
	private String member_id;
	private String rating;
	private String content;
	private String height;
	private String weight;
	private String usual_size;
	private Timestamp created_at;
	public String getReview_num() {
		return review_num;
	}
	public void setReview_num(String review_num) {
		this.review_num = review_num;
	}
	public String getProduct_num() {
		return product_num;
	}
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	public String getMember_num() {
		return member_num;
	}
	public void setMember_num(String member_num) {
		this.member_num = member_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getUsual_size() {
		return usual_size;
	}
	public void setUsual_size(String usual_size) {
		this.usual_size = usual_size;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	private String size_fit;
	private String size_comment;

	public String getSize_fit() { return size_fit; }
	public void setSize_fit(String size_fit) { this.size_fit = size_fit; }

	public String getSize_comment() { return size_comment; }
	public void setSize_comment(String size_comment) { this.size_comment = size_comment; }

	
}
