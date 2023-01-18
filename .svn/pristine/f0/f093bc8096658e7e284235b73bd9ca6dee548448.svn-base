<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	//전달값을 반환받아 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	//int r_pcno=Integer.parseInt(request.getParameter("r_pcno"));
	//int r_code=Integer.parseInt(request.getParameter("r_code"));
	int r_status=1;
	String r_content=Utility.escapeTag(request.getParameter("r_content"));
	String r_pname=request.getParameter("r_pname");
	
	//ReviewDTO 객체를 생성하여 전달값으로 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setR_no(r_no);
	review.setR_id(loginMember.getId());
	review.setR_content(r_content);
	//review.setR_code(r_code);
	//review.setR_pcno(r_pcno);
	review.setR_status(r_status);
	review.setR_pname(r_pname);
	
	//게시글을 전달받아 Review 테이블에 저장된 해당 게시글을 변경하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().updateReview(review);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review_detail&r_no="+r_no
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>