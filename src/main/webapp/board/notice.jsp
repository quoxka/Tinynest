<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="tinynest.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//검색대상과 검색단어를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	//System.out.println("검색대상 = "+search+", 검색단어 = "+keyword);
	//페이징 처리 관련 전달값(요청 페이지 번호)를 반환받아 저장
	// => 요청 페이지 번호에 대한 전달값이 없는 경우 첫번째 페이지의 게시글 목록을 검색하여 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
		
	//하나의 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=10;
	
	//검색 관련 정보를 전달받아 notice 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalNotice=NoticeDAO.getDAO().selectNoticeCount(search, keyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	//요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	int endRow=pageNum*pageSize;
	if(endRow>totalNotice) {
		endRow=totalNotice;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 
	//전달받아 notice 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 
	//DAO 클래스의 메소드 호출 - 검색 기능 구현시 호출하는 메소드
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청 페이지에 검색되어 출력될 게시글의 일련번호에 대한 시작값을 계산하여 저장
	int printNum=totalNotice-(pageNum-1)*pageSize;
%>
<style type="text/css">
#board_list {
	width: 900px;
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
	margin: 0 auto;
	border: 0;
	border-collapse: collapse;
	margin-bottom: 15px;
}
th {
	border: 0;
	color: #555555;
	padding-bottom:3px;
}
td {
	border-top: 1px solid #e8e8e8;
	text-align: center;
	color : #757575;
	border-bottom: 1px solid #e8e8e8;
}
.n_title {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	color : black;
}
#board_list a:hover {
	text-decoration: none;
	font-weight: bold;
}
.secret, .remove {
	background-color: #999;
	color: white;
	font-size: 14px;
	border: 1px solid #d5d5d5;
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
	<div id="board_title">NOTICE</div>

	<% if(loginMember!=null) {//로그인 사용자가 JSP 문서를 요청한 경우 %>
	<div style="text-align: right;">
		<button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_write&pageNum=<%=pageNum%>';">글쓰기</button>
	</div>	
	<% } %>
	<%-- 게시글 목록 출력 --%>
	<table>
		<tr>
			<th width="100">NO</th>
			<th width="500">SUBJECT</th>
			<th width="100">NAME</th>
			<th width="200">DATE</th>
		</tr>
	
		<% if(totalNotice==0) { %>
		<tr>
			<td colspan="4">검색된 게시글이 없습니다.</td>
		</tr>	
		<% } else { %>
			<%-- List 객체에서 요소(BoardDTO 객체)를 하나씩 제공받아 반복 처리 --%>
			<% for(NoticeDTO notice:noticeList) { %>
			<tr>
				<%-- 일련번호 : notice 테이블에 저장된 게시글의 글번호가 아닌 일련번호로 응답 --%>
				<td><%=printNum %></td>
				<% printNum--; %><%-- 일련번호를 1씩 감소시켜 저장 --%> 

				<%-- 제목 --%>
				<td class="n_title">
					
					<%-- 게시글 상태를 구분하여 제목과 링크를 다르게 설정하여 응답되도록 처리 --%>
					<% if(notice.getN_status()==1) {//일반 게시글인 경우 %>
					<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_detail&n_no=<%=notice.getN_no() %>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
						<%=notice.getN_title() %>
					</a>
					<% } else if(notice.getN_status()==0) { %>
						<span class="remove">삭제글</span>
						관리자에 의해 삭제된 게시글입니다.
					<% } %>
				</td>
				
				<% if(notice.getN_status()!=0) {//삭제 게시글이 아닌 경우 %>
				<%-- 작성자 --%>
				<td><%=notice.getN_writer() %></td>
							
				<%-- 작성일 : 오늘 작성된 게시글은 시간만 출력하고 오늘 작성된 게시글이 아닌 게시글은 날짜와 시간 출력 --%>
				<td>
					<% if(currentDate.equals(notice.getN_date().substring(0,10))) {//오늘 작성된 게시글인 경우 %>
						<%=notice.getN_date().substring(11) %>
					<% } else {//오늘 작성된 게시글이 아닌 경우 %>
						<%=notice.getN_date() %>
					<% } %>
				</td>
				<% } else {//삭제 게시글인 경우 %>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
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
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;〈&nbsp;</a>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 제공 %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;<%=i %>&nbsp;</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같은 경우 - 링크 미제공 %>
			&nbsp;<%=i %>&nbsp;
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 페이지 블럭이 아닌 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&nbsp;〉&nbsp;</a>
	<% } %>
	
	<%-- 사용자로부터 검색어를 입력받아 게시글 검색 기능 구현 --%>
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice" method="post" class="searchForm">
		<%-- select 태그에 의해 전달되는 값은 반드시 검색단어를 비교하기 위한 컬럼명과
		같은 이름으로 전달되도록 설정 --%>
		<select name="search">
			<option value="name" selected="selected">&nbsp;작성자&nbsp;</option>
			<option value="n_title">&nbsp;제목&nbsp;</option>
			<option value="n_content">&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">찾기</button>		
	</form>
</div>