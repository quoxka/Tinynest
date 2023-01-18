<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
%>  

<%-- 오른쪽 상단 메뉴 --%>
<div id="profile" style="text-align: right;margin: 0px 30px 0 0;"> 
	<% if(loginMember==null) {//비로그인 사용자인 경우 %>
	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=members&work=member_login2" class="header">SIGN IN</a>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=members&work=member_join2" class="header">JOIN</a>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=basket&work=basket" class="header">CART</a>
	<% } else {//로그인 사용자인 경우  %>
	<span class="bar" class="header"><%=loginMember.getName() %>님 환영합니다.</span>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
	<a href="<%=request.getContextPath() %>/members/logout_action.jsp" class="header">LOGOUT</a>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=basket&work=basket" class="header">CART</a>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=members&work=mypage" class="header">MY PAGE</a>
	<span class="bar" class="font2">&nbsp;&nbsp;/&nbsp;&nbsp;</span>
		<% if(loginMember.getStatus()==9) {//로그인 사용자가 관리자인 경우 %>
			<a href="index.jsp?workgroup=admin&work=main_member" class="header">관리자</a>&nbsp;&nbsp;
		<% } %>
	<% } %>	
	
</div>           

<%-- 왼쪽 상단 로고  --%>
<h1 class="logo">
	<div style="display:flex; padding:10px 0 30px 20px;">
		<a href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_list" class="font1">Tinynest</a>
	</div>
</h1>    

<%-- 왼쪽 메뉴 --%>
<div id="left_menu" style="height: 0px; width: 0px;">
	<div id="menu">
	  <div style="display:flex flex-direction:column;padding:0 0 0 20px;line-height:1.5em;">
	       <a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_list&p_cate=OUTER">OUTER</a><br>
	       <a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_list&p_cate=TOP">TOP</a><br>
	       <a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_list&p_cate=BOTTOM">BOTTOM</a><br>
	       <a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_list&p_cate=ACC">ACC</a><br>
		</div>
	</div>
	<div id="under_menu1"></div>
	<div style="display:flex; flex-direction:column;padding:50px 0 0 20px;line-height:1.5em;">
		<a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=notice">NOTICE</a>
	</div>   
	   
	<div id="under_menu2">
		<div style="display:flex;padding:0 0 20px 20px;line-height:1.5em;">
			<a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=review">REVIEW</a>
			<span class="bar">&nbsp;&nbsp;&nbsp;</span>
			<a class="font2" href="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=qna">Q/A</a>
		</div>  
	</div>   
	<%-- 왼쪽 메뉴 아래 검색창 --%>   
	<fieldset>
	
	<div style=" flex-direction:column"></div>
	<div id="text">
	
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=search" method="post">
		<input type="text" name="keyword" style="width: 90px; border: none;">
		<button type="submit"><img src="<%=request.getContextPath() %>/images/btn_search.png" style="float: right; margin:-10px -10px -8px -10px;cursor:pointer"></button>
	</form>
	
	
	</div>
	</fieldset>  
	
	<%-- 검색창 아래 SNS 연동 부분 --%>
	<br><br><br>
	<div id="sns">
		<div class="insta" style="padding:0 0 0 20px;display:flex;">
			<a href="https://www.instagram.com/" target="blank">
				<img src="<%=request.getContextPath() %>/images/sns_01.jpg" width="20px">
			</a>
	
		<div class="kakao" style="padding:0 0 0 10px;">
			<a href="https://kakao.com/" target="blank">
				<img src="<%=request.getContextPath() %>/images/sns_02.jpg" width="20px">
			</a>
		</div>
		</div>
	</div>
</div>

<script type="text/javascript">

</script>