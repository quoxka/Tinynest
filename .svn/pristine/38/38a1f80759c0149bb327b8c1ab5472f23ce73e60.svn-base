<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<% 
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("r_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");

	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReview(r_no);
	
	//검색된 게시글이 없거나 삭제 게시글인 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(review==null || review.getR_status()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
		
	//게시글 작성자 및 관리자가 아닌 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(!loginMember.getId().equals(review.getR_id()) && loginMember.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
%>

<style type="text/css">
h2 {
	margin-left: 150px;
	margin-bottom: 15px;
	font-size : 12px;
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
#reviewModify {margin-left: 500px;}
</style>
<div id="reviewModify">
	<h2>글변경</h2>
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_modify_action"
		method="post" id="boardForm">
	
		<input type="hidden" name="r_no" value="<%=r_no%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">	
		<input type="hidden" name="search" value="<%=search%>">	
		<input type="hidden" name="keyword" value="<%=keyword%>">
		
		<table>
			<tr>
				<th>구매상품</th>
				<td>
					<span></span>
				</td>
			</tr>		
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="r_content" id="r_content"></textarea>
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
$("#boardForm").submit(function() {
	
	if($("#r_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#r_content").focus();
		return false;
	}
});
</script>