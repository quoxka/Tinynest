package tinynest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tinynest.dto.ProductDTO;

public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;
	
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	
	//메인페이지,카테고리별페이지 페이징처리
	public List<ProductDTO> selectProductList(String p_cate, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		
		try {
			con=getConnection();
			
			if(p_cate==null || p_cate.equals("ALL")) { //미검색, 전체 출력(메인페이지)
				String sql="select * from (select rownum rn,temp.* from (select p_code"
					+ ",p_name,p_img,p_price,p_info,p_amount,p_cate from product"
					+ " order by p_code desc, p_cate) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			}
			else { //카테고리 검색(카테고리별 페이지)
				String sql="select * from (select rownum rn,temp.* from (select p_code"
					+ ",p_name,p_img,p_price,p_info,p_amount,p_cate from product where p_cate=?"
					+ " order by p_code desc, p_cate) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, p_cate);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setP_code(rs.getInt("p_code"));
				product.setP_name(rs.getString("p_name"));
				product.setP_img(rs.getString("p_img"));
				product.setP_price(rs.getInt("p_price"));
				product.setP_info(rs.getString("p_info"));
				product.setP_amount(rs.getInt("p_amount"));
				product.setP_cate(rs.getString("p_cate"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[ERROR]selectProductList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//검색결과페이지 페이징처리
	public List<ProductDTO> searchProductList(String keyword, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		
		try {
			con=getConnection();
		
			if(keyword=="") {
				return productList;
			}
		
			String sql="select * from (select rownum rn,temp.* from (select p_code"
				+ ",p_name,p_img,p_price,p_info,p_amount,p_cate from product where p_name like lower('%'||?||'%')"
				+ " order by p_code desc, p_cate) temp) where rn between ? and ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setP_code(rs.getInt("p_code"));
				product.setP_name(rs.getString("p_name"));
				product.setP_img(rs.getString("p_img"));
				product.setP_price(rs.getInt("p_price"));
				product.setP_info(rs.getString("p_info"));
				product.setP_amount(rs.getInt("p_amount"));
				product.setP_cate(rs.getString("p_cate"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[ERROR]searchProductList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//p_code를 전달받아 PRODCT테이블에 저장된 전달값과 일치하는 상품정보를 검색하는 메소드
	public ProductDTO selectProduct(int p_code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null; 
		
		try {
			con=getConnection();
			
			String sql="select * from product where p_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, p_code);
		
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setP_code(rs.getInt("p_code"));
				product.setP_name(rs.getString("p_name"));
				product.setP_img(rs.getString("p_img"));
				product.setP_price(rs.getInt("p_price"));
				product.setP_info(rs.getString("p_info"));
				product.setP_amount(rs.getInt("p_amount"));
				product.setP_cate(rs.getString("p_cate"));
			}
		} catch (SQLException e) {
			System.out.println("[ERROR]selectProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}

	
	//카테고리 검색 관련 정보를 전달받아 Product 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectProductCount(String p_cate) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(p_cate==null || p_cate.equals("ALL")) {
				String sql="select count(*) from product";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from product where p_cate=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, p_cate);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
		
	//키워드 검색 관련 정보를 전달받아 Product 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int searchProductCount(String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product where p_name like lower('%'||?||'%')";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]searchProductCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//상품정보를 전달받아 PRODUCT 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="insert into product values(product_seq.nextval, ?, ?, ?, ?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getP_name());
			pstmt.setString(2, product.getP_img());
			pstmt.setInt(3, product.getP_price());
			pstmt.setString(4, product.getP_info());
			pstmt.setInt(5, product.getP_amount());
			pstmt.setString(6, product.getP_cate());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[ERROR]insertProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, null);
		}
		return rows;
	}
		
	//상품정보를 전달받아 PRODUCT 테이블에 저장된 해당 상품정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			 		
			String sql="update product set p_name=?,p_img=?,p_price=?,p_info=?"
					+ ",p_amount=?,p_cate=? where p_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getP_name());
			pstmt.setString(2, product.getP_img());
			pstmt.setInt(3, product.getP_price());
			pstmt.setString(4, product.getP_info());
			pstmt.setInt(5, product.getP_amount());
			pstmt.setString(6, product.getP_cate());
			pstmt.setInt(7, product.getP_code());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[ERROR]updateProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//상품코드를 전달받아 PRODUCT 테이블에 저장된 해당 상품을 삭제하고 삭제행의 갯수를 반환하는 메소드
	public int deleteProduct(int p_code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			 		
			String sql="delete from product where p_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, p_code);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[ERROR]deleteProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select product_seq.nextval from dual";
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
	
	
}