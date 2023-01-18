<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("r_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//전달값 반환받아 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	//글번호를 전달받아 review 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReview(r_no);
	
	if(review==null || review.getR_status()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//게시글 작성자 및 관리자가 아닌 경우 에러페이지로 이동되도록 응답 처리 - 비정상적인 요청
	if(!loginMember.getId().equals(review.getR_id()) && loginMember.getStatus()!=9 ) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//글번호를 전달받아 review 테이블에 저장된 해당 글번호의 게시글에 대한 STATUS 컬럼값을 [0]으로 변경하는 DAO 클래스의 메소드 호출
	review.setR_status(0);
	ReviewDAO.getDAO().updateReview(review);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review';");
	out.println("</script>");
%>