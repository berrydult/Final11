<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*"%>
<html>
<head>
<title>��ǰ �����ȸ</title>
 <meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
    <style>
       body > div.container{
            margin-top: 50px;
        }
    </style>
    
    <style type="text/css">
<!--
	body {padding-top:50px; font-size:11pt; padding:0; margin:0; position:relative;}
	h3 {color: #85144b; font-size: 14pt;}

	.contents {width: 800px; margin: 0 auto; height: auto; background-color: #e0e0e0; padding: 20px;}
	.contents img {float: left; padding: 30px;}	

	#banner { position: absolute; font-size: 8pt; top: 150px; right: 100; z-index: 10; background:#f1f1f1; padding:5px; border:1px solid #CCCCCC; text-align:center;}
	#banner > span {margin-bottom: 10px; display: block;}
	.banner_contents {min-height: 200px; background-color: #c0c0c0; padding: 5px;}
	
	.row{margin-left:30px;margin-right:100px;}

//-->
</style>
<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css">  -->

<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<script type="text/javascript">
	//�˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScript �̿�  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//alert($("#currentPage").val())
	   	//document.detailForm.submit();		
		$("form[name=detailForm]").attr("method","POST").attr("action","/product/listProduct?menu=${param.menu}").submit();
	}
	
 	function fncDeleteProduct() {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//document.detailForm.action="/product/deleteProduct";
		$("form[name=deleteForm]").attr("method","POST").attr("action","/product/deleteProduct").submit();
	}
	
 	function fncPriceSort(){
 		fncGetList(1);
 	}
 		 
	$( function(){
		 $( "button.btn.btn-default:contains('����')" ).on("click" , function() {
			 fncDeleteProduct();
		 });
	 });
		 
	$( function(){
			$(  "button.btn.btn-default:contains('�˻�')" ).on("click" , function() {
			 fncGetList('1');
		 });
	 });
		 
	$( function(){
		 $( "td:nth-child(6)").on("click" , function() {
			 var prodNo = $(this).data("param");
			 //alert("prodNo :" +prodNo);
			 $.ajax(
	 					{
	 						url:"/product/json/getProduct/"+prodNo,
	 						method:"GET",
	 						dataType:"json",
	 						headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h4>"
															+"��ǰ�� : "+JSONData.prodName+"<br/>"
															+"���� : "+JSONData.price+"<br/>"
															+"��ǰ ������ : "+JSONData.prodDetail+"<br/>"
															+"</h4>";
								
								$("h3").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
	 					}); 
				});
		 $( "td:nth-child(6)").css("color" , "purple");
		 
	});
		
	$( function(){
		 $( "td:nth-child(2)" ).on("click" , function() {
			 	if( ${param.menu eq 'manage'}){ 
			 		 var prodNo = $(this).data("param");
			 		self.location ="/product/updateProduct?prodNo="+prodNo+"&menu=manage";
			 	}
			 	else if( ${param.menu eq 'search'}){  
			 		 var prodNo = $(this).data("param"); 
					self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
				}
			});
				$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
		});
	
	$(function(){
        $("td[name=image]").tooltip({
           items:'[data-photo]',
            content:function(){
                var photo = $(this).data('photo');
                return '<img src="/images/uploadFiles/'+photo+'"/>';
            }
        });
    });
	
	$(window).scroll(function() { 
		$('#banner').animate({top:$(window).scrollTop()+"px" },{queue: false, duration: 500});
	});
	
	

</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <c:if test = "${param.menu=='search'}">
				<h3>��ǰ ��� ��ȸ</h3>
			</c:if>
			<c:if test = "${param.menu=='manage' }">
				<h3>��ǰ ����</h3>
			</c:if>
	    </div>
	    
	    <c:if test = "${sessionScope.user.role == 'admin'}">
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    <div class="col-md-5 text-right form-group">	
	            	<select class="form-control" name="priceSort" onchange="fncPriceSort()">
						<option value="0" ${search.priceSort == 0 ? "selected" : ""}>���ݼ�</option>
						<option value="1" ${search.priceSort == 1 ? "selected" : ""}>�������ݼ�</option>
						<option value="2" ${search.priceSort == 2 ? "selected" : ""} >�������ݼ�</option>
					</select>
				</div>
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
				    	<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
					
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  
				    			 onKeyPress="if(event.keyCode=='13'){fncGetList('1')}">
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
	<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      <!-- ��� -->
	
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">��ǰ��</th>
            <th align="left">
            	����
            </th>
            <th align="left">�����</th>
            <th align="left">�������</th>
             <th align="left">��������</th>
            <c:if test= "${param.menu == 'manage'}">	
				<th align="left">����</th>
			</c:if>
          </tr>
        </thead>
			
	<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
		  	<c:set var="i" value="${ i+1 }" />
	
	<tr>
		<td align="center">${i}</td>
		<td align="left" name="image" data-photo="${product.fileName}" data-param= "${product.prodNo}"> 
		  	<input type="hidden" value="${product.prodNo}">
		  	 	<a href="#" data-photo="${product.fileName}"></a>
		  	 ${product.prodName}
		</td>
		<td align="left">${product.price}</td>
		<td align="left">${product.regDate}</td>
		<td align="left">
		<c:if test = "${empty user}"> 
			<c:choose>
				<c:when test = "${fn:trim(product.proTranCode) == '0'}">
					�Ǹ���
				</c:when>
				<c:otherwise>
					������ 
				</c:otherwise>
			</c:choose>	
		</c:if>
		<c:if test = "${sessionScope.user.role == 'user'}">
			<c:choose> 
				<c:when test = "${fn:trim(product.proTranCode) == '0'}">
					�Ǹ���
				</c:when>
				<c:otherwise>
					������
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test = "${sessionScope.user.role == 'admin'}">
			<c:if test = "${fn:trim(product.proTranCode) == '0'}">
			�Ǹ���
			</c:if>
			<c:if test = "${fn:trim(product.proTranCode) =='1' && param.menu == 'manage'}">
	  			�ǸſϷ�<a href = "/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=1">����ϱ�</a>
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '1' && param.menu == 'search'}">
	  			�ǸſϷ�
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '2'}">
	  			�����
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '3'}">
	  			��ۿϷ�
	 	 	</c:if>
	  	</c:if>
		</td>	
		
		<td align = "left" data-param= "${product.prodNo}" id= "${product.prodNo}">
			<i class="glyphicon glyphicon-heart"></i>
		 </td>
		 
		 <c:if test= "${param.menu == 'manage'}">
			<td align="left"> 
				<c:if test="${fn:trim(product.proTranCode) == '0'}">
					<form class="form-inline" name="deleteForm">
						<input type="checkbox" name="deleteProduct${i}" value="${product.prodNo}"> 
					</form>
				</c:if>			
			</td>
		</c:if>
		
	</tr>
	
	</c:forEach>	
	</table> 
	
		<div style="float:right;">
			<button type="button" class="btn btn-default">����</button>
		</div>
		
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
		<!-- PageNavigation End... -->
	</c:if>	
	
			
<c:if test = "${sessionScope.user.role == 'user'}">
	<div class="row">
	   <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
		  	<c:set var="i" value="${ i+1 }" />
		  	
		<div class="col-sm-2 col-md-3">
	     <div class="thumbnail"  style="height:300px;width:250px">
	     	<div class="showList">
	      	<a href= "/product/getProduct?prodNo=${product.prodNo}&menu=search"><img src="/images/uploadFiles/${product.fileName}" style="height:190px;" data-param="${product.prodNo}"></a>
	      	<input type="hidden" value="${product.prodNo}">
		      <div class="caption">
		        <h3 align="center">${product.prodName}</h3>
		        
		        <p align="center">${product.prodDetail}</p>
		       <!--  <p><a href="#" class="btn btn-primary" role="button">�����ϰ�;�?</a>
		        	 <a href="#" class="btn btn-default" role="button">Button</a></p> -->
		      </div>
	   		</div>
	   		</div>
	   </div>
	    
	    </c:forEach>
	  </div>
</c:if>
	

	<!-- <div style="position:relative; float:right; width:90px; top:-15px; right:-115px; background-color:red;"> --> 
		<div id="banner" style="background-color:#FED2E6">
			<span>�ֱ� �� ��ǰ��</span>
			<div id="" class="banner_contents" style="background-color:#FEFDC8">
					��ǰ��<br>
	 <c:set var="i" value="0" />  	
		<c:forEach var="product" items="${cookieResult}">
			<c:set var="i" value="${ i+1 }" />
					<img src="/images/uploadFiles/${product.fileName}" style="height:50px;"/><br>
					${product.prodName}
				<br>
		</c:forEach>
</div>
	<!-- </div> --> 
		</div>      
</div>
</body>
</html>
