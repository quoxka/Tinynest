<%@page import="tinynest.dao.QnaDAO"%>
<%@page import="tinynest.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 게시글(새글)을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>
<% 
	QnaDTO qna=new QnaDTO();
	for(int i=1;i<=60;i++) {
		int q_no=QnaDAO.getDAO().selectNextNum();
		qna.setQ_no(q_no);
		qna.setQ_title("qna테스트입니다.");
		qna.setQ_id("two3");
		qna.setQ_content("Was wir wissen, ist ein Tropfen - was wir nicht wissen, ein Ozean-"+i);
		qna.setQ_status(1);
		QnaDAO.getDAO().insertQna(qna);
	} 
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>60개의 테스트 게시글이 삽입 되었습니다.</h1>
</body>
</html>