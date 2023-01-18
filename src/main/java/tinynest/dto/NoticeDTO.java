package tinynest.dto;
/*
이름        널?       유형             
--------- -------- -------------- 
N_NO      NOT NULL NUMBER(3)      
N_TITLE   NOT NULL VARCHAR2(100)  
N_ID               VARCHAR2(20)   
N_CONTENT          VARCHAR2(1000) 
N_DATE    NOT NULL DATE           
N_STATUS           NUMBER(1)
*/
public class NoticeDTO {
	private int n_no;
	private String n_title;
	private String n_id;
	private String n_writer;
	private String n_content;
	private String n_date;
	private int n_status;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public NoticeDTO(int n_no, String n_title, String n_id, String n_writer, String n_content, String n_date,
			int n_status) {
		this.n_no = n_no;
		this.n_title = n_title;
		this.n_id = n_id;
		this.n_writer = n_writer;
		this.n_content = n_content;
		this.n_date = n_date;
		this.n_status = n_status;
	}

	public int getN_no() {
		return n_no;
	}

	public void setN_no(int n_no) {
		this.n_no = n_no;
	}

	public String getN_title() {
		return n_title;
	}

	public void setN_title(String n_title) {
		this.n_title = n_title;
	}

	public String getN_id() {
		return n_id;
	}

	public void setN_id(String n_id) {
		this.n_id = n_id;
	}

	public String getN_writer() {
		return n_writer;
	}

	public void setN_writer(String n_writer) {
		this.n_writer = n_writer;
	}

	public String getN_content() {
		return n_content;
	}

	public void setN_content(String n_content) {
		this.n_content = n_content;
	}

	public String getN_date() {
		return n_date;
	}

	public void setN_date(String n_date) {
		this.n_date = n_date;
	}

	public int getN_status() {
		return n_status;
	}

	public void setN_status(int n_status) {
		this.n_status = n_status;
	}
	
}