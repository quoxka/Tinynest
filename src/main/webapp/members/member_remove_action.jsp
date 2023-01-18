<%@page import="tinynest.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디 목록을 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 삭제하고 회원정보
관리페이지(main_member.jsp)로 이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 --%>


<%--관리자만 요청 가능한 문서--%>
<%@include file="/security/login_url.jspf"%>


<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
		
	MemberDAO.getDAO().updateStatus(loginMember.getId(), 0);
	
	session.invalidate();
	
	//페이지이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=members&work=remove_page';");
	out.println("</script>");
	
%>