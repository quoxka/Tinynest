<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dao.MemberDAO"%>
<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인정보를 전달받아 MEMBER 테이블에 저장된 회원정보와 비교하여 인증처리하고 처리결과를
이용하여 클라이언트에게 URL 주소를 전달하는 JSP 문서 --%>
<%-- => 인증실패 : 로그인정보 입력페이지(member_login2.jsp)로 이동 --%>    
<%-- => 인증성공 : 세션에 권한 관련 정보를 저장하고 기존 요청 페이지로 이동하거나 또는  
메인페이지로 이동 --%>    
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	String pw=Utility.encrypt(request.getParameter("pw"));

	
	
	//--인증시작--
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	MemberDTO member=MemberDAO.getDAO().selectMember(id);

	//전달받은 아이디로 검색된 회원정보가 없거나 탈퇴회원인 경우 - 아이디 인증 실패
	if(member==null || member.getStatus()==0) {
		session.setAttribute("message", "입력한 아이디가 존재하지 않습니다.");
		session.setAttribute("id", id);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=members&work=member_login2';");
		out.println("</script>");
		return;
	}
	//검색된 회원정보의 비밀번호와 전달받은 비밀번호가 일치하지 않는 경우 - 비밀번호 인증 실패
	if(!member.getPw().equals(pw)) {
		session.setAttribute("message", "입력한 아이디가 잘못되었거나 비밀번호가 일치하지 않습니다.");
		session.setAttribute("pw", pw);
		
		out.print("<script type='text/javascript'>");
		out.print("location.href='"+request.getContextPath()+"/index.jsp?workgroup=members&work=member_login2';");
		out.print("</script>");
		return;
	}
	//--인증성공--
	
	
	
	//세션에 권한 관련 정보(회원정보) 저장
	session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(id));
	
	//세션에 저장된 요청 페이지의 URL 주소를 반환받아 저장
	String returnUrl=(String)session.getAttribute("returnUrl");
	
	if(returnUrl==null) {//요청 페이지가 없는 경우
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=product&work=product_list';");
		out.println("</script>");
	} else {//요청 페이지가 있는 경우
		session.removeAttribute("returnUrl");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+returnUrl+"';");
		out.println("</script>");
	}
%>














