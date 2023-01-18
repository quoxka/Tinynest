
<%@page import="tinynest.dao.NoticeDAO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 게시글(새글)을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>
<% 
	NoticeDTO notice=new NoticeDTO();
	for(int i=1;i<=30;i++) {
		int n_no=NoticeDAO.getDAO().selectNextNum();
		notice.setN_no(n_no);
		notice.setN_id("two3");
		notice.setN_title("테스트입니다1.");
		notice.setN_content("게시글 연습2-"+i);
		notice.setN_status(1);
		NoticeDAO.getDAO().insertNotice(notice);
		
	} 
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>30개의 테스트 게시글이 삽입 되었습니다.</h1>
</body>
</html>