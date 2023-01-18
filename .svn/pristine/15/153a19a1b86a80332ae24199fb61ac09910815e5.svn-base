<%@page import="java.util.List"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	String pageNum="1";
	//pageNum=request.getParameter("pageNum");
	
	int pc_code = Integer.parseInt(request.getParameter("pc_code"));
	int r_pcno = Integer.parseInt(request.getParameter("r_pcno"));
	
	ProductDTO product = ProductDAO.getDAO().selectProduct(pc_code);
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
#r_content {
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
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_write_action"
	method="post" id="boardForm">

	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="r_id" value="<%=loginMember.getId()%>">
	<input type="hidden" name="r_pcno" value="<%=r_pcno%>">
	<input type="hidden" name="r_code" value="<%=pc_code%>">
	<input type="hidden" name="r_pname" value="<%=product.getP_name()%>">

	<h2>REVIEW</h2>		
	
	<table>
		<tr>
			<th>구매상품</th>
			<td>
				<span><%= product.getP_name() %></span>
			</td>
		</tr>		
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="r_content" id="r_content"></textarea>
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
$("#boardForm").submit(function() {
	
	if($("#r_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#r_content").focus();
		return false;
	}
});
</script>