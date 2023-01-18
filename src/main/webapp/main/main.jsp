<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tinynest</title>

<%-- 메뉴 가져다 쓰실분은 여기서부터 가져가서 쓰시면 됩니다(*로 구분해놓음) --%>
<%--  메뉴 클릭시 해당 카테고리로 연결되는 부분은 아직 미완성입니다 
일단 디자인 틀 정도만 잡아둔 것이니 기능들은 완성되면 알려드릴게요 
 ********************************************************* --%>
<style>




.list {width:385px;
	   margin:10px 7px;}

#name {font-size:12px;
	   color:#999999;
	   display:flex;
	   font-weight:normal;
	   line-height:18px;
	   margin: 20px 0 0 7px;
	   flex-direction:column;
	   line-height:0.75em;}

#price {font-size:12px;
		color:#999999;
		font-style:italic;
		font-weight:normal;
		line-height:18px;
		display:flex;
		margin: 10px 0 50px 7px;
		flex-direction:column;
		line-height:0.75em;}




</style>
</head>
<body>

	<%-------------------------------------------------------------------------------------------%>
	
	<%-- 메인 아이템 리스트 --%>
	<div id=items style="display:flex;margin: 0 0 0 150px;">
		
			<div id=item_list style="display:flex;flex-direction:column;">
			
				<%---------------------------------------------------------------------------------------%>
				<%-- item_1, item_2, item_3 으로 첫번째 줄,두번째 줄, 세번째 줄로 나누었습니다  --%>
				<%-- div class="item_nm은 n이 n번째 줄, m은 n번째 줄의 m번째 아이템입니다 --%>
				<%-- 상품 상세 안내 페이지 완성되면 링크 업데이트 하겠습니다 --%>
				
				<div class="item_1" style="display:flex;">
				
					<div class="item_11">
						<a href="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_detail" class="">
							<img class="list" src="images/suede hidden bomber jumper.jpeg">
							<span id="name">suede hidden bomber jumper</span>
						</a>
						<span id="price">122,000원</span>
					</div>
				
					<div class="item_12">
						<a href="#" class="">
							<img class="list" src="images/caramel glossy over padding jumper.jpg">
							<span id="name">caramel glossy over padding jumper</span>
						</a>
						<span id="price">99,000원</span>
					</div>
				
					<div class="item_13">
						<a href="#" class="">
							<img class="list" src="images/cargo pocket padded pants.jpeg">
							<span id="name">cargo pocket padded pants</span>
						</a>
						<span id="price">64,000원</span>
					</div>
				</div>
				
				<%---------------------------------------------------------------------------------------%>
				
				<div class="item_2" style="display:flex;">
				
					<div class="item_21">
						<a href="#" class="">
							<img class="list" src="images/relaxed cash half pola knit.jpg">
							<span id="name">relaxed cash half pola knit</span>
						</a>
						<span id="price">41,000원</span>
					</div>
				
					<div class="item_22">
						<a href="#" class="">
							<img class="list" src="images/shred highneck zipup knit.jpeg">
							<span id="name">shred highneck zipup knit</span>
						</a>
						<span id="price">66,000원</span>
					</div>
				
					<div class="item_23">
						<a href="#" class="">
							<img class="list" src="images/alphabet tufted semiover hoody.jpeg">
							<span id="name">alphabet tufted semiover hoody</span>
						</a>
						<span id="price">53,000원</span>
					</div>
				</div>
				
				
				<%---------------------------------------------------------------------------------------%>
				
				<div class="item_3" style="display:flex;">
				
					<div class="item_31">
						<a href="#" class="">
							<img class="list" src="images/knity mix basic banding pants.jpg">
							<span id="name">knity mix basic banding pants</span>
						</a>
						<span id="price">36,000원</span>
					</div>
				
					<div class="item_32">
						<a href="#" class="">
							<img class="list" src="images/highlight black washing denim.jpg">
							<span id="name">highlight black washing denim</span>
						</a>
						<span id="price">53,000원</span>
					</div>
				
					<div class="item_33">
						<a href="#" class="">
							<img class="list" src="images/straight divide black grey denim.jpg">
							<span id="name">straight divide black grey denim</span>
						</a>
						<span id="price">56,000원</span>
					</div>
				</div>
				<%---------------------------------------------------------------------------------------%>
				
				<div class="item_4" style="display:flex;">
				
				<div class="item_41">
						<a href="#" class="">
							<img class="list" src="images/Minimal plain belt.jpg">
							<span id="name">Minimal plain belt</span>
						</a>
						<span id="price">17,000원</span>
					</div>
				
					<div class="item_42">
						<a href="#" class="">
							<img class="list" src="images/Minimal winter hand warmer.jpg">
							<span id="name">Minimal winter hand warmer</span>
						</a>
						<span id="price">13,000원</span>
					</div>
				
					<div class="item_43">
						<a href="#" class="">
							<img class="list" src="images/minimal wool muffler.jpeg">
							<span id="name">minimal wool muffler</span>
						</a>
						<span id="price">19,000원</span>
					</div>
				</div>
				<%---------------------------------------------------------------------------------------%>
				<br><br><br>
			</div>
	</div>
	<%---------------------------------------------------------------------------------------%>
</body>
</html>