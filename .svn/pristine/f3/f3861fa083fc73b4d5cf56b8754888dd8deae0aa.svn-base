<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 제품정보를 입력받기 위한 JSP 문서 --%>
<%-- >관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품등록]을 클릭한 경우 제품정보 삽입페이지(product_add_action.jsp)로 이동 - 입력값 전달 --%>  

<%-- 관리자체크 --%>
<%@include file="/security/admin_check.jspf" %>

<style type="text/css">
#product {
	width: 800px;
	margin: 0 auto;
}
table {
	margin: 0 auto;
}
td {
	text-align: left;
}
</style>

<div id="product">
	<h2>제품등록</h2>
	<%-- 사용자로부터 파일을 입력받아 요청 페이지로 전달하기 위해서는 반드시 form 태그의
	enctype 속성값을 [multipart/form-data]으로 설정 --%>
	<%-- <form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product_add_action" --%>
	<form action="<%=request.getContextPath() %>/admin/product_add_action.jsp" 
		method="post" enctype="multipart/form-data" id="productForm">
		<table>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="p_cate" id="p_cate">
						<option value="OUTER">OUTER</option>
						<option value="TOP">TOP</option>
						<option value="BOTTOM">BOTTOM</option>
						<option value="ACC">ACC</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>
					<input type="text" name="p_name" id="p_name">
				</td>
			</tr>
			<tr>
				<td>대표이미지</td>
				<td>
					<input type="file" name="p_img" id="p_img">
				</td>
			</tr>
			<tr>
				<td>상세이미지</td>
				<td>
					<input type="file" name="p_info" id="p_info">
				</td>
			</tr>
			<tr>
				<td>제품수량</td>
				<td>
					<input type="text" name="p_amount" id="p_amount">
				</td>
			</tr>
			<tr>
				<td>제품가격</td>
				<td>
					<input type="text" name="p_price" id="p_price">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">제품등록</button>
				</td>
			</tr>
		</table>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<%-- 입력하지 않은 값에 대한 메세지 --%>
<script>
$("#productForm").submit(function() {
	if($("#name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#p_img").val()=="") {
		$("#message").text("대표이미지를 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#p_info").val()=="") {
		$("#message").text("상세이미지를 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#p_amount").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#p_price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
});	
</script>