package tinynest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tinynest.dto.PurchaseDTO;

public class PurchaseDAO extends JdbcDAO {
	
	private static PurchaseDAO _dao;
	
	private PurchaseDAO() {}
	
	static {
		_dao = new PurchaseDAO();
	}
	
	public static PurchaseDAO getDAO() {
		return _dao;
	}
	
	//전달값 : 아이디 혹은 일부 혹은 null
	//결과 :  해당되는 아이디들의 주문정보 반환.
	
	public List<PurchaseDTO> searchPurchaseList(int startRow,int endRow,String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PurchaseDTO> purchaseList = new ArrayList<PurchaseDTO>();
		
		try {
			con=getConnection();
			
			if (keyword==null) {
			String sql ="select * from (select rownum rn,temp.* from (select pc_no "
					 + ", pc_id, pc_date, pc_status,"
					 + "		pc_code, pc_amount, pc_price, pc_Lname,"
					 + "		pc_Lphone, pc_zipcode, pc_Laddress1, pc_Laddress2"
					 + " FROM purchase order by pc_no desc ) temp) where rn between ? and ?  ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
				
			}else {
			String sql = "select * from (select rownum rn,temp.* from (select"
					  + " 		pc_no, pc_id, pc_date, pc_status,"
					  + "		pc_code, pc_amount, pc_price, pc_Lname,"
					  + "		pc_Lphone, pc_zipcode, pc_Laddress1, pc_Laddress2"
					  + " FROM purchase  where pc_id like '%'||?||'%'"
					  + " order by pc_no desc) temp)  where rn between ? and ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			}
			
			while (rs.next()) {
				PurchaseDTO purchase = new PurchaseDTO();
				purchase.setPcNo(rs.getInt("pc_no"));
				purchase.setPcId(rs.getString("pc_id"));
				purchase.setPcDate(rs.getString("pc_date"));
				purchase.setPcStatus(rs.getInt("pc_status"));
				purchase.setPcCode(rs.getInt("pc_code"));
				purchase.setPcAmount(rs.getInt("pc_amount"));
				purchase.setPcPrice(rs.getInt("pc_price"));
				purchase.setPcLname(rs.getString("pc_Lname"));
				purchase.setPcLphone(rs.getString("pc_Lphone"));
				purchase.setPcZipcode(rs.getString("pc_zipcode"));
				purchase.setPcLaddress1(rs.getString("pc_Laddress1"));
				purchase.setPcLaddress2(rs.getString("pc_Laddress2"));
				purchaseList.add(purchase);
			}
		} catch (SQLException e) {
			System.out.println("[에러] PurchaseDAO.searchPurchaseList() 에러 발생"+e.getMessage());
		} finally {
			close(con, pstmt,rs);
		}
		return purchaseList;
	}
	
	//전달값 : 접속 중인 아이디(id)
	//결과 : 접속 중인 아이디가 구매한 목록 리스트 반환
	public List<PurchaseDTO> selectPurchaseListById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PurchaseDTO> purchaseList = new ArrayList<>();
		
		try {
			con = getConnection();
			
			String sql = "SELECT"
					 + " 		pc_no, pc_id, pc_date, pc_status,"
					 + "		pc_code, p_name, p_price, p_img, pc_amount, pc_price, pc_Lname,"
					 + "		pc_Lphone, pc_zipcode, pc_Laddress1, pc_Laddress2"
					 + " FROM purchase"
					 + " JOIN product ON purchase.pc_code = product.p_code"
					 + " WHERE pc_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				PurchaseDTO purchase = new PurchaseDTO();
				purchase.setPcNo(rs.getInt("pc_no"));
				purchase.setPcId(rs.getString("pc_id"));
				purchase.setPcDate(rs.getString("pc_date"));
				purchase.setPcStatus(rs.getInt("pc_status"));
				purchase.setPcCode(rs.getInt("pc_code"));
				purchase.setpName(rs.getString("p_name"));
				purchase.setpPrice(rs.getInt("p_price"));
				purchase.setpImg(rs.getString("p_img"));
				purchase.setPcAmount(rs.getInt("pc_amount"));
				purchase.setPcPrice(rs.getInt("pc_price"));
				purchase.setPcLname(rs.getString("pc_Lname"));
				purchase.setPcLphone(rs.getString("pc_Lphone"));
				purchase.setPcZipcode(rs.getString("pc_zipcode"));
				purchase.setPcLaddress1(rs.getString("pc_Laddress1"));
				purchase.setPcLaddress2(rs.getString("pc_Laddress2"));
				purchaseList.add(purchase);
			}
		} catch (SQLException e) {
			System.out.println("[에러] PurchaseDAO.selectPurchaseListById() 에러 발생 : " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return purchaseList;
	}
	
	
	//전달값 : 상품 주문 정보(PurchaseDTO)
	//결과 : PURCHASE 테이블에 상품 주문 정보를 삽입하고 결과행의 개수 반환
	public int insertPurchase(PurchaseDTO purchase) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "INSERT INTO purchase("
					  + " 		pc_no, pc_id, pc_date, pc_status,"
					  + "		pc_code, pc_amount, pc_price, pc_Lname,"
					  + "		pc_Lphone, pc_zipcode, pc_Laddress1, pc_Laddress2)"
					  + " VALUES(purchase_seq.nextval, ?, SYSDATE, 0, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, purchase.getPcId());
			pstmt.setInt(2, purchase.getPcCode());
			pstmt.setInt(3, purchase.getPcAmount());
			pstmt.setInt(4, purchase.getPcPrice());
			pstmt.setString(5, purchase.getPcLname());
			pstmt.setString(6, purchase.getPcLphone());
			pstmt.setString(7, purchase.getPcZipcode());
			pstmt.setString(8, purchase.getPcLaddress1());
			pstmt.setString(9, purchase.getPcLaddress2());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] PurchaseDAO.insertPurchase() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	
	//구매상태 변경 메소드 0:준비중 1:배송중 2:배송완료 
	public int updateStatus(String pc_id,int pc_no,int pc_status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update purchase set pc_status=? where pc_id=? and pc_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pc_status);
			pstmt.setString(2, pc_id);
			pstmt.setInt(3, pc_no);
			
			rows=pstmt.executeUpdate();
		}catch(SQLException e) {
			System.out.println("[에러]updateStatus() 메소드의 SQL 오류 ="+e.getMessage());
		}finally {
			close(con,pstmt);
		}
		return rows;
	}
//검색 관련 정보를 전달받아 BOARD 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectPurchaseCount(String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
		
			if(keyword.equals("")) {
				String sql="select count(*) from purchase";
				pstmt=con.prepareStatement(sql);
				
			} else {
				String sql="select count(*) from purchase where pc_id like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectBoardCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
}

	




















