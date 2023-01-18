<%@page import="tinynest.dao.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	String loginId = loginMember.getId();
	
	request.setCharacterEncoding("utf-8");
	
	//비정상적인 요청 검증
	if (request.getParameter("item") == null && request.getParameter("all").equals("0")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	if (request.getParameter("all").equals("1")) {
		BasketDAO.getDAO().deleteAllBasket(loginId);
	} else {		
		String[] items = request.getParameterValues("item");
		for (String item : items) {
			int rows=BasketDAO.getDAO().deleteBasket(loginId, Integer.parseInt(item));
		}
	}
%>