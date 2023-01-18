<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- review 테이블에 게시글(새글)을 저장하는 JSP 문서 - 테스트 프로그램 --%>
<% 
	ReviewDTO review=new ReviewDTO();
	for(int i=1;i<=1;i++) {
		int r_no=ReviewDAO.getDAO().selectNextNum();
		review.setR_no(r_no);
		review.setR_id("two3");
		review.setR_content("옷감이 좋아요-"+i);
		review.setR_code(41);
		review.setR_pcno(53);
		review.setR_status(1);
		ReviewDAO.getDAO().insertReview(review);
	} 
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>1개의 테스트 게시글이 삽입 되었습니다.</h1>
</body>
</html>