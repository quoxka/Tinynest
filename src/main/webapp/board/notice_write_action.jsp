<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dto.NoticeDTO"%>
<%@page import="tinynest.dao.NoticeDAO"%>
<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/security/admin_check.jspf"%> --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}
	//전달값을 반환받아 저장
	String pageNum=request.getParameter("pageNum");

	String n_title=Utility.escapeTag(request.getParameter("n_title"));
	int n_status=1;
	String n_content=Utility.escapeTag(request.getParameter("n_content"));
	
	//notice 시퀸스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int n_no=NoticeDAO.getDAO().selectNextNum();
	
	//아이디 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	NoticeDTO notice=new NoticeDTO();
	notice.setN_no(n_no);
	notice.setN_id(loginMember.getId());
	notice.setN_title(n_title);
	notice.setN_status(n_status);
	notice.setN_content(n_content);
	
	//게시글을 전달받아 notice 테이블에 삽입하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().insertNotice(notice);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=notice&pageNum="+pageNum+"';");
	out.println("</script>");
%>