<%@page import="tinynest.dao.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	//로그인 세션 확인 및 세션에서 회원 아이디 가져와서 저장
	String loginId = loginMember.getId();

	if (request.getParameter("product") == null || request.getParameter("amount") == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	int bCode = Integer.parseInt(request.getParameter("product"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	
	//접속 중인 아이디의 장바구니 목록에 해당 상품코드의 상품이 존재하는지 검증
	if (BasketDAO.getDAO().selectBasketByBcode(loginId, bCode) == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//입력값 : 아이디(loginId), 상품 번호(bCode), 수량(amount) //결과 : BASKET 테이블의 상품 개수를 변경
	BasketDAO.getDAO().updateBasketAmount(loginId, bCode, amount);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=basket&work=basket';");
	out.println("</script>");
%>