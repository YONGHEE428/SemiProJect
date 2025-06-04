package data.dao;

import java.sql.*;
import java.util.*;

import data.dto.CartListDto;
import data.dto.OrderListDto;
import data.dto.OrderListDto.OrderItem;
import db.copy.DBConnect;

public class OrderListDao {
    DBConnect db = new DBConnect();

    // 1. 회원 주문 내역 조회 (상품정보, 옵션정보 포함)
    public List<OrderListDto> getOrdersByMember(int memberNum) {
        List<OrderListDto> orderList = new ArrayList<>();

        String sqlOrders = "SELECT * FROM orders WHERE member_num = ? ORDER BY order_id DESC";
        String sqlItems =
            "SELECT s.*, p.product_name, p.main_image, o.color, o.size " +
            "FROM order_sangpum s " +
            "JOIN product p ON s.product_id = p.product_id " +
            "JOIN product_option o ON s.option_id = o.option_id " +
            "WHERE s.order_id = ?";

        try (Connection conn = db.getConnection();
             PreparedStatement pstmtOrders = conn.prepareStatement(sqlOrders)) {

            pstmtOrders.setInt(1, memberNum);
            ResultSet rsOrders = pstmtOrders.executeQuery();

            while (rsOrders.next()) {
                OrderListDto order = new OrderListDto();
                int orderId = rsOrders.getInt("order_id");

                order.setOrderId(orderId);
                order.setMemberNum(memberNum);
                order.setOrderDate(rsOrders.getTimestamp("order_date"));
                order.setOrderStatus(rsOrders.getString("order_status"));
                order.setTotalPrice(rsOrders.getInt("total_price"));

                // 주문 상품 목록 조회 (상품명, 이미지, 색상, 사이즈까지 포함)
                List<OrderItem> items = new ArrayList<>();
                try (PreparedStatement pstmtItems = conn.prepareStatement(sqlItems)) {
                    pstmtItems.setInt(1, orderId);
                    ResultSet rsItems = pstmtItems.executeQuery();

                    while (rsItems.next()) {
                        OrderItem item = new OrderItem();
                        item.setProductId(rsItems.getInt("product_id"));
                        item.setOptionId(rsItems.getInt("option_id"));
                        item.setCnt(rsItems.getInt("cnt"));
                        item.setPrice(rsItems.getInt("price"));
                        item.setProductName(rsItems.getString("product_name"));
                        item.setProductImage(rsItems.getString("main_image")); // 상품 이미지
                        item.setColor(rsItems.getString("color"));             // 색상
                        item.setSize(rsItems.getString("size"));               // 사이즈
                        items.add(item);
                    }
                }
                order.setItems(items);
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // 2. 주문 생성 (cart → order + order_sangpum 저장)
    public boolean createOrder(int memberNum, List<CartListDto> itemList) {
        String insertOrderSQL = "INSERT INTO orders (member_num, total_price) VALUES (?, ?)";
        String insertItemSQL = "INSERT INTO order_sangpum (order_id, product_id, option_id, cnt, price) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = db.getConnection()) {
            conn.setAutoCommit(false);

            int total = 0;
            for (CartListDto item : itemList) {
                int cnt = Integer.parseInt(item.getCnt());
                total += item.getPrice() * cnt;
            }

            int orderId = 0;
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, memberNum);
                ps.setInt(2, total);
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
                rs.close();
            }

            try (PreparedStatement ps = conn.prepareStatement(insertItemSQL)) {
                for (CartListDto item : itemList) {
                    int cnt = Integer.parseInt(item.getCnt());
                    int price = item.getPrice() * cnt;

                    ps.setInt(1, orderId);
                    ps.setInt(2, Integer.parseInt(item.getProduct_id()));
                    ps.setInt(3, Integer.parseInt(item.getOption_id()));
                    ps.setInt(4, cnt);
                    ps.setInt(5, price);
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
