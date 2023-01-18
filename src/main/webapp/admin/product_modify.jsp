<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 정보를 검색하여
입력태그의 초기값으로 설정하고 사용자로부터 변경값을 입력받기 위한 JSP문서--%>
<%-- > 관리자만 요청 가능한 JSP 문서--%>
<%-- > [제품변경]을 클릭한 경우 제품정보 변경페이지(product_modify_action.jsp)로 이동
- 입력값전달 --%>

 <%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("p_code")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	int p_code=Integer.parseInt(request.getParameter("p_code"));
	
	
	//p_code를 전달받아 PRODUCT 테이블에 저장된 해당 p_code의 제품정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출 
	ProductDTO product=ProductDAO.getDAO().selectProduct(p_code);
	
	
	//검색된 제품정보가 없는 경우 에러페이지로 이동하여 응답 처리 - 잘못된 p_code전달 
	
	if(product==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	
%>



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

	<h2>제품변경</h2>
	
	<%-- 사용자로부터 파일을 입력받아 요청 페이지로 전달하기 위해서는 반드시 form 태그의
	enctype 속성값을 [multipart/form-data]으로 설정 --%>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product_modify_action"
		method="post" enctype="multipart/form-data" id="productForm">
		<%-- 변경할 제품정보를 구분하기 우한 식별자로 p-code 전달 --%>
		<input type="hidden" name="p_code" value="<%=product.getP_code()%>">
		
		
		
		<%-- 제품 관련 이미지를 변경하지 않을 경우 기존 제품 관련 이미지를 사용하기 위해 전달하거나 
		제품 관련 이미지를 변경할 경우 기존 제품 관련 이미지를 서버 디렉토리에서 삭제하기 위해 전달--%>
		<input type="hidden" name="currentP_img" value="<%=product.getP_img()%>">
		<input type="hidden" name="currentP_info" value="<%=product.getP_info()%>">
		
		
		<table>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="p_cate" >
						<option value="OUTER" <% if(product.getP_cate().equals("OUTER")) 
						{ %> selected="selected" <% } %>>OUTER</option>
						<option value="TOP" <% if(product.getP_cate().equals("TOP")) 
						{ %> selected="selected" <% } %>>TOP</option>
						<option value="BOTTOM" <% if(product.getP_cate().equals("BOTTOM")) 
						{ %> selected="selected" <% } %>>BOTTOM</option>
						<option value="ACC" <% if(product.getP_cate().equals("ACC")) 
						{ %> selected="selected" <% } %>>ACC</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>
					<input type="text" name="p_name" id="p_name" value="<%=product.getP_name()%>">
				</td>
			</tr>
			<tr>
				<td>대표이미지</td>
				<td>
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getP_img()%>" width="200px">
				<br>
				<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>
				<br>
				<input type="file" name="p_img" id="p_img">
				</td>
			</tr>
			<tr>
				<td>상세이미지</td>
				<td>
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getP_info()%>" width="200px">
				<br>
				<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>
				<br>
				<input type="file" name="p_info" id="p_info">
				</td>
			</tr>
			<tr>
				<td>제품수량</td>
				<td>
					<input type="text" name="p_amount" id="p_amount" value="<%=product.getP_amount()%>">
				</td>
			</tr>
			<tr>
				<td>제품가격</td>
				<td>
					<input type="text" name="p_price" id="p_price" value="<%=product.getP_price()%>">
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


<script>
$("#productForm").submit(function() {
	if($("#p_name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#p_name").focus();
		return false;
	}
	
	if($("#p_amount").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#p_amount").focus();
		return false;
	}
	
	if($("#p_price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#p_price").focus();
		return false;
	}
	
});
</script>










































