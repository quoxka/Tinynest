<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tinynest</title>
<style>
div {
	width: 400px;
	height: 300px;
	padding: 50px;
	margin: 0 auto;
}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
<div align="center">
	<img src="<%=request.getContextPath()%>/purchase/images/waiter.png" width="400px"><br>
	<h2>옆자리 신사 분께서 결제하셨습니다.</h2>
	<button type="button" id="closeBtn">닫기</button>
</div>

<script type="text/javascript">
$("#closeBtn").click(function() {
	opener.parent.location = "<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_list";
	window.close();
});
</script>
</body>
</html>