<%@page import="tinynest.util.Utility"%>
<%@page import="tinynest.dto.QnaDTO"%>
<%@page import="tinynest.dao.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}
	//전달값을 반환받아 저장
	int re_qna=Integer.parseInt(request.getParameter("re_qna"));
	int re_qnastep=Integer.parseInt(request.getParameter("re_qnastep"));
	int re_qnalevel=Integer.parseInt(request.getParameter("re_qnalevel"));
	String pageNum=request.getParameter("pageNum");
	
	//사용자로부터 입력받아 전달된 값에 태그 관련 문자가 존재할 경우 회피문자로 변경하여 저장
	String q_title=Utility.escapeTag(request.getParameter("q_title"));
	int q_status=1;
	if(request.getParameter("secret")!=null) {
		q_status=Integer.parseInt(request.getParameter("secret"));
	}
	String q_content=Utility.escapeTag(request.getParameter("q_content"));
	
	//qna_SEQ 시퀸스의 다음값(자동 증가값)을 검색하여 반환
	int q_no=QnaDAO.getDAO().selectNextNum();
	
	//새글과 답글을 구분하여 qna 테이블의 컬럼값으로 저장될 변수값 변경
	if(re_qna==0) {//새글인 경우
		re_qna=q_no;
	} else {//답글인 경우
		QnaDAO.getDAO().updateQnaStep(re_qna, re_qnastep);
		re_qnastep++;
		re_qnalevel++;
	}
	
	
	
	//qnaDTO 객체를 생성하여 변수값으로 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQ_no(q_no);
	qna.setQ_title(q_title);
	qna.setQ_id(loginMember.getId());
	qna.setQ_content(q_content);
	qna.setRe_qna(re_qna);
	qna.setRe_qnastep(re_qnastep);
	qna.setRe_qnalevel(re_qnalevel);
	qna.setQ_status(q_status);
	//게시글을 전달받아 QNA 테이블에 삽입하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().insertQna(qna);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=qna&pageNum="+pageNum+"';");
	out.println("</script>");
%>