<%@page import="java.text.DecimalFormat"%>
<%@page import="java.awt.Image"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여
클라이언트에게 전달하는 JSP 문서--%>
<%-- > 관리자만 요청 가능한 JSP문서--%>
<%-- > [제품정보변경]을 클릭한 경우 제품정보 입력페이지(product_modify.jsp)로 이동 - 제품번호 전달--%>

<%-- 관리자 검증 --%>
<%@include file="/security/admin_check.jspf" %>

<%

	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("p_code")==null){
		out.println("<script type='text'/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int p_code=Integer.parseInt(request.getParameter("p_code"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여
	//반환하는 DAO 클래스의 메소드 호출 
	ProductDTO product=ProductDAO.getDAO().selectProduct(p_code);
	
	
	//검색된 제품정보가 없는 경우 에러페이지로 이동하여 응답 처리- 비정상적인 요청
	if(product==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}


%>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">
table{
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
}

.title{
	background-color: black;
	color: white;
	text-align: center;
	width: 100px;
}

.value{
	padding: 5px;
	text-align: left;
	width: 500px;
}
#btn{
	text-align: center;
	padding:10px;
	
}

</style>


<table>
		<tr>
			<td class="title">제품번호</td>
			<td class="value"><%=product.getP_code() %></td>
		</tr>
		<tr>
			<td class="title">카테고리</td>
			<td class="value"><%=product.getP_cate() %></td>
		</tr>
		<tr>
			<td class="title">제품명</td>
			<td class="value"><%=product.getP_name() %></td>
		</tr>
		<tr>
			<td class="title">대표이미지</td>
			<td class="value">
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getP_img()%>" width="200">
			</td>
		</tr>
		<tr>
			<td class="title">상세이미지</td>
			<td class="value">
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getP_info()%>" width="200">
			</td>
		</tr>
		<tr>
			<td class="title">제품수량</td>
			<td class="value"><%=DecimalFormat.getInstance().format(product.getP_amount())%></td>
		</tr>
		<tr>
			<td class="title">제품가격</td>
			<td class="value"><%=DecimalFormat.getInstance().format(product.getP_price())%>
			원</td>
		</tr>
</table>


<div id="btn">
	<span><button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_modify&p_code=<%=product.getP_code()%>';">제품정보변경</button></span>
	<button type="button" id="removeBtn">제품삭제</button>
	<button type="button" id="productBtn">제품리스트</button>
</div>




<script type="text/javascript">
$("#removeBtn").click(function() {
	if(confirm("삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_remove_action&p_code=<%=product.getP_code()%>"
	}
});
$("#productBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product"
});

$("#category").change(function() {
	$("#productForm").submit();
	
});
</script>	

















