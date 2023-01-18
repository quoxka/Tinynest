<%@page import="tinynest.dao.MemberDAO"%>
<%@page import="tinynest.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디를 전달받아 MEMBER 테이블에 저장된 기존 회원정보의 아이디와 비교하여 중복 유무를
클라이언트에게 전달하는 JSP 문서 --%>
<%-- ㄴ 아이디 미중복 : 아이디 사용 가능 메세지 출력 - [아이디 사용]을 클릭한 경우 부모창의 입력태그의 입력값 변경 --%>
<%-- => 아이디 중복 : 아이디 사용 불가능 메세지 - 아이디를 입력받아 현재 JSP 문서를 재요청 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("id")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 검색하여 반환하는 DAO 클래스 메소드 호출
	//ㄴ null 반환 : 전달받은 아이디의 회원정보 미검색 - 아이디 미중복(사용가능)
	//ㄴ MemberDTO 객체 반환 : 전달받은 아이디 회원정보 검색 - 아이디 중복(사용불가)
	MemberDTO member=MemberDAO.getDAO().selectMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Id_Check</title>
<style type="text/css">
div {text-align: center; margin: 30px; font-size: 11px; font-style: none;}
.font_gray {font-weight: bold; color:gray; font-size: 13px; opacity: 80%}
button {font-size: 11px; font-style: none;}
</style>
</head>
<body>
	<% if(member==null) { //전달받은 아이디가 중복되지 않은 경우 %>
		<div>입력된 <span class="font_gray">[<%=id %>]</span>는 사용 가능한 아이디 입니다.</div>
		<div>
			<button type="button" onclick="selectId();">아이디 사용</button>
		</div>
		
		<script type="text/javascript">
		function selectId() {
			//opener : 팝업창을 실행한 부모창을 표현한는 JavaScript 객체
			opener.join.id.value="<%=id%>"; //입력태그(아이디)의 입력값 변경
			opener.join.idCheckResult.value="1";
			window.close(); //창닫기
		}
		</script>
	<% } else { //전달받은 아이디가 중복된 경우 %>
		<div id="message">입력된 <span class="font_gray">[<%=id %>]</span>는 이미 사용중인 아이디 입니다.
		<br>다른 아이디를 입력하고 <span class="font_gray">[확인]</span> 버튼을 눌러주세요.</div>
		<div>
			<%-- form 태그의 action 속성이 생략된 경우 현재 요청 JSP 문서를 재요청 --%>
			<%-- form 태그의 method 속성이 생략된 경우 [GET] 방식으로 요청 --%>
			<form name="checkForm">
				<input type="text" name="id">
				<button type="button" onclick="idCheck();">확인</button>
			</form>
		</div>
		
		<script type="text/javascript">
		function idCheck() {
			var id=checkForm.id.value;
			if(id=="") {
				document.getElementById("message").innerHTML="아이디를 입력해주세요.";
				return;
			}
			
			var idReg=/^[a-z]\w{3,15}$/g;
			if(!idReg.test(id)) {
				document.getElementById("message").innerHTML="아이디를 형식에 맞게 입력해주세요.";
				return;
			}
			checkForm.submit();
		}
		</script>
	<% } %>
</body>
</html>