<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	String re_qna="0",re_qnastep="0",re_qnalevel="0",pageNum="1";
	if(request.getParameter("re_qna")!=null) {//전달값이 있는 경우(답글인 경우)
		re_qna=request.getParameter("re_qna");
		re_qnastep=request.getParameter("re_qnastep");
		re_qnalevel=request.getParameter("re_qnalevel");
		pageNum=request.getParameter("pageNum");
	}
%>
<style type="text/css">
h2 {
	margin : 0 auto;
	text-align: center;
	margin-bottom: 15px;
	font-size : 12px;
}
table {
	margin: 0 auto;
	border:1px solid #d7d5d5;
}
input {
	border:1px solid #d7d5d5;
}
textarea {
	border:1px solid #d7d5d5;
}
th {
	width: 80px;
	font-weight: normal;
}
td {
	text-align: left;
}
#q_content {
	width : 900px;
	min-height: 400px;
}
.Btn {
	margin: 0 auto;
	text-align: center;
	margin-top: 10px;
}
#registBtn {
	color : #FFF;
	background-color : #999;
	border:1px solid #999;
}
#resetBtn {
	border : 1px solid #d7d5d5;
}
#message {
	margin :0 auto;
	padding-top : 8px;
	text-align: center;
}
</style>
<% if(re_qna.equals("0")) {//새글인 경우 %>
	<h2>Q/A</h2>
<% } else {//답글인 경우 %>
	<h2>답글쓰기</h2>
<% } %>

<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_write_action"
	method="post" id="boardForm">
	<input type="hidden" name="re_qna" value="<%=re_qna%>">	
	<input type="hidden" name="re_qnastep" value="<%=re_qnastep%>">	
	<input type="hidden" name="re_qnalevel" value="<%=re_qnalevel%>">	
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th class="title">제목</th>
			<td>
				<input type="text" name="q_title" id="subject" size="100">
				<input type="checkbox" name="secret" value="2">비밀글
			</td>	
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="q_content" id="q_content"></textarea>
			</td>
		</tr>
	</table>
	<div id="message" style="color: red;"></div>
	<div class="Btn">
		<button type="submit" id="registBtn">등록</button>
		<button type="reset" id="resetBtn">다시쓰기</button> 
	<!-- <button type="button" id="cancleBtn" onclick="javascript:history.back(-1)">취소</button> -->
	</div>
</form>


<script type="text/javascript">
$("#subject").focus();
$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#q_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#q_content").focus();
		return false;
	}
});
$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>