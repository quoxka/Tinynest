<%@page import="tinynest.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 상품 코드를 전달받아 PRODUCT 테이블에 저장된 해당 상품 정보를 삭제하고 상품관리페이지(product.jsp)로
 이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 --%>

<%--관리자만 요청 가능한 문서--%>
<%@include file="/security/admin_check.jspf"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("p_code")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}

	//전달값 저장
	int p_code=Integer.parseInt(request.getParameter("p_code"));

	//상품코드를 전달받아 PRODUCT 테이블에 저장된 해당 상품을 삭제하고
	//삭제행의 갯수를 반환하는 DAO 클래스 메소드 호출
	ProductDAO.getDAO().deleteProduct(p_code);
	
	//페이지이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=product';");
	out.println("</script>");
%>