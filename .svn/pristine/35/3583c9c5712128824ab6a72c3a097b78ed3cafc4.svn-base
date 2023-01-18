<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="product";
	
	String work=request.getParameter("work");
	if(work==null) work="product_list";
	
	String contentPath=workgroup+"/"+work+".jsp";
	
	String headerPath="main/header.jsp";
	if(workgroup.equals("admin")) { //관리자 관련 페이지를 요청한 경우
		headerPath="admin/header.jsp";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tinynest</title>
<link href="main/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<%-- Header --%>
	<%-- <jsp:include page="header.jsp"/> --%>
	<jsp:include page="<%=headerPath %>"/>
	
	
	<%-- Content --%>
	<div id="content">
		<jsp:include page="<%=contentPath %>"/>
	
	
		<%-- Footer --%>
		<div id="footer">
			<jsp:include page="main/footer.jsp"/>
		</div>
	</div>
</body>
</html>