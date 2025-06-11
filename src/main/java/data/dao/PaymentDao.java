package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.PaymentDto;
import db.copy.DBConnect;


public class PaymentDao {
    DBConnect db = new DBConnect();
    
    // 주문번호로 결제 정보 가져오기
    public PaymentDto getPaymentByOrderCode(String orderCode) {
        PaymentDto dto = new PaymentDto();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, m.hp FROM payment p " +
                    "JOIN member m ON p.member_num = m.num " +
                    "WHERE p.merchant_uid = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderCode);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getInt("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setAddr(rs.getString("addr"));
                dto.setDelivery_msg(rs.getString("delivery_msg"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
                dto.setHp(rs.getString("hp"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        
        return dto;
    }
    
    // 결제 정보 저장
    public void insertPayment(PaymentDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO payment (imp_uid, merchant_uid, member_num, amount, addr, delivery_msg, status, paymentday) VALUES (?,?,?,?,?,?,?,now())";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getImp_uid());
            pstmt.setString(2, dto.getMerchant_uid());
            pstmt.setInt(3, dto.getMember_num());
            pstmt.setInt(4, dto.getAmount());
            pstmt.setString(5, dto.getAddr());
            pstmt.setString(6, dto.getDelivery_msg());
            pstmt.setString(7, dto.getStatus());
            
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }
    
    // 결제 정보 조회
    public PaymentDto getPaymentByImpUid(String imp_uid) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PaymentDto dto = null;
        
        String sql = "SELECT p.*, m.hp FROM payment p " +
                    "JOIN member m ON p.member_num = m.num " +
                    "WHERE p.imp_uid = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, imp_uid);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                dto = new PaymentDto();
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getInt("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setAddr(rs.getString("addr"));
                dto.setDelivery_msg(rs.getString("delivery_msg"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
                dto.setHp(rs.getString("hp"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        
        return dto;
    }
    
    // 결제 상태 업데이트
    public void updatePaymentStatus(String imp_uid, String status) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        
        String sql = "update payment set status=? where imp_uid=?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, imp_uid);
            
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }
    

    // 회원의 결제 내역 조회
    public List<PaymentDto> getMemberPayments(String member_num) {
        List<PaymentDto> list = new ArrayList<PaymentDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, m.hp FROM payment p " +
                    "JOIN member m ON p.member_num = m.num " +
                    "WHERE p.member_num = ? ORDER BY p.paymentday DESC";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member_num);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                PaymentDto dto = new PaymentDto();
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getInt("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setAddr(rs.getString("addr"));
                dto.setDelivery_msg(rs.getString("delivery_msg"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
                dto.setHp(rs.getString("hp"));
                
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        
        return list;
    }
    
    // 결제 검증
    public boolean verifyPayment(String imp_uid, int amount) {
        PaymentDto payment = getPaymentByImpUid(imp_uid);
        if (payment == null) {
            return false;
        }
        
        // 결제 금액 검증
        return payment.getAmount() == amount && "paid".equals(payment.getStatus());
    }
    //결제 상세정보 조회
    public HashMap<String, String> getPaymentDetail(String imp_uid) {
        HashMap<String, String> map = new HashMap<String, String>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, m.name, m.id, m.email, m.hp FROM payment p " + 
                    "INNER JOIN member m ON p.member_num = m.num " +
                    "WHERE p.imp_uid = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, imp_uid);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                map.put("imp_uid", rs.getString("imp_uid"));
                map.put("merchant_uid", rs.getString("merchant_uid"));
                map.put("amount", rs.getString("amount"));
                map.put("addr", rs.getString("addr"));
                map.put("delivery_msg", rs.getString("delivery_msg"));
                map.put("status", rs.getString("status"));
                map.put("paymentday", rs.getString("paymentday"));
                map.put("member_name", rs.getString("name"));
                map.put("member_id", rs.getString("id"));
                map.put("member_email", rs.getString("email"));
                map.put("member_hp", rs.getString("hp"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return map;
    }

 // 상품 결제 내역 조회(관리자의 전체 결제 현황 모니터링용)
    public List<HashMap<String, String>> getProductPaymentList() {
        List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT p.*, s.sangpum, s.price, m.name as buyer_name " +
                     "FROM coffee.payment p " +
                     "INNER JOIN coffee.shop s ON p.merchant_uid = s.shopnum " +
                     "INNER JOIN member m ON p.member_num = m.num " +
                     "WHERE p.status = 'paid' " +
                     "ORDER BY p.paymentday DESC";
        
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                HashMap<String, String> map = new HashMap<String, String>();
                map.put("imp_uid", rs.getString("imp_uid"));
                map.put("merchant_uid", rs.getString("merchant_uid"));
                map.put("amount", rs.getString("amount"));
                map.put("addr", rs.getString("addr"));
                map.put("delivery_msg", rs.getString("delivery_msg"));
                map.put("paymentday", rs.getString("paymentday"));
                map.put("sangpum", rs.getString("sangpum"));
                map.put("price", rs.getString("price"));
                map.put("buyer_name", rs.getString("buyer_name"));
                
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        
        return list;
    }

	// 반품창에서 써야하는 id값조회
    public PaymentDto getPaymentByIdx(String idx) {
        PaymentDto dto = null;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT p.*, m.hp FROM payment p JOIN member m ON p.member_num = m.num WHERE p.idx = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new PaymentDto();
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getInt("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setAddr(rs.getString("addr"));
                dto.setDelivery_msg(rs.getString("delivery_msg"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
                dto.setHp(rs.getString("hp"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return dto;
    }
}