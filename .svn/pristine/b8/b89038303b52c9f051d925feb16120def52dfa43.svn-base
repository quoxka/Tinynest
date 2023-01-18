<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 검색어를 전달받아 검색어가 포함된 상품명을 가진 상품을 출력하는 JSP 문서 --%>
<%	
	//전달값을 반환받아 저장
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	//~~페이징처리~~
	//페이징 처리에 필요한 변수 선언
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}

	//하나의 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=9;
	
	//검색 관련 정보를 전달받아 notice 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalProduct=ProductDAO.getDAO().searchProductCount(keyword);
		         
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);
	  
	//요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//비정상적인 요청 페이지 번호인 경우
		pageNum=1;//첫번째 페이지의 게시글 목록이 검색되어 응답되도록 요청 페이지 번호 변경
	}
			
	//요청 페이지 번호에 대한 시작 게시글의 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;
	                    
	//요청 페이지 번호에 대한 종료 게시글의 행번호를 계산하여 저장
	//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지에 대한 종료 게시글의 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalProduct) {
		endRow=totalProduct;
	}
	
	
	//--하단블럭파트--
	//하나의 페이지 블럭에 출력될 페이지 번호의 갯수를 설정
	int blockSize=5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,... 
	int startPage=(pageNum-1)/blockSize*blockSize+1;
	//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
	//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
	int endPage=startPage+blockSize-1;
	//마지막 페이지 블럭의 종료 페이지 번호 변경
	if(endPage>totalPage) {
		endPage=totalPage;
	}
	//--하단블럭파트--
	
	
	//검색어를 전달받아 PRODUCT 테이블에 상품 중 검색어가 포함된 상품명을 가진 상품을 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().searchProductList(keyword, startRow, endRow);
%>

<style type="text/css">
#searchTitle {margin-left: 300px; margin-bottom: 50px; font-size: 10px; font-weight: normal;}
.searchResult {margin-left: 300px;}
#productList {display: flex; flex-wrap: wrap; width: 1200px;}
.product {display: flex; flex-direction: column; width: 33%;}
#p_img {width: 385px; margin: 10px 7px;}
#paging{text-align: center;}
#name {
	font-size: 12px;
	color: #999999;
	display: flex;
	font-weight: normal;
	line-height: 18px;
	margin: 20px 0 0 7px;
	flex-direction: column;
	line-height: 0.75em;
}
#price {
	font-size: 12px;
	color: #999999;
	font-style: italic;
	font-weight: normal;
	line-height: 18px;
	display: flex;
	margin: 10px 0 50px 7px;
	flex-direction: column;
	line-height: 0.75em;
}
</style>

<div id="searchTitle">SEARCH</div>
<%-- 검색 목록 출력 --%>
<div class="searchResult">
<% if(productList.isEmpty()) { %>
	<p>검색 결과가 없습니다.</p>
<% } else { %>
	<div id="productList">
		<% for(ProductDTO product:productList) { %>
			<% if(product.getP_amount()!=0) { //제품 수량이 존재하는 경우 %>
				<%-- 제품정보 출력 --%>
				<div class="product">
					<div>
						<a href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_detail&p_code=<%=product.getP_code()%>">
							<img id="p_img"
							src="<%=request.getContextPath() %>/product_image/<%=product.getP_img() %>">
						</a>
					</div>
					<div>
						<span id="name"> <%=product.getP_name() %> </span>
					</div>
					<div>
						<span id="price"> <%=DecimalFormat.getInstance().format(product.getP_price()) %>원 </span>
					</div>
				</div>
			<% } %>
		<% } %>
		<div style="clear: both;"></div>
	</div>
<% } %>
</div>



<% if(!productList.isEmpty()) { %>
<div id="paging">
	<% if(startPage>blockSize) {//첫번째 페이지 블럭이 아닌 경우%>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=search&keyword=<%=keyword %>&pageNum=<%=startPage-blockSize%>">&nbsp;〈&nbsp;</a>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 제공 %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=search&keyword=<%=keyword %>&pageNum=<%=i%>">&nbsp;<%=i %>&nbsp;</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같은 경우 - 링크 미제공 %>
			&nbsp;<%=i %>&nbsp;
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 페이지 블럭이 아닌 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=search&keyword=<%=keyword %>&pageNum=<%=startPage+blockSize%>">&nbsp;〉&nbsp;</a>
	<% } %>
</div>
<% } %>