<%@page import="tinynest.dao.NoticeDAO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	//전달값을 반환받아 저장
	int n_no=Integer.parseInt(request.getParameter("n_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	String n_title=Utility.escapeTag(request.getParameter("n_title"));
	int n_status=1;
	String n_content=Utility.escapeTag(request.getParameter("n_content"));
	
	NoticeDTO notice=new NoticeDTO();
	notice.setN_no(n_no);
	notice.setN_title(n_title);
	notice.setN_content(n_content);
	notice.setN_status(n_status);
	
	NoticeDAO.getDAO().updateNotice(notice);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=notice_detail"
		+"&n_no="+n_no+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>