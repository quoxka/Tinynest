<%@page import="tinynest.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 로그인 사용자의
정보를 입력태그의 초기값으로 설정하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [회원변경]을 클릭한 경우 회원정보 변경페이지(modify_action.jsp)로 이동 - 입력값 전달 --%>
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
	String pw=Utility.encrypt(request.getParameter("pw"));
	
	//전달된 비밀번호가 로그인 사용자의 비밀번호와 같지 않은 경우 비밀번호 입력페이지
	//(password_confirm.jsp)로 이동
	if(!pw.equals(loginMember.getPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=members&work=pw_confirm&action=modify';");
		out.println("</script>");
		return;
	}
%>    
<style type="text/css">

#join {margin-left: 300px;}
.error {color: red; display: none;}
#modifyTitle {margin-left: 300px; margin-bottom: 50px; font-size: 10px; font-weight: normal;}
button {border: none; background-color: white;}
li {list-style-type: none; margin-bottom: 10px;}
input {height: 20px;}
select {height: 26px;}
label{color: gray;}

</style>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<div id="modifyTitle">MODIFY</div>
<form id="join" action="index.jsp?workgroup=members&work=modify_action" method="post">
<fieldset>
	<ul>
		<li>
			<label for="id">ID</label><br>
			<input type="text" name="id" id="id" value="<%=loginMember.getId()%>" readonly="readonly">
		</li>
		<li>
			<label for="pw">PASSWORD</label><br>
			<input type="password" name="pw" id="pw">
			<span style="color: red;">&nbsp;&nbsp;비밀번호를 변경하지 않을 경우 입력하지 마세요.</span>
			<div id="pwRegMsg" class="error">비밀번호는 영문자,숫자,특수문자의 조합으로 된 10~16 범위의 문자로만 작성 가능합니다.</div>
		</li>
		<li>
			<label for="name">이름</label><br>
			<input type="text" name="name" id="name" value="<%=loginMember.getName()%>" >
			<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		</li>
			<li>
			<label>우편번호</label><br>
			<input type="text" name="zipcode" id="zipcode" size="5" value="<%=loginMember.getZipcode()%>"  readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;
			<span id="postSearch"><img src="<%=request.getContextPath() %>/members/images/postSearch.png" alt="postSearch"></span>
			<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address1">기본주소</label><br>
			<input type="text" name="address1" id="address1" size="60" value="<%=loginMember.getAddress1()%>"  readonly="readonly">
			<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address2">상세주소</label><br>
			<input type="text" name="address2" id="address2" size="60" value="<%=loginMember.getAddress2()%>" >
			<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="phone">PHONE</label><br>
			<% String[] phone=loginMember.getPhone().split("-"); %>
			<select name="phone1">
				<option value="010" <% if(phone[0].equals("010")) { %> selected <% } %>>&nbsp;010&nbsp;</option>
				<option value="011" <% if(phone[0].equals("011")) { %> selected <% } %>>&nbsp;011&nbsp;</option>
				<option value="016" <% if(phone[0].equals("016")) { %> selected <% } %>>&nbsp;016&nbsp;</option>
				<option value="017" <% if(phone[0].equals("017")) { %> selected <% } %>>&nbsp;017&nbsp;</option>
				<option value="018" <% if(phone[0].equals("018")) { %> selected <% } %>>&nbsp;018&nbsp;</option>
				<option value="019" <% if(phone[0].equals("019")) { %> selected <% } %>>&nbsp;019&nbsp;</option>
			</select>
			- <input type="text" name="phone2" id="phone2" size="4" maxlength="4" value="<%=phone[1]%>">
			- <input type="text" name="phone3" id="phone3" size="4" maxlength="4" value="<%=phone[2]%>">
			<div id="phoneMsg" class="error">전화번호를 입력해 주세요.</div>
			<div id="phoneRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
		</li>
		<li>
			<label for="email">E-MAIL</label><br>
			<input type="text" name="email" id="email" value="<%=loginMember.getEmail()%>" >
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
			<div id="emailRegMsg" class="error">이메일을 형식(xxx@xxx.xxx)에 맞게 입력해 주세요.</div>
		</li>
	</ul>
</fieldset>
<div style="margin-top: 15px;">
	<button type="submit"><img src="<%=request.getContextPath() %>/members/images/modify.png" alt="회원변경"></button>
	<button type="reset"><img src="<%=request.getContextPath() %>/members/images/reset.png" alt="초기화"></button>
</div>
</form>
<script type="text/javascript">
$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");

	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{9,15}$/g;
	if($("#pw").val()!="" && !pwReg.test($("#pw").val())) {
		$("#pwRegMsg").css("display","block");
		submitResult=false;
	} 

	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	var phone2Reg=/\d{3,4}/;
	var phone3Reg=/\d{4}/;
	if($("#phone2").val()=="" || $("#phone3").val()=="") {
		$("#phoneMsg").css("display","block");
		submitResult=false;
	} else if(!phone2Reg.test($("#phone2").val()) || !phone3Reg.test($("#phone3").val())) {
		$("#phoneRegMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {
	new daum.Postcode({
	    oncomplete: function(data) {
	        $("#zipcode").val(data.zonecode);
	        $("#address1").val(data.address);
	    }
	}).open();
});

//뒤로가기 방지(body에도 설정해야함)
window.history.forward(); function noBack(){ 
	window.history.forward();
}
</script>