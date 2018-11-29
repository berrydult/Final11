<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>


<title>��ǰ ���� ������</title>

<!-- ���� : http://getbootstrap.com/css/   ���� -->
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

	function fncAddPurchase() {
		
		$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();
	}
	
	 $(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddPurchase();
			});
		});	
	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			//$("form")[0].reset();
			resetData();
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
	
		<h1 class="bg-primary text-center">��ǰ����ȸ</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		<input type="hidden" name="prodNo" value="${product.prodNo}" />
		
 		<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">${product.prodNo}</div>
		  </div>

	<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4"> ${product.prodName} </div>
		  </div>
		  
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ ������</label>
		    <div class="col-sm-4"> ${product.prodDetail}
		    </div>
		  </div>
	
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4"> ${product.manuDate}
		    </div>
		  </div>
	
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">${product.price}
		    </div>
		  </div>
		  
		 <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-4">${product.regDate}
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ �����ھ��̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="${user.userId}">
		      
		    </div>
		  </div>  
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		      <select name="paymentOption" class="form-control">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>
		    </div>
		  </div>  
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="${user.userName}">
		    </div>
		  </div> 
		  
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="${user.phone}">
		    </div>
		  </div> 
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="${user.addr}">
		    </div>
		  </div> 
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest">
		    </div>
		  </div> 
		  
	<div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" readonly="readonly">
		    </div>
		  </div>
	
	<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >����</button>
				<a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
		    </div>
		  </div>
	</form>
	</div>

</body>
</html>