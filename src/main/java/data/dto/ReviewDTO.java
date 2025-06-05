package data.dto;

public class ReviewDTO {

	private int reviewId;
    private String memberName;
    private String purchaseOption;
    private String content;
    private String satisfactionText;
    private String sizeFit;
    private String sizeComment;
    private String height;
    private String weight;
    private String usualSize;
    private String photoPath;
    private String regdate;

    // Getters & Setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public String getPurchaseOption() { return purchaseOption; }
    public void setPurchaseOption(String purchaseOption) { this.purchaseOption = purchaseOption; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getSatisfactionText() { return satisfactionText; }
    public void setSatisfactionText(String satisfactionText) { this.satisfactionText = satisfactionText; }

    public String getSizeFit() { return sizeFit; }
    public void setSizeFit(String sizeFit) { this.sizeFit = sizeFit; }

    public String getSizeComment() { return sizeComment; }
    public void setSizeComment(String sizeComment) { this.sizeComment = sizeComment; }

    public String getHeight() { return height; }
    public void setHeight(String height) { this.height = height; }

    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }

    public String getUsualSize() { return usualSize; }
    public void setUsualSize(String usualSize) { this.usualSize = usualSize; }

    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }

    public String getRegdate() { return regdate; }
    public void setRegdate(String regdate) { this.regdate = regdate; }
}