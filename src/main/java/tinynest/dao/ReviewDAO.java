package tinynest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tinynest.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO {
	private static ReviewDAO _dao;
	
	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	
	public static ReviewDAO getDAO() {
		return _dao;
	}
	
	//검색 관련 정보를 전달받아 REVIEW 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectReviewCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from review where r_status=1";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from review join member on r_id=member.id"
						+ " where "+search+" like '%'||?||'%' and r_status=1";
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
	
	public List<ReviewDTO> selectReviewList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<>();	
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from (select r_no, member.id ,name,r_content,r_date,r_code,r_pcno,r_status,r_pname from review join member on r_id=member.id join product on r_code=p_code join purchase on r_pcno=pc_no order by r_no desc, r_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from (select r_no, member.id ,name,r_content,r_date,r_code,r_pcno,r_status,r_pname from review join member on r_id=member.id join product on r_code=p_code join purchase on r_pcno=pc_no"
						+ " where "+search+" like '%'||?||'%' and r_status=1 order by r_no desc, r_date desc) temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review=new ReviewDTO();
				review.setR_no(rs.getInt("r_no"));
				review.setR_id(rs.getString("id"));
				review.setR_writer(rs.getString("name"));
				review.setR_content(rs.getString("r_content"));
				review.setR_date(rs.getString("r_date"));
				review.setR_code(rs.getInt("r_code"));
				review.setR_pcno(rs.getInt("r_pcno"));
				review.setR_status(rs.getInt("r_status"));
				review.setR_pname(rs.getString("r_pname"));
				reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select review_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//게시글을 전달받아 REVIEW 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into review values(?,?,?,sysdate,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, review.getR_no());
			pstmt.setString(2, review.getR_id());
			pstmt.setString(3, review.getR_content());
			pstmt.setInt(4,review.getR_code());
			pstmt.setInt(5,review.getR_pcno());
			pstmt.setInt(6,review.getR_status());
			pstmt.setString(7,review.getR_pname());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertReview() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 REVIEW 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 메소드
	public ReviewDTO selectReview(int r_no) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review=null;
		
		try {
			con=getConnection();
			
			String sql="select r_no,member.id,name,r_content,r_date,r_code,r_status,r_pname from review join member on r_id=member.id join product on r_code=p_code where r_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, r_no);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				review=new ReviewDTO();
				review.setR_no(rs.getInt("r_no"));
				review.setR_id(rs.getString("id"));
				review.setR_writer(rs.getString("name"));
				review.setR_content(rs.getString("r_content"));
				review.setR_date(rs.getString("r_date"));
				review.setR_code(rs.getInt("r_code"));
				review.setR_status(rs.getInt("r_status"));
				review.setR_pname(rs.getString("r_pname"));
			}			
		} catch (SQLException e) {
			System.out.println("[에러]selectReview() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt,rs);
		}
		return review;
	}
	
	//게시글을 전달받아 REVIEW 테이블에 저장된 해당 게시글을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set r_content=?,r_status=? where r_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getR_content());
			pstmt.setInt(2, review.getR_status());
			pstmt.setInt(3, review.getR_no());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt);
		}
		return rows;
	}
}