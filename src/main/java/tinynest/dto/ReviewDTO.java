package tinynest.dto;
/*
이름        널?       유형             
--------- -------- -------------- 
R_NO      NOT NULL NUMBER(3)      
R_ID               VARCHAR2(20)   
R_CONTENT          VARCHAR2(1000) 
R_DATE    NOT NULL DATE           
R_CODE             NUMBER(4)    	//상품코드  
R_PCNO             NUMBER(4)   		//구매코드   
R_STATUS           NUMBER(1)
R_PNAME            VARCHAR2(100) 	//상품명
 */
public class ReviewDTO {
	private int r_no;
	private String r_id;
	private String r_writer;
	private String r_content;
	private String r_date;
	private int r_code;
	private int r_pcno;
	private int r_status;
	private String r_pname;
	
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDTO(int r_no, String r_id, String r_writer, String r_content, String r_date, int r_code, int r_pcno,
			int r_status, String r_pname) {
		super();
		this.r_no = r_no;
		this.r_id = r_id;
		this.r_writer = r_writer;
		this.r_content = r_content;
		this.r_date = r_date;
		this.r_code = r_code;
		this.r_pcno = r_pcno;
		this.r_status = r_status;
		this.r_pname = r_pname;
	}

	public int getR_no() {
		return r_no;
	}

	public void setR_no(int r_no) {
		this.r_no = r_no;
	}

	public String getR_id() {
		return r_id;
	}

	public void setR_id(String r_id) {
		this.r_id = r_id;
	}

	public String getR_writer() {
		return r_writer;
	}

	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public String getR_date() {
		return r_date;
	}

	public void setR_date(String r_date) {
		this.r_date = r_date;
	}

	public int getR_code() {
		return r_code;
	}

	public void setR_code(int r_code) {
		this.r_code = r_code;
	}

	public int getR_pcno() {
		return r_pcno;
	}

	public void setR_pcno(int r_pcno) {
		this.r_pcno = r_pcno;
	}

	public int getR_status() {
		return r_status;
	}

	public void setR_status(int r_status) {
		this.r_status = r_status;
	}

	public String getR_pname() {
		return r_pname;
	}

	public void setR_pname(String r_pname) {
		this.r_pname = r_pname;
	}
	
}
