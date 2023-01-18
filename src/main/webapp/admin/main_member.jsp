<%@page import="java.util.List"%>
<%@page import="tinynest.dao.MemberDAO"%>
<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>Tinynest</title>  
<%-- MEMBER 테이블에 저장된 모든 회원정보를 검색하여 클라이언트에게 전달하는 JSP문서 --%>
<%-- 관리자만 요청가능한 JSP 문서 --%>
<%-- 상태변경 >> member_status_action.jsp--%>

<%-- 관리자 회원이 접근했는지 확인. --%>
<%@include file="/security/admin_check.jspf" %> 


<%

	//페이징 처리 관련 전달값(요청 페이지 번호)를 반환받아 저장
	// => 요청 페이지 번호에 대한 전달값이 없는 경우 첫번째 페이지의 게시글 목록을 검색하여 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null && request.getParameter("pageNum")!="null") {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}


	//하나의 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=10;
	
	//검색 관련 정보를 전달받아 notice 테이블에 저장된 특정 게시글의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalMember=MemberDAO.getDAO().selectMemberCount();
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalMember/pageSize);
	
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
	if(endRow>totalMember) {
		endRow=totalMember;
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
	
	
	
	List<MemberDTO> memberList=MemberDAO.getDAO().selectMemberList(startRow, endRow);
	
%>

<style type="text/css">
#member {
	width: 1070px;
	margin-left: 400px;
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
a:hover {
	text-decoration: none;
	font-weight: bold;
	}
#paging{margin-top: 50px; margin-left: 850px;}

.member_check { width: 120px; }
.member_id { width: 100px; }
.member_name { width: 100px; }
.member_email { width: 160px; }
.member_mobile { width: 320px; }
.member_address { width: 320px; }
.member_status { width: 100px; }
</style>

<div id="member">
<form name="memberForm" id="memberForm">
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th style=" width: 300.862;">전화번호</th>
			<th>주소</th>
			<th>상태</th>
		</tr>
		
		<% if(memberList.isEmpty()) { %>
			<tr>
				<td colspan="7">등록된 회원이 없습니다.</td>
			</tr>
			<%}else{ %>
		<% for(MemberDTO member:memberList) { %>
		<tr>
			<td class="member_id"><%=member.getId() %></td>
			<td class="member_name"><%=member.getName() %></td>
			<td class="member_email"><%=member.getEmail() %></td>
			<td class="member_phone"><%=member.getPhone() %></td>
			<td class="member_address">
				[<%=member.getZipcode() %>]<%=member.getAddress1() %> <%=member.getAddress2() %>
			</td>
			<td class="member_status">
				<select class="status" name="<%=member.getId()%>">
					<option value="0" <% if(member.getStatus()==0) { %> selected="selected" <% } %>>탈퇴회원</option>
					<option value="1" <% if(member.getStatus()==1) { %> selected="selected" <% } %>>일반회원</option>
					<option value="9" <% if(member.getStatus()==9) { %> selected="selected" <% } %>>관리자</option>
				</select>
			</td>
		</tr>
		<% } %>
		<% } %>
	</table>
</form>
</div>

<div id="paging">
	<% if(startPage>blockSize) {//첫번째 페이지 블럭이 아닌 경우%>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=main_member&pageNum=<%=startPage-blockSize%>">[이전]</a>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 제공 %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=main_member&pageNum=<%=i%>">&nbsp;[<%=i %>]&nbsp;</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같은 경우 - 링크 미제공 %>
			&nbsp;<%=i %>&nbsp;
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 페이지 블럭이 아닌 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=main_member&pageNum=<%=startPage+blockSize%>">[다음]</a>
	<% } %>
</div>


<script type="text/javascript" >

$(".status").change(function() {
	//이벤트가 발생된 입력태그의 태그 속성값을 반환받아 저장
	// => 회원상태를 변경하고자 하는 회원의 아이디를 제공받아 저장 - 식별자
	var id=$(this).attr("name");
	//이벤트가 발생된 입력태그의 입력값을 반환받아 저장
	// => 변경할 회원상태를 제공받아 저장 - 변경값
	var status=$(this).val();
	
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=member_status_action&id="+id+"&status="+status+"&pageNum="+<%=pageNum%>;
});
</script>












