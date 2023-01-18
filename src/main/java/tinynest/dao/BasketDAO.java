package tinynest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tinynest.dto.BasketDTO;

public class BasketDAO extends JdbcDAO {
	
	private static BasketDAO _dao;
	
	private BasketDAO() {}
	
	static {
		_dao = new BasketDAO();
	}
	
	public static BasketDAO getDAO() {
		return _dao;
	}
	
	//전달값 : 접속 중인 아이디(id)
	//결과 : 주어진 id를 가진 회원이 선택한 장바구니 리스트 반환
	public List<BasketDTO> selectBasketListById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BasketDTO> basketList = new ArrayList<>();
		
		try {
			con = getConnection();
			
			String sql = "SELECT b_no, b_id, b_code, p_name, p_img, p_price, b_amount"
					  + " FROM basket"
					  + " JOIN product ON basket.b_code = product.p_code"
					  + " WHERE b_id = ?"
					  + " ORDER BY b_no DESC";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BasketDTO basket = new BasketDTO();
				basket.setbNo(rs.getInt("b_no"));
				basket.setbId(rs.getString("b_id"));
				basket.setbCode(rs.getInt("b_code"));
				basket.setpName(rs.getString("p_name"));
				basket.setpImg(rs.getString("p_img"));
				basket.setpPrice(rs.getInt("p_price"));
				basket.setbAmount(rs.getInt("b_amount"));
				basketList.add(basket);
			}
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.selectAllBasket() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		
		return basketList;
	}
	
	//전달값 : 접속 중인 아이디(id), 상품 코드(bCode)
	//결과 : 주어진 id를 가진 회원의 장바구니 목록에서 해당 상품코드에 해당하는 상품 정보 반환
	public BasketDTO selectBasketByBcode(String id, int bCode) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BasketDTO basket = new BasketDTO();
		
		try {
			con = getConnection();
			
			String sql = "SELECT b_no, b_id, b_code, p_name, p_img, p_price, b_amount"
					  + " FROM basket"
					  + " JOIN product ON basket.b_code = product.p_code"
					  + " WHERE b_id = ? AND b_code = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, bCode);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				basket.setbNo(rs.getInt("b_no"));
				basket.setbId(rs.getString("b_id"));
				basket.setbCode(rs.getInt("b_code"));
				basket.setpName(rs.getString("p_name"));
				basket.setpImg(rs.getString("p_img"));
				basket.setpPrice(rs.getInt("p_price"));
				basket.setbAmount(rs.getInt("b_amount"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.selectBasketByBcode() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		
		return basket;
	}
	
	//전달값 : 접속 중인 아이디(id)
	//결과 : BASKET 테이블에 저장된 해당 아이디의 장바구니 목록의 개수
	public int selectBasketCountById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(*) FROM basket WHERE b_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.selectBasketCountById() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	
	//전달값 : BasketDTO 객체
	//결과 : BASKET 테이블에 객체에 담긴 상품 정보 저장
	public int insertBasket(BasketDTO basket) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "INSERT INTO basket(b_no, b_id, b_code, b_amount) VALUES(basket_seq.nextval, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, basket.getbId());
			pstmt.setInt(2, basket.getbCode());
			pstmt.setInt(3, basket.getbAmount());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.insertBasket() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt, null);
		}
		
		return rows;
	}
	
	
	//전달값 : 접속 중인 아이디(id), 제품 번호(bCode), 제품 수량(amount)
	//결과 : BASKET 테이블에 있는 해당 제품번호(B_CODE)의 제품 수량(B_AMOUNT)을 변경
	public int updateBasketAmount(String id, int bCode, int amount) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE basket SET b_amount = ? WHERE b_id = ? AND b_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, amount);
			pstmt.setString(2, id);
			pstmt.setInt(3, bCode);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.updateAmount() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//전달값 : 접속 중인 아이디(id), 제품 번호(bCode)
	//결과 : BASKET 테이블에서 아이디와 제품 번호가 일치하는 장바구니 목록 삭제
	public int deleteBasket(String id, int bCode) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM basket WHERE b_id = ? AND b_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, bCode);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.deleteBasket() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//전달값 : 접속 중인 아이디(id)
	//결과 : BASKET 테이블에 있는 아이디의 장바구니 목록 전체 삭제
	public int deleteAllBasket(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM basket WHERE b_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] BasketDAO.deleteAllBasket() 에러 발생");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
}
