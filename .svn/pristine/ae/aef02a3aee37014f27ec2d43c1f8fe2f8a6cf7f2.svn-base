<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf" %>

<style type="text/css">
#orderList, #myInfo {
	width: 500px;
	height: 100px;
	font-size: 4em;
	margin-left: 320px;
	color: gray;
}
#orderList:hover, #myInfo:hover {font-size: 4.05em; color: black;}
#myPageTitle {margin-left: 300px; margin-bottom: 100px; font-size: 10px; font-weight: normal;}
</style>
<div id="myPageContainer">
	<div id="myPageTitle">MY PAGE</div>
	<div id="orderList">ORDER LIST &nbsp;&nbsp;:)</div>
	<div id="myInfo">MY INFO &nbsp;&nbsp;:(</div>
</div>

<script type="text/javascript">
$("#orderList").click(function() {
	location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=members&work=my_order";
});

$("#myInfo").click(function() {
	location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=members&work=myinfo";
});
</script>