<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(request.getParameter("login")!=null) {//전달값이 있는 경우
		//메인페이지로 이동되도록 세션에 저장된 기존 요청 URL 주소를 제거 
		session.removeAttribute("returnUrl");
	}

	//아이디 또는 비밀번호가 규격에 맞지 않을 시
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
	
%>    
<style type="text/css">

#LoginTitle{margin-left: 300px; margin-bottom: 50px; font-size: 10px; font-weight: normal;}
#login {margin-left: 400px;	margin-top: 150px;}
li {list-style-type: none;}
label {color:gray;}
input {height: 22px;}
#login_btn {margin-left: 40px; margin-top: 20px;}
#message {color: red; margin-left: 40px;}

</style>
<div id="LoginTitle">SIGN IN</div>
<div id="space"></div>
<form id="login" name="loginForm" action="index.jsp?workgroup=members&work=login_action" method="post">
	<ul class="login_tag">
		<li>
			<label for="id">ID</label><br>
			<input type="text" name="id" id="id" value="<%=id%>">
		</li>
		<li>
			<label for="pw">PASSWORD</label><br>
			<input type="password" name="pw" id="pw">
		</li>
	</ul>
	<div id="login_btn"><img src="<%=request.getContextPath() %>/members/images/Login.png"></div>
	<div id="message"><%=message %></div>
</form>
<script type="text/javascript">
$("#id").focus();

$("#login_btn").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}
	
	if($("#pw").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#pw").focus();
		return;
	}
	
	$("#login").submit();
});

</script>