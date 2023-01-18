<%@page import="tinynest.dao.QnaDAO"%>
<%@page import="tinynest.dto.QnaDTO"%>
<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>    
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	
	int q_no=Integer.parseInt(request.getParameter("q_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	String q_title=Utility.escapeTag(request.getParameter("q_title"));
	int q_status=1;
	if(request.getParameter("secret")!=null) {
		q_status=Integer.parseInt(request.getParameter("secret"));
	}
	String q_content=Utility.escapeTag(request.getParameter("q_content"));
	
	QnaDTO qna=new QnaDTO();
	qna.setQ_no(q_no);
	qna.setQ_title(q_title);
	qna.setQ_content(q_content);
	qna.setQ_status(q_status);
	
	QnaDAO.getDAO().updateQna(qna);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=qna"
		+"&q_no="+q_no+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>