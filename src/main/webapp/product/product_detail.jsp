<%@page import="java.math.BigInteger"%>
<%@page import="tinynest.dao.MemberDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="tinynest.dao.ReviewDAO"%>
<%@page import="tinynest.dto.ReviewDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="tinynest.dao.ProductDAO"%>
<%@page import="tinynest.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("p_code")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//전달값 저장
	int p_code=Integer.parseInt(request.getParameter("p_code"));
	String amount=request.getParameter("amount");
	String redirect=request.getParameter("redirect");
	
	
	//--null, 공백, 음수, overflow 처리--
	if(redirect==null) { redirect="0"; }
	if(amount=="" || amount==null) { amount="0"; }  
	
	if(amount.length()>5) { //만자릿수 이상(음수포함) 에러페이지로 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	if(Integer.parseInt(amount)<0) { amount="0"; } //수량이 음수일 경우
	if(Integer.parseInt(amount)>=100){ amount="0"; redirect="3"; } //수량이 100개 이상일 경우
	//--null, 공백, 음수, overflow 처리--
	
	
	String reDirectMessage=""; //에러메세지 출력 변수
	if(Integer.parseInt(redirect)==1) { reDirectMessage="수량을 입력하세요."; } 
	if(Integer.parseInt(redirect)==2) { reDirectMessage="상품이 장바구니에 담겼습니다."; }
	if(Integer.parseInt(redirect)==3) { reDirectMessage="수량을 100개 미만으로 입력하세요."; }
	
	//p_code를 받아 상품을 검색하여 출력하는 DAO 클래스 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProduct(p_code);
	
	//검색된 제품정보가 없는 경우 - 비정상적인 요청에 대한 응답 처리
	if(product==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//total 값 계산 변수
	int total=product.getP_price()*Integer.parseInt(amount);
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	//리뷰목록을 불러오는 DAO 클래스의 메소드 호출
	//ㄴ search(r_code)==keyword(p_code)인 항목을 검색 - r_code와 p_code가 일치하는 리뷰 검색
	int startRow=0, endRow=3; //3개만 출력
	String search="r_code", keyword=Integer.toString(p_code);
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow, search, keyword);
	
	//review 갯수 계산 DAO 클래스 메소드
	int totalReview=ReviewDAO.getDAO().selectReviewCount(search, keyword);
	
	//review 날짜 계산식
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">

#container {margin-left: 400px; width: 1500px;}
#p_img {float: left;}
#p_name {margin: 10px 0 0 100px; padding: 10px 0 0 100px; font-size: 12px;}
#line {color: gray; opacity: 50%; margin-left: 49px; padding-left: 49px;}
#tableDistance {margin-left: 100px; padding-left: 100px;}
#optionFont {font-size: 11px; font-weight: normal;}
select {width: 233px; height: 21px; border: 1px solid gray; font-family: inherit;}
input {width: 227px; height: 17px; border: 1px solid gray; font-family: inherit;}
.TOTAL {font-size: 11px; padding-left: 100px;}
#review{width: 500px; height:100px; border: none; margin-top: 100px;}
#reDirectMessage{color: red; font-size: 11px;}

</style>
<title>Tinynest</title>
</head>
<%-- 뒤로가기 방지 코드(body에 추가) --%>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<div id="container">

	<div id="contents">


		<!-- 상단 제품 정보(detail)  -->
		<div class="detail">
			<div class="detailArea ">

				<!-- 이미지 영역 -->
				<div id="p_img">
					<img src="<%=request.getContextPath() %>/product_image/<%=product.getP_img() %>"
					alt="대표이미지" width="470px;" />
				</div>


				<!-- 제품명  -->
				<div>
					<table id="p_name" frame="void">
						<%-- 기본정보 --%>
						<tbody>
							<tr>
								<td><span><%=product.getP_name() %></span></td>
							</tr>
						</tbody>
					</table>
				</div>	
				
				
				<!-- 구분선 -->
				<span id="line">
					──────────────────────────────────────────
				</span>


				<!-- detailText -->
				<div class="detailText">
					<div>
						<table id="tableDistance" frame="void" style="margin:10px 0 10px 0;">
							<%-- 기본정보 --%>
							<tbody>
								<tr>
									<th><span>PRICE</span></th>
									<td>
										<span>
											<span style="padding-left: 75px;"><%=DecimalFormat.getInstance().format(product.getP_price())%>원</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					

					<!-- 상품옵션 -->
					<table id="tableDistance" frame="void" style="margin-bottom: 10px;">
						<tbody>
							<tr>
								<th><span id="optionFont">Color</span></th>
								<td style="padding-left: 85px; ">
									<select>
										<option>One Color</option>
										<option disabled="disabled" >-------------------</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><span id="optionFont">Size&nbsp;</span></th>
								<td style="text-align: right;">
									<select>
										<option>One Size</option>
										<option disabled="disabled">-------------------</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><span id="optionFont">Qty&nbsp;&nbsp;</span></th>
								<td style="text-align: right;">
									<input type="number" class="amount" value="<%=amount%>"/>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- //상품옵션 -->
					
					<!-- 구분선 -->
					<span id="line">
						──────────────────────────────────────────
					</span>
					
					<!-- 여백 -->
					<table style="margin-bottom: 3px"/>
					

					<!-- 구매, 장바구니 버튼 -->
					<table>
						<tr>
							<td class="TOTAL">
								TOTAL : <%=DecimalFormat.getInstance().format(total) %>원
							</td>
							<td>
								<span id="reDirectMessage"><%=reDirectMessage %></span>
							</td>
						</tr>
						<tr>
							<td colspan="1" class="addToCart" id="tableDistance" width="50px">
								<br></br><br></br>
								<a href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_btn_action&btn=0&item=<%=product.getP_code() %>&amount=<%=amount%>">
									<img src="<%=request.getContextPath() %>/product/P_images/ADD TO CART.png" alt="장바구니 담기" />
								</a>
							</td>
							<td colspan="2" class="buyNow" id="tableDistance" width="50px">
								<br></br><br></br>
								<a href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_btn_action&btn=1&item=<%=product.getP_code() %>&amount=<%=amount%>">
									<img src="<%=request.getContextPath() %>/product/P_images/BUY NOW.png" alt="구매하기" />
								</a>
							</td>
						</tr>
					</table>
					<!-- //구매, 장바구니 버튼 -->
						
				</div>
				<!-- //detailText -->

			</div>
			<!-- //detail Area -->

		</div>
		<!-- //상단 제품 정보(detail) -->
			



	
		<!-- 하단부 -->
		<div style="padding-top: 300px; margin-top: 300px; ">
			
			
			<!-- 상품상세정보 -->
			<img src="<%=request.getContextPath() %>/product_image/<%=product.getP_info() %>" alt="상품상세정보" />
			
			
			<!-- 상품사용후기 -->
			<table id="review">
					<tr>
						<th colspan="4" style="border-bottom: 1px solid gray;">
							<p style="font-size: 15px; text-align: left;">REVIEW</p>
						</th>
					</tr>
					<%-- 게시글 목록 출력 --%>
					<% if(totalReview==0) { %>
					<tr>
						<td colspan="4">검색된 게시글이 없습니다.</td>
					</tr>	
					<% } else { %>
						<% for(ReviewDTO review:reviewList) { %>
						<tr>
							<% if(review.getR_status()!=0) {//삭제 게시글이 아닌 경우 %>
								<%-- 작성자 --%>
								<td style="padding-top: 5px; font-size: 12px;">id) <%=review.getR_writer() %></td>
								<%-- 작성일 --%>
								<td style="padding-top: 5px; font-size: 12px;">date) <%=review.getR_date().substring(0, 10) %></td>
							<% } else {//삭제 게시글인 경우 %>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							<% } %>
						</tr>
						<tr>
							<td colspan="4" style="padding-top: 10px; border-bottom: 1px solid gray;">
								<%-- 게시글 상태를 구분하여 제목과 링크를 다르게 설정하여 응답되도록 처리 --%>
								<% if(review.getR_status()==1) {//일반 게시글인 경우 %>
									<p style="font-size: 12px;"><%=review.getR_content() %></p>
								<% } else if(review.getR_status()==0) { %>
									<span class="remove">삭제글</span>
									작성자 또는 관리자에 의해 삭제된 게시글입니다.
								<% } %>
							</td>
						</tr>
						<% } %>	
					<% } %>
			</table>
			<!-- //상품사용후기 -->
				
			
		</div>
		<!-- //하단부 -->
	
	</div>
	<!-- contents -->
	
</div>

<script type="text/javascript">
$(".amount").change(function() {
	const amount=$(this).val();
	
	location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_detail&p_code=<%=product.getP_code()%>&amount="+amount;
});

//뒤로가기 방지(body에도 설정해야함)
window.history.forward(); function noBack(){ 
	window.history.forward();
}
</script>
</body>
</html>