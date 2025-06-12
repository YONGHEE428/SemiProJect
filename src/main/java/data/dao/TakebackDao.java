package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.TakebackDto;
import db.copy.DBConnect;

public class TakebackDao {

    DBConnect db = new DBConnect();

    // 반품 신청 (성공 시 true, 실패 시 false 반환)
    public boolean insertTakeback(TakebackDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "INSERT INTO shop.takeback " +
            "(order_id, payment_idx, order_sangpum_id, member_num, receiver_name, receiver_hp, receiver_addr, refund_amount, pickup_date, pickup_request, takeback_status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getOrderId());
            pstmt.setInt(2, dto.getPaymentIdx());
            pstmt.setInt(3, dto.getOrderSangpumId());  
            pstmt.setInt(4, dto.getMemberNum());
            pstmt.setString(5, dto.getReceiverName());
            pstmt.setString(6, dto.getReceiverHp());
            pstmt.setString(7, dto.getReceiverAddr());
            pstmt.setInt(8, dto.getRefundAmount());
            pstmt.setDate(9, dto.getPickupDate());
            pstmt.setString(10, dto.getPickupRequest());
            pstmt.setString(11, dto.getTakebackStatus());
            int n = pstmt.executeUpdate();
            return n > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //반품 단건조회 (by PK)
    public TakebackDto getTakebackById(int takebackId) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        TakebackDto dto = null;

        String sql = "SELECT * FROM shop.takeback WHERE takeback_id=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, takebackId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = makeDto(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return dto;
    }

    //회원별 반품 리스트
    public List<TakebackDto> getTakebacksByMember(int memberNum) {
        List<TakebackDto> list = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM shop.takeback WHERE member_num=? ORDER BY return_date DESC";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, memberNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(makeDto(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //(선택) 전체 반품 리스트
    public List<TakebackDto> getAllTakebacks() {
        List<TakebackDto> list = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM shop.takeback ORDER BY return_date DESC";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(makeDto(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    // 내부: ResultSet → Dto 변환 (코드 중복방지용)
    private TakebackDto makeDto(ResultSet rs) throws SQLException {
        TakebackDto dto = new TakebackDto();
        dto.setTakebackId(rs.getInt("takeback_id"));
        dto.setOrderId(rs.getInt("order_id"));
        dto.setPaymentIdx(rs.getInt("payment_idx"));
        dto.setOrderSangpumId(rs.getInt("order_sangpum_id")); 
        dto.setMemberNum(rs.getInt("member_num"));
        dto.setReceiverName(rs.getString("receiver_name"));
        dto.setReceiverHp(rs.getString("receiver_hp"));
        dto.setReceiverAddr(rs.getString("receiver_addr"));
        dto.setRefundAmount(rs.getInt("refund_amount"));
        dto.setReturnDate(rs.getTimestamp("return_date"));
        dto.setPickupDate(rs.getDate("pickup_date"));
        dto.setPickupRequest(rs.getString("pickup_request"));
        dto.setTakebackStatus(rs.getString("takeback_status"));
        return dto;
    }
    
    public void updateOrderSangpumStatus(int orderSangpumId, String status) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "UPDATE order_sangpum SET status=? WHERE order_sangpum_id=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, orderSangpumId);
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

}
