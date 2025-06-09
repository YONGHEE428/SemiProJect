package data.dao;

import java.sql.*;
import java.text.SimpleDateFormat;
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
                order.setMemberNum(String.valueOf(memberNum));
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
    public boolean createOrder(String memberNum, List<CartListDto> itemList) {
        String insertOrderSQL = "INSERT INTO orders (order_code, member_num, total_price) VALUES (?, ?, ?)";
        String insertItemSQL = "INSERT INTO order_sangpum (order_id, product_id, option_id, cnt, price) VALUES (?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // 1. 총 주문금액 계산
            int total = 0;
            for (CartListDto item : itemList) {
                int cnt = Integer.parseInt(item.getCnt());
                total += item.getPrice() * cnt;
            }

            int orderId = 0;

            // 2. 일단 order_code를 null로 INSERT (주문코드는 아직 모름)
            psOrder = conn.prepareStatement(
                "INSERT INTO orders (order_code, member_num, total_price) VALUES (?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            psOrder.setString(1, null); // 임시로 null
            psOrder.setString(2, memberNum);
            psOrder.setInt(3, total);
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            String orderCode = "";
            if (rs.next()) {
                orderId = rs.getInt(1);

                // 3. order_id 받아서 주문코드 생성
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                String today = sdf.format(new java.util.Date());
                orderCode = "ORD" + today + "-" + String.format("%05d", orderId);

                // 4. 주문코드 update
                PreparedStatement psUpdate = conn.prepareStatement(
                    "UPDATE orders SET order_code=? WHERE order_id=?"
                );
                psUpdate.setString(1, orderCode);
                psUpdate.setInt(2, orderId);
                psUpdate.executeUpdate();
                psUpdate.close();
            }

            // 5. order_sangpum 테이블에 상품들 insert
            psItem = conn.prepareStatement(insertItemSQL);
            for (CartListDto item : itemList) {
                int cnt = Integer.parseInt(item.getCnt());
                int price = item.getPrice() * cnt;

                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProduct_id());
                psItem.setInt(3, item.getOption_id());
                psItem.setInt(4, cnt);
                psItem.setInt(5, price);
                psItem.addBatch();
            }
            psItem.executeBatch();

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psOrder != null) psOrder.close(); } catch (Exception e) {}
            try { if (psItem != null) psItem.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    // 주문번호로 주문 상세 정보 가져오기
    public OrderListDto getOrderDetailByCode(String orderCode) {
        OrderListDto dto = new OrderListDto();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM orders WHERE order_code=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderCode);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                dto.setOrderId(rs.getInt("order_id"));
                dto.setMemberNum(rs.getString("member_num"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setOrderStatus(rs.getString("order_status"));
                dto.setTotalPrice(rs.getInt("total_price"));

                // 주문 상품 목록 가져오기
                dto.setItems(getOrderItems(orderCode));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return dto;
    }

    // 주문 상품 목록 가져오기
    private List<OrderItem> getOrderItems(String orderCode) {
        List<OrderItem> items = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT s.*, p.product_name, p.main_image, o.color, o.size " +
                    "FROM order_sangpum s " +
                    "JOIN product p ON s.product_id = p.product_id " +
                    "JOIN product_option o ON s.option_id = o.option_id " +
                    "WHERE s.order_id = (SELECT order_id FROM orders WHERE order_code = ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderCode);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                OrderItem item = new OrderItem();
                item.setProductId(rs.getInt("product_id"));
                item.setOptionId(rs.getInt("option_id"));
                item.setCnt(rs.getInt("cnt"));
                item.setPrice(rs.getInt("price"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("main_image"));
                item.setColor(rs.getString("color"));
                item.setSize(rs.getString("size"));

                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return items;
    }

    // 주문 목록 가져오기
    public List<OrderListDto> getAllOrders() {
        List<OrderListDto> list = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                OrderListDto dto = new OrderListDto();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setMemberNum(rs.getString("member_num"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setOrderStatus(rs.getString("order_status"));
                dto.setTotalPrice(rs.getInt("total_price"));

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return list;
    }

    // 주문 삭제
    public boolean deleteOrder(String orderCode) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn.setAutoCommit(false);

            // 1. order_sangpum 테이블에서 삭제 (외래키 제약조건으로 인해 먼저 삭제)
            String sql1 = "DELETE FROM order_sangpum WHERE order_id = (SELECT order_id FROM orders WHERE order_code = ?)";
            pstmt = conn.prepareStatement(sql1);
            pstmt.setString(1, orderCode);
            pstmt.executeUpdate();

            // 2. orders 테이블에서 삭제
            String sql2 = "DELETE FROM orders WHERE order_code = ?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, orderCode);
            int n = pstmt.executeUpdate();

            if(n > 0) {
                conn.commit();
                success = true;
            } else {
                conn.rollback();
            }

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            db.dbClose(pstmt, conn);
        }

        return success;
    }

    public List<OrderListDto> getOrderListByMember(String memberNum) {
        List<OrderListDto> list = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sqlOrders = "SELECT * FROM orders WHERE member_num = ? ORDER BY order_id DESC";

        try {
            pstmt = conn.prepareStatement(sqlOrders);
            pstmt.setString(1, memberNum);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                OrderListDto dto = new OrderListDto();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setOrderCode(rs.getString("order_code"));
                dto.setMemberNum(rs.getString("member_num"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setOrderStatus(rs.getString("order_status"));
                dto.setTotalPrice(rs.getInt("total_price"));

                // 주문 상품 정보 가져오기
                List<OrderListDto.OrderItem> items = getOrderItems(dto.getOrderCode());
                dto.setItems(items);

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return list;
    }

    public boolean createOrderFromDto(OrderListDto order) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn.setAutoCommit(false);

            // 1. 주문 정보 저장
            String insertOrderSQL = "INSERT INTO orders (order_code, member_num, total_price) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertOrderSQL);
            pstmt.setString(1, order.getOrderCode());
            pstmt.setString(2, order.getMemberNum());
            pstmt.setInt(3, order.getTotalPrice());
            pstmt.executeUpdate();

            // 2. 주문 상품 정보 저장
            String insertItemSQL = "INSERT INTO order_sangpum (order_code, product_id, option_id, cnt, price) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertItemSQL);

            for(OrderListDto.OrderItem item : order.getItems()) {
                pstmt.setString(1, order.getOrderCode());
                pstmt.setInt(2, item.getProductId());
                pstmt.setInt(3, item.getOptionId());
                pstmt.setInt(4, item.getCnt());
                pstmt.setInt(5, item.getPrice());
                pstmt.executeUpdate();
            }

            conn.commit();
            success = true;

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            db.dbClose(pstmt, conn);
        }

        return success;
    }
}
