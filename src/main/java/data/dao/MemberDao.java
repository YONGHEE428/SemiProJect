package data.dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.MemberDto;
import db.copy.DBConnect;


public class MemberDao {

	DBConnect db=new DBConnect();
	
	//아이디체크
	public int isIdCheck(String id)
	{
		int isId=0;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) from member where id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {//해당아이디 존재하면 1,아니면 0
				/*
				 * if(rs.getInt(1)==1
				 * isId=1;
				 * */
				
				isId=rs.getInt(1);
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return isId;
	}
	
	//아이디에 따른 이름반환
	public String getName(String id)
	{
		String name="";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				name=rs.getString("name");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return name;
	}
	
	//멤버insert
	public void insertMember(MemberDto dto)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="INSERT INTO member (name, id, pass, email,hp, birth)VALUES (?, ?, ?, ?, ?,?)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPass());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getHp());
			pstmt.setString(6, dto.getBirth());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	// 아이디에 따른 회원 번호(num) 반환
	public int getMemberNumById(String id) {
	    int memberNum = -1;

	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT num FROM member WHERE id=?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            memberNum = rs.getInt("num");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return memberNum;
	}

	
	//회원목록
	public List<MemberDto> getAllMembers()
	{
		List<MemberDto> list=new Vector<MemberDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where role = 'user' order by id ";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDto dto=new MemberDto();
				
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setBirth(rs.getString("birth"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	}

    // 역할(role)에 따른 회원 목록 반환
    public List<MemberDto> getAllMembersByRole(String role) {
        List<MemberDto> list = new Vector<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM member WHERE role = ? ORDER BY id";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, role);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDto dto = new MemberDto();
                dto.setNum(rs.getString("num"));
                dto.setName(rs.getString("name"));
                dto.setId(rs.getString("id"));
                dto.setEmail(rs.getString("email"));
                dto.setBirth(rs.getString("birth"));
                dto.setHp(rs.getString("hp"));
                // 필요한 다른 필드도 설정
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

	//num에 대한 dto반환
	public MemberDto getData(String num)
	{
		MemberDto dto=new MemberDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where num =" + num;
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setEmail(rs.getString("email"));
				dto.setHp(rs.getString("hp"));
				dto.setBirth(rs.getString("birth"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return dto;
	}
	//비밀번호 체크
	public boolean isEqualPass(String num,String pass)
	{
		boolean b=false;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where num=? and pass=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, pass);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				b=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return b;
	}
	//삭제
	public void deleteMember(String num)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from member where num="+num;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public boolean login(String id, String pass) {
		boolean login = false;

		Connection cn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		String sql = "select * from member where id=? and pass = ?";
		
		try {
			pst=cn.prepareStatement(sql);
			pst.setString(1, id);
			pst.setString(2, pass);
			
			rs=pst.executeQuery();
			if(rs.next()) {
				login = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pst, cn);
		}
		return login;
		
	}
	//계정확인
	public MemberDto loginmember(String id, String pass) {
	    MemberDto dto = null;

	    Connection cn = db.getConnection();
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    String sql = "select * from member where id=? and pass = ?";

	    try {
	        pst = cn.prepareStatement(sql);
	        pst.setString(1, id);
	        pst.setString(2, pass);

	        rs = pst.executeQuery();
	        if (rs.next()) {
	            dto = new MemberDto();
	            dto.setNum(rs.getString("num"));
	            dto.setId(rs.getString("id"));
	            dto.setName(rs.getString("name"));
	            dto.setHp(rs.getString("hp"));
	            dto.setEmail(rs.getString("email"));
	            dto.setBirth(rs.getString("birth"));
	            dto.setRole(rs.getString("role"));
	            // 필요한 다른 값들도 추가
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pst, cn);
	    }
	    return dto;
	}

	public void updatemember(String num,  MemberDto dto) {
		
		Connection cn = db.getConnection();
		PreparedStatement pst = null;
		
		String sql = "update member set email = ?, birth = ?, pass = ? where num = " +num;
		
		try {
			pst=cn.prepareStatement(sql);
			
			pst.setString(1, dto.getEmail());
			pst.setString(2, dto.getBirth());
			pst.setString(3, dto.getPass());
			
			pst.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pst, cn);
		}

	}

}

