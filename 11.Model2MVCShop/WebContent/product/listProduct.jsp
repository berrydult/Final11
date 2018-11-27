<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*"%>
<html>
<head>
<title>상품 목록조회</title>
 <meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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

   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
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
	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScript 이용  
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
		 $( "button.btn.btn-default:contains('삭제')" ).on("click" , function() {
			 fncDeleteProduct();
		 });
	 });
		 
	$( function(){
			$(  "button.btn.btn-default:contains('검색')" ).on("click" , function() {
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
															+"상품명 : "+JSONData.prodName+"<br/>"
															+"가격 : "+JSONData.price+"<br/>"
															+"상품 상세정보 : "+JSONData.prodDetail+"<br/>"
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <c:if test = "${param.menu=='search'}">
				<h3>상품 목록 조회</h3>
			</c:if>
			<c:if test = "${param.menu=='manage' }">
				<h3>상품 관리</h3>
			</c:if>
	    </div>
	    
	    <c:if test = "${sessionScope.user.role == 'admin'}">
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    <div class="col-md-5 text-right form-group">	
	            	<select class="form-control" name="priceSort" onchange="fncPriceSort()">
						<option value="0" ${search.priceSort == 0 ? "selected" : ""}>가격순</option>
						<option value="1" ${search.priceSort == 1 ? "selected" : ""}>높은가격순</option>
						<option value="2" ${search.priceSort == 2 ? "selected" : ""} >낮은가격순</option>
					</select>
				</div>
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
				    	<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
					
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  
				    			 onKeyPress="if(event.keyCode=='13'){fncGetList('1')}">
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
	<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      <!-- 배너 -->
	
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">상품명</th>
            <th align="left">
            	가격
            </th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
             <th align="left">간략정보</th>
            <c:if test= "${param.menu == 'manage'}">	
				<th align="left">편집</th>
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
					판매중
				</c:when>
				<c:otherwise>
					재고없음 
				</c:otherwise>
			</c:choose>	
		</c:if>
		<c:if test = "${sessionScope.user.role == 'user'}">
			<c:choose> 
				<c:when test = "${fn:trim(product.proTranCode) == '0'}">
					판매중
				</c:when>
				<c:otherwise>
					재고없음
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test = "${sessionScope.user.role == 'admin'}">
			<c:if test = "${fn:trim(product.proTranCode) == '0'}">
			판매중
			</c:if>
			<c:if test = "${fn:trim(product.proTranCode) =='1' && param.menu == 'manage'}">
	  			판매완료<a href = "/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=1">배송하기</a>
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '1' && param.menu == 'search'}">
	  			판매완료
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '2'}">
	  			배송중
	  		</c:if>
	  		<c:if test = "${fn:trim(product.proTranCode) == '3'}">
	  			배송완료
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
			<button type="button" class="btn btn-default">삭제</button>
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
		       <!--  <p><a href="#" class="btn btn-primary" role="button">구매하고싶어?</a>
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
			<span>최근 본 상품들</span>
			<div id="" class="banner_contents" style="background-color:#FEFDC8">
					상품명<br>
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
