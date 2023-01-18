<%@page import="tinynest.dto.ReviewDTO"%>
<%@page import="tinynest.dao.ReviewDAO"%>
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
	
	String pageNum=request.getParameter("pageNum");
	int r_pcno=Integer.parseInt(request.getParameter("r_pcno"));
	int r_code=Integer.parseInt(request.getParameter("r_code"));
	int r_status=1;
	String r_content=Utility.escapeTag(request.getParameter("r_content"));
	int r_no=ReviewDAO.getDAO().selectNextNum();
	String r_pname=request.getParameter("r_pname");

	
	ReviewDTO review=new ReviewDTO();
	review.setR_no(r_no);
	review.setR_id(loginMember.getId());
	review.setR_content(r_content);
	review.setR_code(r_code);
	review.setR_pcno(r_pcno);
	review.setR_status(r_status);
	review.setR_pname(r_pname);
	
	ReviewDAO.getDAO().insertReview(review);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review&pageNum="+pageNum+"';");
	out.println("</script>");
%>