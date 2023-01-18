<%@page import="tinynest.dao.NoticeDAO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
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
	
	//글번호를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice(n_no);
	
	//검색된 게시글이 없거나 삭제 게시글인 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(notice==null || notice.getN_status()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	//관리자가 아닌 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(loginMember.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
h2 {
	margin-bottom: 15px;
	font-size : 12px;
	margin-left: 150px;
}
table {
}
th {
	width: 70px;
	font-weight: normal;
}
td {
	text-align: left;
}
#message {
	padding-top : 8px;
	text-align: center;
}
#noticeModify {margin-left: 500px;}
</style>
<div id="noticeModify">
	<h2>글변경</h2>
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_modify_action"
		method="post" id="boardForm">
		<input type="hidden" name="n_no" value="<%=n_no%>">	
		<input type="hidden" name="pageNum" value="<%=pageNum%>">	
		<input type="hidden" name="search" value="<%=search%>">	
		<input type="hidden" name="keyword" value="<%=keyword%>">
		<table>
			<tr>
				<th class="title">TITLE</th>
				<td>
					<input type="text" name="n_title" id="n_title" size="40">
				</td>	
			</tr>
			<tr>
				<th></th>
				<td>
					<textarea rows="7" cols="60" name="n_content" id="n_content"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="submit">글저장</button>
					<button type="reset" id="resetBtn">다시쓰기</button>
				</th>
			</tr>
		</table>	
	</form>
	<div id="message" style="color: red;"></div>
</div>
<script type="text/javascript">
$("#n_title").focus();
$("#boardForm").submit(function() {
	if($("#n_title").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#n_title").focus();
		return false;
	}
	
	if($("#n_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#n_content").focus();
		return false;
	}
});
$("#resetBtn").click(function() {
	$("#n_title").focus();
	$("#message").text("");
});
</script>