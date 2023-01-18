<%@page import="tinynest.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/admin_check.jspf"%>


<%
//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("id")==null || request.getParameter("status")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null && request.getParameter("pageNum")!="null" && request.getParameter("pageNum")!="" && request.getParameter("pageNum")!=" "){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}


	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	int status=Integer.parseInt(request.getParameter("status"));
	
	//아이디와 회원상트래를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보에서 회원상태를
	//변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateStatus(id, status);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=main_member&pageNum="+pageNum+"';");
	out.println("</script>");
	
%>