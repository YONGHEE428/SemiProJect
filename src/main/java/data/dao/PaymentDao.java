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
    
    // 결제 정보 저장
    public void insertPayment(PaymentDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        
        String sql = "insert into payment values (null,?,?,?,?,?,now())";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getImp_uid());
            pstmt.setString(2, dto.getMerchant_uid());
            pstmt.setString(3, dto.getMember_num());
            
            //결제금액
            pstmt.setInt(4, dto.getAmount());
            pstmt.setString(5, dto.getStatus());
            
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
        
        String sql = "select * from payment where imp_uid=?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, imp_uid);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                dto = new PaymentDto();
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getString("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
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
        
        String sql = "select * from payment where member_num=? order by paymentday desc";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member_num);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                PaymentDto dto = new PaymentDto();
                dto.setIdx(rs.getString("idx"));
                dto.setImp_uid(rs.getString("imp_uid"));
                dto.setMerchant_uid(rs.getString("merchant_uid"));
                dto.setMember_num(rs.getString("member_num"));
                dto.setAmount(rs.getInt("amount"));
                dto.setStatus(rs.getString("status"));
                dto.setPaymentday(rs.getTimestamp("paymentday"));
                
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
    public HashMap<String, String> getPaymentDetail(String imp_uid){
    	HashMap<String, String> map=new HashMap<String, String>();
    	Connection conn=db.getConnection();
    	PreparedStatement pstmt=null;
    	ResultSet rs= null;
    	
    	String sql="select p.*, m.name, m.id, m.email from payment p"+
    			"INNER JOIN member m ON p.member_num = m.num " +
                "WHERE p.imp_uid = ?";
    		try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, imp_uid);
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					map.put("imp_uid", rs.getString("imp_uid"));
					map.put("merchant_uid", rs.getString("merchant_uid"));
					map.put("amount", rs.getString("amount"));
			        map.put("status", rs.getString("status"));
			        map.put("paymentday", rs.getString("paymentday"));
			        map.put("member_name", rs.getString("name"));
			        map.put("member_id", rs.getString("id"));
			        map.put("member_email", rs.getString("email"));
				}
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
    	return map;
    }
    
 // 상품 결제 내역 조회
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
}