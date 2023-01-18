<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 사용자의 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [회원정보변경]을 클릭한 경우 비밀번호 입력페이지(pw_confirm.jsp)로 이동 - 페이지 이동 관련 정보 전달 --%>
<%-- => [회원탈퇴]를 클릭한 경우 비밀번호 입력페이지(pw_confirm.jsp)로 이동 - 페이지 이동 관련 정보 전달 --%>


<%@include file="/security/login_check.jspf" %>    
<style type="text/css">
#myinfo{margin-left: 300px;}
#detail{margin-bottom: 50px;}
#myinfoTitle{margin-left: 300px; margin-bottom: 100px; font-size: 10px; font-weight: normal;}
</style>
<div id="myinfoTitle">MY INFO</div>
<div id="myinfo">
	<h1>내정보</h1>
	<br>
	<div id="detail">
		<p>id) <%=loginMember.getId() %></p>
		<p>name) <%=loginMember.getName() %></p>
		<p>email) <%=loginMember.getEmail() %></p>
		<p>phone) <%=loginMember.getPhone() %></p>
		<p>address) [<%=loginMember.getZipcode() %>]<%=loginMember.getAddress1() %> <%=loginMember.getAddress2() %></p>
	</div>
	<div id="link">
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=members&work=pw_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=members&work=pw_confirm&action=remove">[회원탈퇴]</a>&nbsp;&nbsp;
	</div>
</div>