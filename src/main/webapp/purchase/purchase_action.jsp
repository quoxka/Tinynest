<%@page import="java.util.Arrays"%>
<%@page import="tinynest.util.Utility"%>
<%@page import="tinynest.dto.PurchaseDTO"%>
<%@page import="tinynest.dao.PurchaseDAO"%>
<%@page import="tinynest.dao.BasketDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tinynest.dto.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	if (request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}

	request.setCharacterEncoding("utf-8");

	//로그인 중인 아이디
	String loginId = loginMember.getId();
	
	//결제 완료 응답값이 없으면 결제창으로 이동
	if (request.getParameter("pay") == null || !request.getParameter("pay").equals("OK")) {
		request.getRequestDispatcher("purchase_payment_form.jsp").forward(request, response);
		return;
	}
	
	//결제를 위한 정보 - purchase.jsp에서 받아온 form 데이터
	String item = request.getParameter("items");//상품코드를 공백으로 구분하여 하나의 문자열로 만든 것
	String[] items = item.split(" ");
	
	String name = request.getParameter("destinationName");
	String zipcode = request.getParameter("destinationZipcode");
	String address1 = request.getParameter("destinationAddress1");
	String address2 = Utility.stripTag(request.getParameter("destinationAddress2"));
	String phone = request.getParameter("destinationPhone1") + "-"
			+ request.getParameter("destinationPhone2") + "-"
			+ request.getParameter("destinationPhone3");

	
	List<BasketDTO> productList = new ArrayList<>();
	
	for (String itemCode : items) {
		BasketDTO basket = BasketDAO.getDAO().selectBasketByBcode(loginId, Integer.parseInt(itemCode));
		productList.add(basket);
	}
	
	for (BasketDTO product : productList) {			
		PurchaseDTO purchaseItem = new PurchaseDTO();
		purchaseItem.setPcId(loginId);
		purchaseItem.setPcCode(product.getbCode());
		purchaseItem.setPcAmount(product.getbAmount());
		purchaseItem.setPcPrice(product.getpPrice() * product.getbAmount());
		purchaseItem.setPcLname(name);
		purchaseItem.setPcLphone(phone);
		purchaseItem.setPcZipcode(zipcode);
		purchaseItem.setPcLaddress1(address1);
		purchaseItem.setPcLaddress2(address2);
		PurchaseDAO.getDAO().insertPurchase(purchaseItem);
		//결제된 상품은 장바구니에서 삭제
		BasketDAO.getDAO().deleteBasket(loginId, product.getbCode());
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.replace('"+request.getContextPath()+"/purchase/purchase_payment_complete.jsp');");
	out.println("</script>");
	
%>