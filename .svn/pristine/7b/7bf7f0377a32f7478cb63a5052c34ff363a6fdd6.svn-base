<%@page import="tinynest.dao.PurchaseDAO"%>
<%@page import="tinynest.dto.PurchaseDTO"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="tinynest.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	int pageSize=10;
	int totalReview=ReviewDAO.getDAO().selectReviewCount(search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalReview/pageSize);
	  
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	int endRow=pageNum*pageSize;
	
	if(endRow>totalReview) {
		endRow=totalReview;
	}
	
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow, search, keyword);
	
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int pritnNum=totalReview-(pageNum-1)*pageSize;
	
%>
<style type="text/css">
#board_list {
	width: 1000px;
	margin-left: 300px;
	text-align: center;
}
#board_title {
	font-size: 10px;
	font-weight: normal;
	margin-bottom: 50px;
	text-align: left;
}
table {
	margin: 5px auto;
	border: 0;
	border-collapse: collapse;
	text-align:left;
	margin-bottom: 15px;
}
tbody {
	text-align:left;
}
th {
	border: 0;
	color: #555555;
	padding-bottom:3px;
}
td {
	border-top: 1px solid #e8e8e8;
	text-align: left;
	color : #757575;
	border-bottom: 1px solid #e8e8e8;
}
span {
	color : #91949c;
}
.content {
	color : black;
	font-size: 1rem;
	font-weight: normal;
}
.thumnail {
	width : 100%;
	height : 100%;
}
.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	color : black;
}
#board_list a:hover {
	text-decoration: none;
}
.secret, .remove {
	background-color: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}
select {
	border: 1px solid #d5d5d5;
}
input {
	border: 1px solid #d5d5d5;
}
button {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #d5d5d5;
}
.searchForm {
	margin-top: 10px;
}
</style>

<div id="board_list">
	<div id="board_title">REVIEW</div>
	
	<%-- 게시글 목록 출력 --%>
	
	<table>
	 
	<tr>		
		<th width="100" style="font-weight: 600; font-size:13px; padding-bottom: 7px;">상품평수 <%=totalReview %>개</th>
		<th width="800"></th>
	</tr>
	<% if(totalReview==0) { %>
	<tr>
		<td colspan="2">검색된 게시글이 없습니다.</td>
	</tr>	
	<% } else { %>
		<%-- List 객체에서 요소(BoardDTO 객체)를 하나씩 제공받아 반복 처리 --%>
		<% for(ReviewDTO review:reviewList) { %>
		<tr>
			<% ProductDTO product=ProductDAO.getDAO().selectProduct(review.getR_code()); %>
			<%-- 상품이미지 불러오기 --%>
			<td>
				<a href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_detail&p_code=<%=product.getP_code() %>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getP_img() %>" class="thumnail" />
				</a>
			</td>

				
			<%-- 제목 --%>
				<td class="subject">
					
					<%-- 게시글 상태를 구분하여 제목과 링크를 다르게 설정하여 응답되도록 처리 --%>
					<% if(review.getR_status()==1) {//일반 게시글인 경우 %>				
					<span>id) <%=review.getR_writer() %> &nbsp;&nbsp;</span>
					<% if(currentDate.equals(review.getR_date().substring(0,10))) {//오늘 작성된 게시글인 경우 %>
						<span>날짜) <%=review.getR_date().substring(11) %></span>
					<% } else {//오늘 작성된 게시글이 아닌 경우 %>
						<span>date) <%=review.getR_date() %></span>
					<% } %> 
					<br><br>
					<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_detail&r_no=<%=review.getR_no() %>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
						<span>상품명) <%=product.getP_name() %></span><br><br><br>
						<span class="content"><%=review.getR_content() %></span>
					</a>
					<% } else if(review.getR_status()==0) { %>
						<span class="remove">삭제글</span>
						작성자 또는 관리자에 의해 삭제된 게시글입니다.
					<% } %>
				</td>
				
				<% if(review.getR_status()!=0) {//삭제 게시글이 아닌 경우 %>
							
				<%-- 작성일 : 오늘 작성된 게시글은 시간만 출력하고 오늘 작성된 게시글이 아닌 게시글은 날짜와 시간 출력 --%>
				<% } else {//삭제 게시글인 경우 %>
				<td>&nbsp;</td>
				<td>&nbsp;</td>

				<% } %>
		</tr>
		<% } %>	
	<% } %>	
	</table>

	<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
	<%
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
	%>
	<% if(startPage>blockSize) {//첫번째 페이지 블럭이 아닌 경우%>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;〈&nbsp;</a>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 제공 %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;<%=i %>&nbsp;</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같은 경우 - 링크 미제공 %>
			&nbsp;<%=i %>&nbsp;
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 페이지 블럭이 아닌 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;〉&nbsp;</a>
	<% } %>
	
	<%-- 사용자로부터 검색어를 입력받아 게시글 검색 기능 구현 --%>
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review" method="post" class="searchForm">
	<%-- select 태그에 의해 전달되는 값은 반드시 검색단어를 비교하기 위한 컬럼명과 같은 이름으로 전달되도록 설정 --%>
	<select name="search">
		<option value="name" selected="selected">&nbsp;작성자&nbsp;</option>
		<option value="r_pname">&nbsp;상품명&nbsp;</option>
		<option value="r_content">&nbsp;내용&nbsp;</option>
	</select>
	<input type="text" name="keyword">
	<button type="submit">찾기</button>
	</form>	
</div>