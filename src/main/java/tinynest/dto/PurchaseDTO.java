package tinynest.dto;

/*
이름           널?       유형            
------------ -------- ------------- 
PC_NO        NOT NULL NUMBER(4)     1
PC_ID                 VARCHAR2(20)  2
PC_DATE      NOT NULL DATE          3
PC_STATUS    NOT NULL NUMBER(1)     4
PC_CODE               NUMBER(4)     5
PC_AMOUNT    NOT NULL NUMBER(3)     6
PC_PRICE     NOT NULL NUMBER(9)     7
PC_LNAME     NOT NULL VARCHAR2(20)  8
PC_LPHONE    NOT NULL VARCHAR2(20)  9
PC_ZIPCODE   NOT NULL VARCHAR2(5)   10
PC_LADDRESS1 NOT NULL VARCHAR2(200) 11
PC_LADDRESS2 NOT NULL VARCHAR2(200) 12
*/

public class PurchaseDTO {

	private int pcNo;
	private String pcId;
	private String pcDate;
	private int pcStatus;
	private int pcCode;
	private String pName;
	private int pPrice;
	private String pImg;
	private int pcAmount;
	private int pcPrice;
	private String pcLname;
	private String pcLphone;
	private String pcZipcode;
	private String pcLaddress1;
	private String pcLaddress2;
	
	public PurchaseDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getPcNo() {
		return pcNo;
	}

	public void setPcNo(int pcNo) {
		this.pcNo = pcNo;
	}

	public String getPcId() {
		return pcId;
	}

	public void setPcId(String pcId) {
		this.pcId = pcId;
	}

	public String getPcDate() {
		return pcDate;
	}

	public void setPcDate(String pcDate) {
		this.pcDate = pcDate;
	}

	public int getPcStatus() {
		return pcStatus;
	}

	public void setPcStatus(int pcStatus) {
		this.pcStatus = pcStatus;
	}

	public int getPcCode() {
		return pcCode;
	}

	public void setPcCode(int pcCode) {
		this.pcCode = pcCode;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public String getpImg() {
		return pImg;
	}

	public void setpImg(String pImg) {
		this.pImg = pImg;
	}

	public int getPcAmount() {
		return pcAmount;
	}

	public void setPcAmount(int pcAmount) {
		this.pcAmount = pcAmount;
	}

	public int getPcPrice() {
		return pcPrice;
	}

	public void setPcPrice(int pcPrice) {
		this.pcPrice = pcPrice;
	}

	public String getPcLname() {
		return pcLname;
	}

	public void setPcLname(String pcLname) {
		this.pcLname = pcLname;
	}

	public String getPcLphone() {
		return pcLphone;
	}

	public void setPcLphone(String pcLphone) {
		this.pcLphone = pcLphone;
	}

	public String getPcZipcode() {
		return pcZipcode;
	}

	public void setPcZipcode(String pcZipcode) {
		this.pcZipcode = pcZipcode;
	}

	public String getPcLaddress1() {
		return pcLaddress1;
	}

	public void setPcLaddress1(String pcLaddress1) {
		this.pcLaddress1 = pcLaddress1;
	}

	public String getPcLaddress2() {
		return pcLaddress2;
	}

	public void setPcLaddress2(String pcLaddress2) {
		this.pcLaddress2 = pcLaddress2;
	}
	
	
}
