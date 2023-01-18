<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<title>Tinynest</title>

<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 카테고리의 모든 제품정보를 검색하여 
클라이언트에게 전달하는 JSP 문서 --%>
<%-- > 관리자만 요청가능한 JSP문서--%>
<%-- > [제품등록]을 클릭한 경우 제품정보 입력페이지(product_add.jsp)열림 이동 --%>
<%-- > [제품삭제]를 클릭한 경우 제품삭제 입력페이지(product_remove_action.jsp)로 이동 - 상품코드 전달 --%>

<%-- > (보류) 제품정보의 [제품명]을 클릭한 경우 제품정보 출력페이지(product_detail.jsp)로 이동 - 제품번호 전달  --%>

<%-- 관리자 체크  --%>
<%@include file="/security/admin_check.jspf" %>

<%	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	// => 로그인 사용자에게만 글쓰기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 접근 권한 제공
	loginMember=(MemberDTO)session.getAttribute("loginMember");

	//전달값을 반환받아 저장
	String p_cate=request.getParameter("p_cate");
	if(p_cate==null) {//전달값이 없는 경우
		p_cate="ALL";		
	}
	
	//페이징 처리 관련 전달값(요청 페이지 번호)를 반환받아 저장
	// => 요청 페이지 번호에 대한 전달값이 없는 경우 첫번째 페이지의 게시글 목록을 검색하여 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}

	//하나의 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=10;
	
	//검색 관련 정보를 전달받아 notice 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalProduct=ProductDAO.getDAO().selectProductCount(p_cate);
		         
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
	
	
	
	
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductList(p_cate, startRow, endRow);
	
%>
<style type="text/css">
#product {
	width: 1070px;
	margin-left: 400px;
}
#btn {
	text-align: right;
	margin-bottom: 5px;
}
table {
    border: 0;
    border-collapse: collapse;
}
table {
    border-collapse: separate;
    text-indent: initial;
    white-space: normal;
    line-height: normal;
    font-weight: normal;
    font-size: medium;
    font-style: normal;
    color: -internal-quirk-inherit;
    text-align: start;
    border-spacing: 2px;
    font-variant: normal;
}
th {
    border: 0;
    color: #555555;
    border-top: 1px solid #e8e8e8;
	text-align: center;
	width: 1073px;
}
td{
	border-top: 1px solid #e8e8e8;
	text-align: center;
}
th {
    display: table-cell;
    vertical-align: inherit;
    font-weight: bold;
    text-align: -internal-center;
}
td a, td a:hover {
	text-decoration: underline;
	color: blue;
}
a:hover {
	text-decoration: none;
	font-weight: bold;
}

#paging{text-align: center;}
</style>

<div id="product">

	<div id="btn">
		<button type="button" id="addBtn">제품추가</button>
	</div>

	<table>
		<tr>
			<th>제품코드</th>
			<th class="pname">제품명</th>
			<th>카테고리</th>
			<th>제품수량</th>
			<th>제품가격</th>
		</tr>
		<% for(ProductDTO product:productList) { %>
		<tr>
			<td><%=product.getP_code()%></td>
			
			<td>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_detail&p_code=<%=product.getP_code()%>">
			<%=product.getP_name()%></a>
			</td>
			
			<td><%=product.getP_cate()%></td>
			
			<td><%=DecimalFormat.getInstance().format(product.getP_amount())%></td>
			<td>
				<%=DecimalFormat.getCurrencyInstance().format(product.getP_price())%>
			</td>	
		</tr>
		<% } %>
	</table>
	<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
	
	<br>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product" method="post" id="productForm">
		<select name="p_cate" id="p_cate">
			<option value="ALL" <% if(p_cate.equals("ALL")) { %> selected="selected" <% } %>>
				ALL
			</option>
			<option value="OUTER" <% if(p_cate.equals("OUTER")) { %> selected="selected" <% } %>>
				OUTER
			</option>
			<option value="TOP" <% if(p_cate.equals("TOP")) { %> selected="selected" <% } %>>
				TOP
			</option>
			<option value="BOTTOM" <% if(p_cate.equals("BOTTOM")) { %> selected="selected" <% } %>>
				BOTTOM
			</option>	
			<option value="ACC" <% if(p_cate.equals("ACC")) { %> selected="selected" <% } %>>
				ACC
			</option>	
		</select>	
	</form>
</div>

	<div id="paging">
	<% if(startPage>blockSize) {//첫번째 페이지 블럭이 아닌 경우%>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product&p_cate=<%=p_cate %>&pageNum=<%=startPage-blockSize%>">[이전]</a>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 제공 %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product&p_cate=<%=p_cate %>&pageNum=<%=i%>">&nbsp;[<%=i %>]&nbsp;</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같은 경우 - 링크 미제공 %>
			&nbsp;<%=i %>&nbsp;
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 페이지 블럭이 아닌 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product&p_cate=<%=p_cate %>&pageNum=<%=startPage+blockSize%>">&nbsp;[다음]&nbsp;</a>
	<% } %>
	</div>

<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_add";
});


$("#p_cate").change(function() {
	$("#productForm").submit();
	
});
</script>


