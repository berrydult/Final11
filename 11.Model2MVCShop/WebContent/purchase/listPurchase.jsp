<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>구매 목록조회</title>

<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 60px;
        }
    </style>
 <script type="text/javascript">
	function fncGetPurchaseList(currentPage) {
		$("#currentPage").val(currentPage)
		
		$("form").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$( function(){
	
		$("td:nth-child(1)").on("click", function(){
			var tranNo = $(this).data("param0")
			self.location = "/purchase/getPurchase?tranNo="+tranNo
		});
		
		$("td:nth-child(2)").on("click", function(){
			var userId = $(this).data("param1")
			self.location = "/user/getUser?userId="+userId
		});
		
		$("td:nth-child(6)").on("click", function(){
			var tranNo = $(this).data("param0")
			self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3"
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
	});
	
</script> 
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">구매 목록조회</h3>
	   	</div>
	

		<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		</div>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      <!-- 배너 -->
	
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">회원ID</th>
            <th align="left">회원명 </th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
             <th align="left">정보수정</th>
          </tr>
        </thead>
			
		<c:set var="i" value="0"/>
		<c:forEach var = "purchase" items="${list}">
		<c:set var="i" value="${i+1}" />	
	
	<tr>
		<td align="center"  data-param0="${purchase.tranNo}">${i}</td>
		<td align="left" data-param1="${purchase.buyer.userId}">${purchase.buyer.userId}</td>
		<td align="left">${purchase.receiverName}</td>
		<td align="left">${purchase.receiverPhone}</td>
	
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
		</td>
		
		<td align="left" data-param0="${purchase.tranNo}">
			<c:if test = "${fn:trim(purchase.tranCode) == '2'}">
				물건도착
			</c:if>
		</td>
		</tr>
	</c:forEach>
	</table>
	<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
		<!-- PageNavigation End... -->

	<!--  페이지 Navigator 끝 -->

</div>

</body>
</html>