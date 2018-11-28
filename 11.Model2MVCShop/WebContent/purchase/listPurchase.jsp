<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
	System.out.println("listPurchase.jsp 초입");

	List<Purchase> list=(List<Purchase>)request.getAttribute("list");
	// HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	Search search=(Search)request.getAttribute("search");
	Page resultPage = (Page)request.getAttribute("resultPage");
	System.out.println("resultPage:" +resultPage);
	
	String menu = request.getParameter("menu");
	Purchase purchase = null;
	
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		
--%>
<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
 <script type="text/javascript">
	function fncGetPurchaseList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
		
		$("form").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$( function(){
	
		$(".ct_list_pop td:nth-child(1)").on("click", function(){
			var tranNo = $(this).data("param0")
			self.location = "/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var userId = $(this).data("param1")
			self.location = "/user/getUser?userId="+userId;
		});
		
		$(".ct_list_pop td:nth-child(11)").on("click", function(){
			var tranNo = $(this).data("param0")
			self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=2";
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
	});
	
</script> 
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<!-- <form name="detailForm" action="/purchase/listPurchase" method="post"> -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체  ${resultPage.totalCount}건수, 현재  ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<%-- <% 	
		int no=list.size();
		System.out.println("listPurchase의 list.size() : "+list.size());
		for(int i=0; i<list.size(); i++) {
			purchase = (Purchase)list.get(i);
			System.out.println("listPurchase.jsp의 purchase : "+purchase);
	%> --%>
		<c:set var="i" value="0"/>
		<c:forEach var = "purchase" items="${list}">
			<c:set var="i" value="${i+1}" />	
	
	<tr class="ct_list_pop">
		<td align="center" data-param0="${purchase.tranNo}">
			<%-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i}</a> --%>
			${i}
		</td>
		<td></td>
		<td align="left" data-param1="${purchase.buyer.userId}">
			<%-- <a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a> --%>
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
		<c:if test = "${fn:trim(purchase.tranCode) == '1'}">
			현재 구매완료 상태 입니다.
		</c:if>
		<c:if test = "${fn:trim(purchase.tranCode) == '2'}">
			현재 배송중 상태 입니다.
		</c:if>
		<c:if test = "${fn:trim(purchase.tranCode) == '3'}">
			현재 배송완료 상태 입니다.
		</c:if>
		<td></td>
		<td align="left" data-param0="${purchase.tranNo}">
			<c:if test = "${fn:trim(purchase.tranCode) == '2'}">
				<%-- <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=2">물건도착</a> --%>
				물건도착
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>	
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name = "type" value="Purchase" />
			</jsp:include>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>