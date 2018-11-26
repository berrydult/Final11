<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품등록</title>
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
            margin-top: 10px;
        }
    </style>

	<script type="text/javascript">
	
		$(function() {
		
			$("button.btn.btn-primary:contains('확인')" ).on("click", function() {
			
				self.location="/product/listProduct?menu=manage"
				});
		});
		
		$(function() {
			$("button.btn.btn-primary:contains('추가등록')" ).on("click", function() {
			
				self.location="../product/addProductView.jsp"
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
	
	<!-- form Start /////////////////////////////////////-->
	
		<div class="container">
		
			<h1 class="bg-primary text-center">상품등록 확인</h1>
		
		<form class="form-horizontal"  enctype="multipart/form-data">
		
 		<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4"> ${product.prodName} </div>
		  </div>
		  
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품 상세정보</label>
		    <div class="col-sm-4"> ${product.prodDetail}
		    </div>
		  </div>
	
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4"> ${product.manuDate}
		    </div>
		  </div>
	
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">${product.price}
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		    	 <img src="/images/uploadFiles/${product.fileName}" />
		    </div>
		  </div>	
		  
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  id="확인">확인</button>
			  <button type="button" class="btn btn-primary" id="추가등록" >추가등록</button>
		    </div>
		</div>
</form>
</div>
</body>
</html>