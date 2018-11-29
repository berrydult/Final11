<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>구매정보 수정</title>

<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
<script type="text/javascript">

	$( function(){
		
		$( "button.btn.btn-primary:contains('수정')" ).on("click" , function() { 
			var tranNo = $(this).data("param")
			$("form").attr("method","POST").attr("action","/purchase/updatePurchase?tranNo="+tranNo).submit();
			
		 });
	});	
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-default:contains('취소')" ).on("click", function(){
			history.go(-1);
		});
	});	
	
	$(function() {
		  $( "#divyDate" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
	});

</script>

</head>

<body>
<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
<div class="container">
	
		<h1 class="bg-primary text-center">구매정보수정</h1>

<form class="form-horizontal">
<div class="row">
	<div class="form-group">
		    <label for="buyer" class="col-sm-offset-1 col-sm-3 control-label">상품 구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="${purchase.buyer.userId}">
		    </div>
		    
	<div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-5 col-sm-5 control-label">구매방법</label>
		    <div class="col-sm-4">
		      <select name="paymentOption" class="form-control">
				<option value="1" ${purchase.paymentOption == '1'}?"selected":"" %>현금구매</option>
				<option value="2" ${purchase.paymentOption == '2'}?"selected":"" %>신용구매</option>
			</select>
		    </div>
		  </div>  
		  	  </div>  
	
		<div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="${purchase.receiverName}">
			    </div>
			  </div> 
			  
		<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="${purchase.receiverPhone}">
			    </div>
			  </div> 
		
		<div class="form-group">
			    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="${purchase.divyAddr}">
			    </div>
			  </div> 
		
		<div class="form-group">
			    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="${purchase.divyRequest}">
			    </div>
			  </div> 
			  
		<div class="form-group">
			    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="divyDate" name="divyDate" readonly="readonly" placeholder="${purchase.divyDate}">
			    </div>
			  </div>
				  
		<div style="float:right;" >
			<button type="button" class="btn btn-default">취소</button>
		</div>
		
		<div style="float:right;" data-param="${purchase.tranNo}">
			<button type="button" class="btn btn-default">수정</button>
		</div>
	</div>
	</form>
</div>
</body>
</html>