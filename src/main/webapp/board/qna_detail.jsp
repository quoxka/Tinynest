<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dao.QnaDAO"%>
<%@page import="tinynest.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("q_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}
	int q_no=Integer.parseInt(request.getParameter("q_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	QnaDTO qna=QnaDAO.getDAO().selectQna(q_no);
	
	if(qna==null || qna.getQ_status()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(qna.getQ_status()==2) {
		if(loginMember==null || !loginMember.getId().equals(qna.getQ_id()) && loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;
		}
	}
	
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
	margin-left: 500px;;
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
	background-color: #FFFFFF;
}
td {
	width: 400px;
}
.subject, .content {
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
	<h3>Q/A</h3>
	<table>
		<tr>
			<th>제목</th>
			<td class="subject">
				<% if(qna.getQ_status()==2) {//비밀 게시글인 경우 %>
					[비밀글]
				<% } %>				
				<%=qna.getQ_title() %>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<%=qna.getQ_writer()%>
				<% if(loginMember!=null && loginMember.getStatus()==9) {//관리자인 경우 %>
				<% } %>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>
				<%=qna.getQ_date() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=qna.getQ_content().replace("\n", "<br>") %>
			</td>
		</tr>
	</table>
	
	<div id="board_menu">
		<%-- 로그인 사용자 중 게시글 작성자이거나 관리자인 경우에만 태그를 이용하여 링크 제공 --%>
		<% if(loginMember!=null && (loginMember.getId().equals(qna.getQ_id()) || loginMember.getStatus()==9)) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>
		<%-- 로그인 사용자인 경우에만 태그를 이용하여 링크 제공 --%>
		<% if(loginMember!=null) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
		<button type="button" id="listBtn">글목록</button>
	</div>

	<%-- 요청 페이지에 값을 전달하기 위한 form 태그 --%>
	<form action="<%=request.getContextPath()%>/index.jsp" method="get" id="menuForm">
		<input type="hidden" name="workgroup" value="board">
		<input type="hidden" name="work" id="work">
	
		<%-- [글변경] 및 [글삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="q_no" value="<%=qna.getQ_no()%>">
		
		<%-- [글변경] 및 [글목록]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
		
		<%-- [답글쓰기]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="re_qna" value="<%=qna.getRe_qna()%>">
		<input type="hidden" name="re_qnastep" value="<%=qna.getRe_qnastep()%>">
		<input type="hidden" name="re_qnalevel" value="<%=qna.getRe_qnalevel()%>">
	</form>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#work").val("qna_modify");
	$("#menuForm").submit();
});
$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#work").val("qna_remove_action");
		$("#menuForm").submit();
	}
});
$("#replyBtn").click(function() {
	$("#work").val("qna_write");
	$("#menuForm").submit();
});
$("#listBtn").click(function() {
	$("#work").val("qna");
	$("#menuForm").submit();
});
</script>