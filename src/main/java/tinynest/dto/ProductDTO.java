package tinynest.dto;

/*
 이름       널?       유형            
-------- -------- ------------- 
P_CODE   NOT NULL NUMBER(4)      - 상품코드(pk)
P_NAME   NOT NULL VARCHAR2(100)  - 상품명
P_IMG    NOT NULL VARCHAR2(500)  - 상품 이미지
P_PRICE  NOT NULL NUMBER(6)      - 상품 가격
P_INFO            VARCHAR2(500)  - 상세 이미지
P_AMOUNT NOT NULL NUMBER(3)      - 상품 갯수
P_CATE   NOT NULL VARCHAR2(100)  - 상품 카테고리
*/

public class ProductDTO {
	private int p_code;
	private String p_name;
	private String p_img;
	private String p_info;
	private int p_price;
	private int p_amount;
	private String p_cate;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getP_code() {
		return p_code;
	}

	public void setP_code(int p_code) {
		this.p_code = p_code;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_img() {
		return p_img;
	}

	public void setP_img(String p_img) {
		this.p_img = p_img;
	}

	public int getP_price() {
		return p_price;
	}
	
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	
	public String getP_info() {
		return p_info;
	}
	
	public void setP_info(String p_info) {
		this.p_info = p_info;
	}

	public int getP_amount() {
		return p_amount;
	}

	public void setP_amount(int p_amount) {
		this.p_amount = p_amount;
	}

	public String getP_cate() {
		return p_cate;
	}

	public void setP_cate(String p_cate) {
		this.p_cate = p_cate;
	}
}