package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import data.dto.ProductOptionDto;
import db.copy.DBConnect;

public class ProductOptionDao {
    DBConnect db = new DBConnect();

    // optionId로 ProductOptionDto 가져오기
    public ProductOptionDto getProductOptionById(int optionId) {
        ProductOptionDto dto = null;
        String sql = "SELECT * FROM product_option WHERE option_id = ?";

        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, optionId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new ProductOptionDto();
                dto.setOptionId(rs.getInt("option_id"));
                dto.setProductId(rs.getInt("product_id"));
                dto.setColor(rs.getString("color"));
                dto.setSize(rs.getString("size"));
                dto.setStockQuantity(rs.getInt("stock_quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }
} 