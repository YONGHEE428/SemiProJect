package data.dto;

import java.sql.Timestamp;

public class CartListDto {
    private String idx;
    private int product_id;
    private String member_id;
    private String cnt;
    private Timestamp writeday;
    private int buyok;
    
    // product 테이블 조인용
    private String product_name;
    private int price;
    private String main_image_url;
    private String description;

    // 옵션 정보 product_option 조인용
    private int option_id;
    private String color; // 옵션 색상
    private String size;  // 옵션 사이즈

    // member 테이블 조인
    private String name;
    private String id;
    private String num;

    // --- getter/setter ---
    public String getIdx() { return idx; }
    public void setIdx(String idx) { this.idx = idx; }

    public int getProduct_id() { return product_id; }
    public void setProduct_id(int product_id) { this.product_id = product_id; }

    public String getMember_id() { return member_id; }
    public void setMember_id(String member_id) { this.member_id = member_id; }

    public String getCnt() { return cnt; }
    public void setCnt(String cnt) { this.cnt = cnt; }

    public Timestamp getWriteday() { return writeday; }
    public void setWriteday(Timestamp writeday) { this.writeday = writeday; }

    public int getBuyok() { return buyok; }
    public void setBuyok(int buyok) { this.buyok = buyok; }

    public String getProduct_name() { return product_name; }
    public void setProduct_name(String product_name) { this.product_name = product_name; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getMain_image_url() { return main_image_url; }
    public void setMain_image_url(String main_image_url) { this.main_image_url = main_image_url; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getOption_id() { return option_id; }
    public void setOption_id(int option_id) { this.option_id = option_id; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNum() { return num; }
    public void setNum(String num) { this.num = num; }
}
