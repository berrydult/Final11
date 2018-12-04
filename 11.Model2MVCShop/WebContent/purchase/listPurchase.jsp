<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>���� �����ȸ</title>

<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">���� �����ȸ</h3>
	   	</div>
	

		<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		</div>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      <!-- ��� -->
	
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">ȸ��ID</th>
            <th align="left">ȸ���� </th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
             <th align="left">��������</th>
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
				���� ���ſϷ� ���� �Դϴ�.
			</c:if>
			<c:if test = "${fn:trim(purchase.tranCode) == '2'}">
				���� ����� ���� �Դϴ�.
			</c:if>
			<c:if test = "${fn:trim(purchase.tranCode) == '3'}">
				���� ��ۿϷ� ���� �Դϴ�.
			</c:if>
		</td>
		
		<td align="left" data-param0="${purchase.tranNo}">
			<c:if test = "${fn:trim(purchase.tranCode) == '2'}">
				���ǵ���
			</c:if>
		</td>
		</tr>
	</c:forEach>
	</table>
	<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
		<!-- PageNavigation End... -->

	<!--  ������ Navigator �� -->

</div>

</body>
</html>