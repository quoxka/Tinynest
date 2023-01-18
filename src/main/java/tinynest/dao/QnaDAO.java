package tinynest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tinynest.dto.QnaDTO;

public class QnaDAO extends JdbcDAO {
	private static QnaDAO _dao;
	
	private QnaDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new QnaDAO();
	}
	
	public static QnaDAO getDAO() {
		return _dao;
	}
	
	//검색 관련 정보를 전달받아 QNA 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectQnaCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from qna";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from qna join member on q_id=member.id"
						+ " where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQnaCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public List<QnaDTO> selectQnaList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QnaDTO> qnaList=new ArrayList<>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from(select q_no,member.id,name,q_title,q_content,q_date"
						+ ",re_qna,re_qnastep,re_qnalevel,q_status from qna "
						+ "join member on q_id=member.id "
						+ "order by re_qna desc, re_qnastep) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from (select q_no,member.id,name,q_title,q_content,q_date"
						+ ",re_qna,re_qnastep,re_qnalevel,q_status from qna "
						+ "join member on q_id=member.id "
						+ "where "+search+" like '%'||?||'%' and q_status=1 order by re_qna desc, re_qnastep) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();	
			while(rs.next()) {
				QnaDTO qna=new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_id(rs.getString("id"));
				qna.setQ_writer(rs.getString("name"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setRe_qna(rs.getInt("re_qna"));
				qna.setRe_qnastep(rs.getInt("re_qnastep"));
				qna.setRe_qnalevel(rs.getInt("re_qnalevel"));
				qna.setQ_status(rs.getInt("q_status"));
				qnaList.add(qna);
			}		
		} catch (SQLException e) {
			System.out.println("[에러]selectQnaList() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
		}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		
		try {
			con=getConnection();
			
			String sql="select qna_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
	} catch (SQLException e) {
		System.out.println("[에러]selectQnaList() 메서드의 SQL 오류 = "+e.getMessage());
	} finally {
		close(con,pstmt,rs);
	}
		return nextNum;
	}
	
	
	public int insertQna (QnaDTO qna) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into qna values(?,?,?,?,sysdate,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna.getQ_no());
			pstmt.setString(2, qna.getQ_title());
			pstmt.setString(3, qna.getQ_id());
			pstmt.setString(4, qna.getQ_content());
			pstmt.setInt(5, qna.getRe_qna());
			pstmt.setInt(6, qna.getRe_qnastep());
			pstmt.setInt(7, qna.getRe_qnalevel());
			pstmt.setInt(8, qna.getQ_status());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQna() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt);
		}
		return rows;
	}
	
	public int updateQnaStep(int re_qna, int re_qnastep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set re_qnastep=re_qnastep+1 where re_qna=? and re_qnastep>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, re_qna);
			pstmt.setInt(2, re_qnastep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQnaStep() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
	return rows;
	}
	
	public QnaDTO selectQna(int q_no) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QnaDTO qna=null;
		try {
			con=getConnection();
			
			String sql="select q_no,q_title,member.id,name,q_content,q_date,re_qna,re_qnastep"
					+ ",re_qnalevel,q_status from qna join member"
					+ " on q_id=member.id where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, q_no);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				qna=new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_id(rs.getString("id"));
				qna.setQ_writer(rs.getString("name"));		
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_date(rs.getString("q_date"));	
				qna.setRe_qna(rs.getInt("re_qna"));
				qna.setRe_qnastep(rs.getInt("re_qnastep"));
				qna.setRe_qnalevel(rs.getInt("re_qnalevel"));
				qna.setQ_status(rs.getInt("q_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQna() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt,rs);
		}
		return qna;
	}
	
	public int updateQna (QnaDTO qna) { 
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set q_title=?,q_content=?,q_status=? where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qna.getQ_title());
			pstmt.setString(2, qna.getQ_content());
			pstmt.setInt(3, qna.getQ_status());
			pstmt.setInt(4, qna.getQ_no());
			
			rows=pstmt.executeUpdate();		
		} catch (SQLException e) {
			System.out.println("[에러]updateQna() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
		
	}
	
}