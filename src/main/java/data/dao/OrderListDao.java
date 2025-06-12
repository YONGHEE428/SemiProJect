package data.dao;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import data.dto.CartListDto;
import data.dto.OrderListDto;
import data.dto.OrderListDto.OrderItem;
import data.dto.PaymentDto;
import db.copy.DBConnect;

public class OrderListDao {

	DBConnect db = new DBConnect();

	//주문목록 전체 조회 (회원번호 기준)
	public List<OrderListDto> getOrdersByMember(int memberNum) {
		List<OrderListDto> orderList = new ArrayList<>();
		String sql = "SELECT o.*, m.name AS member_name FROM orders o JOIN member m ON o.member_num = m.num WHERE o.member_num=? ORDER BY o.order_id DESC";
		try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberNum);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				OrderListDto order = new OrderListDto();
				order.setOrderId(rs.getInt("order_id"));
				order.setOrderCode(rs.getString("order_code"));
				order.setMemberNum(rs.getInt("member_num"));
				order.setMemberName(rs.getString("member_name"));
				order.setOrderDate(rs.getTimestamp("order_date"));
				order.setOrderStatus(rs.getString("order_status"));
				order.setTotalPrice(rs.getInt("total_price"));
				order.setItems(getOrderItemsByOrderId(rs.getInt("order_id")));
				orderList.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderList;
	}
	// order_sangpum_id로 단일 상품 상세 정보 조회 (주문+상품+옵션+회원)
	public OrderListDto.OrderItem getOrderItemDetailById(int orderSangpumId) {
	    OrderListDto.OrderItem item = null;
	    String sql = "SELECT s.*, o.order_code, o.order_date, o.order_status, o.member_num, m.name AS member_name, " +
	            "p.product_name, p.main_image_url, po.color, po.size " +
	            "FROM order_sangpum s " +
	            "JOIN orders o ON s.order_id = o.order_id " +
	            "JOIN member m ON o.member_num = m.num " +
	            "JOIN product p ON s.product_id = p.product_id " +
	            "JOIN product_option po ON s.option_id = po.option_id " +
	            "WHERE s.order_sangpum_id = ?";
	    try (Connection conn = db.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, orderSangpumId);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            item = new OrderListDto.OrderItem();
	            item.setOrderSangpumId(rs.getInt("order_sangpum_id"));
	            item.setProductId(rs.getInt("product_id"));
	            item.setOptionId(rs.getInt("option_id"));
	            item.setCnt(rs.getInt("cnt"));
	            item.setPrice(rs.getInt("price"));
	            item.setStatus(rs.getString("status"));

	            // 상품 및 주문 정보
	            item.setProductName(rs.getString("product_name"));
	            item.setProductImage(rs.getString("main_image_url"));
	            item.setColor(rs.getString("color"));
	            item.setSize(rs.getString("size"));

	            // 아래는 주문 및 회원 정보도 추가로 넣어둔다 (필요하면)
	            OrderListDto order = new OrderListDto();
	            item.setOrderId(rs.getInt("order_id"));
	            item.setOrderCode(rs.getString("order_code"));
	            item.setOrderDate(rs.getTimestamp("order_date"));
	            item.setOrderStatus(rs.getString("order_status"));
	            item.setMemberNum(rs.getInt("member_num"));
	            item.setMemberName(rs.getString("member_name"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return item;
	}


	//주문상세 조회 (order_code 기준)
	public OrderListDto getOrderDetailByCode(String orderCode) {
		OrderListDto order = null;
		String sql = "SELECT o.*, m.name AS member_name FROM orders o JOIN member m ON o.member_num = m.num WHERE o.order_code=?";
		try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, orderCode);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				order = new OrderListDto();
				order.setOrderId(rs.getInt("order_id"));
				order.setOrderCode(rs.getString("order_code"));
				order.setMemberNum(rs.getInt("member_num"));
				order.setMemberName(rs.getString("member_name"));
				order.setOrderDate(rs.getTimestamp("order_date"));
				order.setOrderStatus(rs.getString("order_status"));
				order.setTotalPrice(rs.getInt("total_price"));
				order.setItems(getOrderItemsByOrderId(rs.getInt("order_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}

    // 4. 주문 생성 (cart → order + order_sangpum 저장)
    public boolean createOrder(int memberNum, List<CartListDto> itemList, String merchantUid) {
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
                insertOrderSQL,
                Statement.RETURN_GENERATED_KEYS
            );
            psOrder.setString(1, merchantUid); // 임시로 null
            psOrder.setInt(2, memberNum); // int로 설정
            psOrder.setInt(3, total);
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new SQLException("주문 ID를 가져오지 못했습니다.");
            }
            // 3. order_sangpum 테이블에 상품들 insert
            psItem = conn.prepareStatement(insertItemSQL);
            for (CartListDto item : itemList) {
                int cnt = Integer.parseInt(item.getCnt());
                int price = item.getPrice() * cnt; // 단가 * 수량


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
			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (psOrder != null)
					psOrder.close();
			} catch (Exception e) {
			}
			try {
				if (psItem != null)
					psItem.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
	}

    // 5. 주문 전체목록 (관리자)
    public List<OrderListDto> getAllOrders() {
        List<OrderListDto> list = new ArrayList<>();
        String sql = "SELECT o.*, m.name AS member_name FROM orders o JOIN member m ON o.member_num = m.num ORDER BY o.order_date DESC";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderListDto dto = new OrderListDto();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setOrderCode(rs.getString("order_code"));
                dto.setMemberNum(rs.getInt("member_num"));
                dto.setMemberName(rs.getString("member_name"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setOrderStatus(rs.getString("order_status"));
                dto.setTotalPrice(rs.getInt("total_price"));
                dto.setItems(getOrderItemsByOrderId(rs.getInt("order_id")));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

			if (n > 0) {
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
   
    

	// 반품창에서 써야하는 id값 조회
	public OrderListDto getOrderDetailByOrderId(int orderId) {
		OrderListDto order = null;
		String sql = "SELECT o.*, m.name AS member_name FROM orders o JOIN member m ON o.member_num = m.num WHERE o.order_id=?";
		try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, orderId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				order = new OrderListDto();
				order.setOrderId(rs.getInt("order_id"));
				order.setOrderCode(rs.getString("order_code"));
				order.setMemberNum(rs.getInt("member_num"));
				order.setMemberName(rs.getString("member_name"));
				order.setOrderDate(rs.getTimestamp("order_date"));
				order.setOrderStatus(rs.getString("order_status"));
				order.setTotalPrice(rs.getInt("total_price"));
				order.setItems(getOrderItemsByOrderId(orderId));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}

	private List<OrderItem> getOrderItemsByOrderId(int orderId) {
	    List<OrderItem> items = new ArrayList<>();
	    String sql = "SELECT s.order_sangpum_id, s.product_id, s.option_id, s.cnt, s.price, " +
	                 "p.product_name, p.main_image_url, o.color, o.size, s.status " + // ★ status 추가
	                 "FROM order_sangpum s " +
	                 "JOIN product p ON s.product_id = p.product_id " +
	                 "JOIN product_option o ON s.option_id = o.option_id " +
	                 "WHERE s.order_id=?";
	    try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, orderId);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            OrderItem item = new OrderItem();
	            item.setOrderSangpumId(rs.getInt("order_sangpum_id"));
	            item.setProductId(rs.getInt("product_id"));
	            item.setOptionId(rs.getInt("option_id"));
	            item.setCnt(rs.getInt("cnt"));
	            item.setPrice(rs.getInt("price"));
	            item.setProductName(rs.getString("product_name"));
	            item.setProductImage(rs.getString("main_image_url"));
	            item.setColor(rs.getString("color"));
	            item.setSize(rs.getString("size"));
	            item.setStatus(rs.getString("status")); // ★ status 세팅
	            items.add(item);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return items;
	}


	// 주문상품 테이블 buyok를 2로 변경                    -반품처리 관련 takeback
	public void updateBuyokToTakeback(int orderSangpumId) {
	    String sql = "UPDATE order_sangpum SET buyok=2 WHERE order_sangpum_id=?";
	    try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, orderSangpumId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 주문 테이블 order_status를 '반품접수'로 변경           -반품처리 관련 takeback
	public void updateOrderStatusToTakeback(int orderId) {
	    String sql = "UPDATE orders SET order_status='반품접수' WHERE order_id=?";
	    try (Connection conn = db.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, orderId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
