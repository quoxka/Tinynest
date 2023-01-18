<%@page import="tinynest.dao.QnaDAO"%>
<%@page import="tinynest.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%	
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("q_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//전달값 반환받아 저장
	int q_no=Integer.parseInt(request.getParameter("q_no"));
	
	
	QnaDTO qna=QnaDAO.getDAO().selectQna(q_no);
	
	if(qna==null || qna.getQ_status()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//게시글 작성자 및 관리자가 아닌 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(!loginMember.getId().equals(qna.getQ_id()) && loginMember.getStatus()!=9 ) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	qna.setQ_status(0);
	QnaDAO.getDAO().updateQna(qna);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=qna';");
	out.println("</script>");
%>