<%@page import="java.text.DecimalFormat"%>
<%@page import="tinynest.dao.BasketDAO"%>
<%@page import="tinynest.dto.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_url.jspf" %>  
<%
	String loginId = loginMember.getId();

	List<BasketDTO> basketList = BasketDAO.getDAO().selectBasketListById(loginId);
	
	int totalPrice = 0;
	for (BasketDTO basket : basketList) {
		totalPrice += basket.getpPrice() * basket.getbAmount();
	}
	
	int deliveryFee = 0;
%>

<style type="text/css">
button {
	background-color: #e0e0e0;
	border-radius: 2px;
	border: 1px solid #d7d5d5;
}

#basketContent {
	margin-left: 400px;
	width: 1000px;
}

#basketTitle {
	margin-left: 300px; margin-bottom: 50px; font-size: 10px; font-weight: normal;
}

#basketTable {
	border: 2px solid black;
	border-collapse: collapse;
	border-left-style: none;
	border-right-style: none;
	width: 100%;
}

#basketTable th {
	border-top: 1px solid black;
	font-size: 1.3em;
	height: 50px;
}

#basketTable tr td {
	border-top: 2px solid #e6e6e6;
	font-size: 1.3em;
	text-align: center;
}

.emptyBasket {
	height: 200px;
	border: 1px solid #e6e6e6;
}

.item {
	width: 30px;
	height: 30px;
}

.productImg > img {
	width: 80px;
	height: 100px;
}

.productAmount > input {
	width: 30px;
}

#checkAllDiv {
	padding: 10px;
	height: 25px;
	float: left;
	font-size: 1.1em;
}

#checkAllDiv > input[type='checkbox'] {
	width: 20px;
	height: 20px;
	font-size: 1.3em;
}

#messageDiv {
	float: right;
}

#message {
	visibility: hidden;
}

#totalInfo {
	clear: both;
}

#totalInfoTable {
	border: 0;
	width: 300px;
	font-size: 1.3em;
}

#totalInfoTable th, #totalInfoTable td {
	text-align: right;
	border-style: none;
	padding: 4px;
}

#totalInfoTable th {
	width: 60%;
}

#totalInfoTable td {
	width: 40%;
}

#deleteDiv {
	margin: 20px auto;
}

.deleteBasket {
	float: left;
	margin: 0 10px;
}

.continueShopping {
	float: right;
}
</style>
<div id="basketTitle">CART</div>
<div id="basketContent" align="center">
	<div style="width: 100%;">
		<form id="basketForm" name="basketForm" action="<%=request.getContextPath()%>/index.jsp">
			<input type="hidden" id="workgroup" name="workgroup">
			<input type="hidden" id="work" name="work">
			<input type="hidden" id="all" name="all" value="0">
			
			<%-- 장바구니 목록 --%>
			<table id="basketTable">
			<% if (basketList == null || basketList.size() == 0) { %>
				<tr style="text-align: center;">
					<td class="emptyBasket">장바구니가 비었습니다.</td>
				</tr>
			<% } else { %>
				<tr>
					<th>선택</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>상품가격</th>
					<th>개수</th>
					<th>합계</th>
				</tr>
				<% for (BasketDTO basket : basketList) { %>
				<tr>
					<td><input type="checkbox" class="item" name="item" value="<%=basket.getbCode()%>" checked></td>
					<td class="productImg">
						<img alt="productImg" src="<%=request.getContextPath()%>/product_image/<%=basket.getpImg()%>">
					</td>
					<td class="productName">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_detail&p_code=<%=basket.getbCode()%>">
							<%=basket.getpName()%>
						</a>
					</td>
					<td class="productPrice"><%=DecimalFormat.getCurrencyInstance().format(basket.getpPrice())%></td>
					<td class="productAmount">
						<input type="text" class="amount" name="amount" value="<%=basket.getbAmount()%>" maxlength="2" size="3">&nbsp;
						<button type="button" class="edit">수정</button><br>
					</td>
					<td class="totalPrice"><%=DecimalFormat.getCurrencyInstance().format(basket.getpPrice() * basket.getbAmount()) %></td>
				</tr>
				<% } %>
			<% } %>
			</table>
			
			<%-- 전체선택 버튼 --%>
			<div id="checkAllDiv" align="left">
				<input type="checkbox" id="checkAll" checked>&nbsp;전체선택
			</div>
			
			<%-- 경고메세지 --%>
			<div id="messageDiv" style="height: 25px;">
				<p id="message" style="color: red;"></p>					
			</div>
			
			<%-- 선택한 상품의 합계 금액 --%>
			<div id="totalInfo" align="right">
				<table id="totalInfoTable">
					<tr>
						<th>상품 합계금액</th>
						<td id="productTotal"></td>
					</tr>
					<tr>
						<th>배송비</th>
						<td id="deliveryFee"><%=DecimalFormat.getCurrencyInstance().format(deliveryFee)%></td>
					</tr>
					<tr>
						<th>총 주문합계 금액</th>
						<td id="orderTotal"><%=DecimalFormat.getCurrencyInstance().format(totalPrice + deliveryFee)%></td>
					</tr>
				</table>
			</div>
			
			<div align="right"><button type="button" id="purchaseBtn">구매하기</button></div>
			<div id="deleteDiv" align="right">
				<div id="deleteAllBasket" class="deleteBasket">
					전체삭제
				</div>
				<div id="deleteSelectedBasket" class="deleteBasket" >
					선택상품삭제
				</div>
				<a class="continueShopping" href="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_list" >
					쇼핑계속
				</a>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
const amountReg = /\d{1,2}/g;

document.basketForm.addEventListener('keydown', function(event) {
	if (event.keyCode === 13) {
		event.preventDefault();
	}
}, true);

$(function() {
	$("#productTotal").text(Intl.NumberFormat("ko-KR", {style : "currency", currency : "KRW" }).format(<%=totalPrice%>));
});

//원화 표시 형식의 문자열을 순수 숫자형으로 바꾸는 함수
function stringNumberToInt(stringNumber) {
    return parseInt(stringNumber.replace(/,/g, '').substr(1));
}

//숫자형을 원화 표시 형식의 문자열로 변환하는 함수
function intToStringNumber(intNumber) {
	return new Intl.NumberFormat("ko-KR", { style : "currency", currency : "KRW" }).format(intNumber);
}

//수량 수정 버튼 이벤트
$(".edit").click(function() {
	const product = $(this).parent().siblings().eq(0).children("input").val()
	const amount = $(this).siblings().eq(0).val();

	//수량 형식 검증
	if (amountReg.test(amount) && amount > 0 && amount != "") {
		$("#message").css("visibility", "hidden");
	} else {
		$("#message").text("1~99 사이의 숫자를 입력하세요.");
		$("#message").css("visibility", "visible");
		$(this).focus();
		return;
	}
	
	$("#workgroup").val("basket");
	$("#work").val("basket_edit_action");
	$("#basketForm").attr("method", "get");
	$("#basketForm").submit();
	location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=basket_edit_action&product=" + product + "&amount=" + amount;
});

//구매하기 버튼 이벤트
$("#purchaseBtn").click(function() {
	if ($(".item").filter(":checked").length == 0) {
		$("#message").text("구매하실 상품을 선택해주세요.");
		$("#message").css("visibility", "visible");
		return;
	} else {
		$("#message").css("visibility", "hidden");
	}
	
	if ($("#message").css("visibility") == "visible") {
		return;
	}
	
	$("#workgroup").val("purchase");
	$("#work").val("purchase");
	$("#basketForm").attr("method", "get");
	$("#basketForm").submit();
});


//전체삭제하기 버튼 이벤트
$("#deleteAllBasket").click(function() {
	let item = $(".item");

	if (item.length == 0) {
		alert("상품이 없습니다.");
		return false;
	}
	
	if (!confirm("장바구니를 비우시겠습니까?")) {
		return false;
	}
	
	$("#all").val("1");
	
	$.ajax({
		url : "<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=basket_delete_action",
		type : "post",
		dataType : "json",
		data : $("#basketForm").serialize(),
		success : function(data) {
			location.reload();
		},
		error : function() {
			location.reload();
		}
	});
});

//선택상품 삭제하기 버튼 이벤트
$("#deleteSelectedBasket").click(function() {
	let item = $(".item");

	if (item.length == 0) {
		alert("선택된 상품이 없습니다.");
		return false;
	}
	
	if (!confirm("선택하신 상품을 삭제하시겠습니까?")) {
		return false;
	}
	
	$("#all").val("0");
	
	let itemLength = $(".item").length;
	
	$.ajax({
		url : "<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=basket_delete_action",
		type : "post",
		dataType : "json",
		data : $("#basketForm").serialize(),
		success : function(data) {
			location.reload();
		},
		error : function() {
			location.reload();
		}
	});
});

//체크박스 체크, 해제 시 상품 합계금액 변경 이벤트
$(".item").change(function() {
	let total = stringNumberToInt($("#productTotal").text());
	let price = stringNumberToInt($(this).parent().siblings().last().text());
	let isAllChecked = true;
	
	if ($(this).is(":checked")) {//체크박스 체크 시
		total += price;
		$(".item").each(function(i, element) { //체크박스 전체 체크 여부 검사
			if (!$(element).is(":checked")) { //체크박스 중 하나가 체크되지 않을 경우 전체선택 버튼 미체크
				isAllChecked = false;
				return false;
			}
		});
		
		if (isAllChecked) { //모든 체크박스가 체크되어있을 경우, 전체선택 버튼 체크
			$("#checkAll").prop("checked", true);
		}
	} else {//체크박스 체크 해제 시
		$("#checkAll").prop("checked", false);
		total -= price;
	}
	
	//계산된 금액을 표시
	$("#productTotal").text(intToStringNumber(total));
	$("#orderTotal").text(intToStringNumber(total + stringNumberToInt($("#deliveryFee").text())));
});

//전체 선택 버튼 이벤트
$("#checkAll").click(function() {
	let checked = $(".item");
	let total = 0;
	if ($(this).is(":checked")) {
		checked.prop("checked", true);
		$(".totalPrice").each(function(i, element) {
			total += stringNumberToInt($(element).text());
		});
		$("#productTotal").text(intToStringNumber(total));
		$("#orderTotal").text(intToStringNumber(total + stringNumberToInt($("#deliveryFee").text())));
	} else {
		checked.prop("checked", false);
		$("#productTotal").text(intToStringNumber(0));
		$("#orderTotal").text(intToStringNumber(0));
	}
});
</script>