<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dao.NoticeDAO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("n_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}
	//전달값을 반환받아 저장
	int n_no=Integer.parseInt(request.getParameter("n_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 notice 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice(n_no);
	
	//검색된 게시글이 없거나 삭제 게시글인 경우 - 비정상적인 요청
	if(notice==null || notice.getN_status()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
%>
<style type="text/css">
h3 {
	margin : 0 auto;
	text-align: center;
	margin-bottom: 15px;
	font-size : 12px;
	color: #555;
}
#board_detail {
	width: 500px;
	margin-left: 500px;
}
table {
	border: 0;
	border-collapse: collapse;
}
th, td {
	padding: 5px;
	border-top: 1px solid #e8e8e8;
	border-bottom: 1px solid #e8e8e8;
	color: #757575;
}
th {
	width: 100px;
	background-color: #FFFFF;
}
td {
	width: 400px;
}
.title, .content {
	text-align: left;
	color : black;
}
.content {
	height: 100px;
	vertical-align: middle;
}
#board_menu {
	text-align: right;
	margin: 5px;
}
#listBtn {
	border : 1px solid #d7d5d5;
}
</style>
<div id="board_detail">
	<h3>NOTICE</h3>
	<table>
		<tr>
			<th>제목</th>
			<td class="title">
				<%=notice.getN_title()%>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<%=notice.getN_writer()%>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>
				<%=notice.getN_date() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=notice.getN_content().replace("\n", "<br>") %>
			</td>
		</tr>
	</table>	
	<div id="board_menu">
		<%--관리자인 경우에만 태그를 이용하여 링크 제공 --%>
		<% if(loginMember!=null && (loginMember.getStatus()==9)) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>
		<%-- 로그인 사용자인 경우에만 태그를 이용하여 링크 제공 --%>
		<button type="button" id="listBtn">글목록</button>
	</div>

	<%-- 요청 페이지에 값을 전달하기 위한 form 태그 --%>
	<form action="<%=request.getContextPath()%>/index.jsp" method="get" id="menuForm">
		<input type="hidden" name="workgroup" value="board">
		<input type="hidden" name="work" id="work">
	
		<%-- [글변경] 및 [글삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="n_no" value="<%=notice.getN_no()%>">
		
		<%-- [글변경] 및 [글목록]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">		
	</form>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#work").val("notice_modify");
	$("#menuForm").submit();
});
$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#work").val("notice_remove_action");
		$("#menuForm").submit();
	}
});
$("#replyBtn").click(function() {
	$("#work").val("notice_write");
	$("#menuForm").submit();
});
$("#listBtn").click(function() {
	$("#work").val("notice");
	$("#menuForm").submit();
});
</script>