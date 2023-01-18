<%@page import="tinynest.dto.MemberDTO"%>
<%@page import="tinynest.dao.BasketDAO"%>
<%@page import="tinynest.dto.BasketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- [BUY NOW]을 클릭한 경우 결제페이지(purchase.jsp)로 이동 - QueryString으로 p_code를 전달 --%>
<%-- ㄴ 장바구니에 현재 상품 정보를 추가하고 동일한 상품이 존재할 경우 갯수 증가 --%>
<%@include file="../security/login_url.jspf"%>
<%
	//전달값을 반환받아 저장
	int item=Integer.parseInt(request.getParameter("item")); //item==p_code
	int p_amount=Integer.parseInt(request.getParameter("amount")); //amoumt==상품구입희망갯수
	int btn=Integer.parseInt(request.getParameter("btn")); //0: 장바구니  1: 즉시구매
	
	
	//비정상적인 요청 응답 처리
	if(p_amount==0) { //수량이 0일경우 redirect 전달해 메세지 출력
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=product&work=product_detail&p_code="+item+"&redirect=1';");
		out.println("</script>");
		return;
	}
	if(btn>1 || btn<0) { //버튼이 1또는 0이 아닐경우 에러 처리
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//사용자 id를 반환받아 저장
	String id=loginMember.getId();
	
	//상품 코드를 전달받아 일치하는 값이 있는지 BASKET 테이블과 비교하는 DAO 클래스 메소드 호출
	BasketDTO basket= BasketDAO.getDAO().selectBasketByBcode(id, item);
	BasketDTO basket2 = new BasketDTO();
	basket2.setbCode(item);
	basket2.setbId(id);
	basket2.setbAmount(p_amount);
	
	//현재 상품의 상품코드와 일치하는 값이 장바구니(BASKET 테이블)에 있는지 확인
	if(basket.getbNo()==0) {
		//장바구니에 일치하는 값이 없을 경우 장바구니에 상품 정보를 추가하는 DAO 클래스 메소드 호출
		BasketDAO.getDAO().insertBasket(basket2);
	} else {
		//장바구니에 일치하는 값이 있을 경우 상품 수량 변경
		int amount=basket.getbAmount()+p_amount;
		BasketDAO.getDAO().updateBasketAmount(id, item, amount);
	}
	
	//누른 버튼이 장바구니(ADD TO CART)버튼일 경우 이전페이지(product_detail.jsp)로 이동
	if(btn==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=product&work=product_detail&p_code="+item+"&redirect=2'");
		out.println("</script>");
	}
	//누른 버튼이 구매(BUY NOW)버튼일 경우 결제페이지(ourchase.jsp)로 이동
	if(btn==1) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=purchase&work=purchase&item="+item+"';");
		out.println("</script>");
	}
%>