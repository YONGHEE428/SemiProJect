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

		DBConnect db=new DBConnect();
		
		// 반품 신청
		public void insertTakeback(TakebackDto dto)
		{
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			
			String sql="insert into shop.takeback INSERT INTO takeback (order_id, payment_idx, member_num, receiver_name, receiver_hp, receiver_addr, refund_amount, pickup_date, pickup_request, takeback_status)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getOrderId());
				pstmt.setInt(2, dto.getPaymentIdx());
	            pstmt.setInt(3, dto.getMemberNum());
	            pstmt.setString(4, dto.getReceiverName());
	            pstmt.setString(5, dto.getReceiverHp());
	            pstmt.setString(6, dto.getReceiverAddr());
	            pstmt.setInt(7, dto.getRefundAmount());
	            pstmt.setDate(8, dto.getPickupDate());
	            pstmt.setString(9, dto.getPickupRequest());
	            pstmt.setString(10, dto.getTakebackStatus());
	            pstmt.execute();
	            
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
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

	    //내부: ResultSet → Dto 변환 (코드 중복방지용)
	    private TakebackDto makeDto(ResultSet rs) throws SQLException {
	        TakebackDto dto = new TakebackDto();
	        dto.setTakebackId(rs.getInt("takeback_id"));
	        dto.setOrderId(rs.getInt("order_id"));
	        dto.setPaymentIdx(rs.getInt("payment_idx"));
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

	    //update, delete
	}
		

