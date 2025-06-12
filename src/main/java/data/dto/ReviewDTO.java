package data.dto;

public class ReviewDTO {
    
	
	private int id;
    private int productId;
    private String memberName;
    private String regdate;
    private String purchaseOption;
    private String satisfactionText;
    private String content;
    private String sizeFit;
    private int height;
    private int weight;
    private String usualSize;
    private String sizeComment;
    private String photoPath;

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getPurchaseOption() {
        return purchaseOption;
    }

    public void setPurchaseOption(String purchaseOption) {
        this.purchaseOption = purchaseOption;
    }

    public String getSatisfactionText() {
        return satisfactionText;
    }

    public void setSatisfactionText(String satisfactionText) {
        this.satisfactionText = satisfactionText;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSizeFit() {
        return sizeFit;
    }

    public void setSizeFit(String sizeFit) {
        this.sizeFit = sizeFit;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public String getUsualSize() {
        return usualSize;
    }

    public void setUsualSize(String usualSize) {
        this.usualSize = usualSize;
    }

    public String getSizeComment() {
        return sizeComment;
    }

    public void setSizeComment(String sizeComment) {
        this.sizeComment = sizeComment;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }
}