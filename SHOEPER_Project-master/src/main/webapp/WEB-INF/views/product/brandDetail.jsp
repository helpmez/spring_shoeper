<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>brandDetail</title>
   
    <c:import url="../common/styler.jsp"/>
     <!-- Bootstrap CSS -->

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src='${pageContext.request.contextPath }/resources/js/jquery.zoom.js'></script>
    <script src='${pageContext.request.contextPath }/resources/js/jquery.Wheelzoom.js'></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/productDetail.css" />
</head>
<body>
	<c:import url="../common/header.jsp"/>

<section>
    <div class="product_detail">
        <div class="package" >
            <div id="insertArea" class="inputBox1">
            	<c:forEach items="${attachment}" var="a" varStatus="vs">
	                <div id="contentImgArea${vs.count}" class="imgInput">
	                    <img src="${pageContext.request.contextPath}/resources/images/productImgUpload/${a.att_name}" 
	                        id="contentImg${vs.count}" style="height: 150px; width: 120px;"/>
	                </div>
                </c:forEach>
            </div>

            <div id="imgDetail" class="inputBox2">
                <div class='inputBox2 zoom' id='ex1'>
                    <img src='${pageContext.request.contextPath }/resources/images/productImgUpload/${a.att_name}' id='jack' width='540' height='620' alt=''/>
                </div>
            </div>
        
            
        </div>
        <div class="package">
            <div id="prTextInput" class="inputBox3">
                <span id="brand_name"><b>${ product.brand_name }</b></span>
                <br>
                
                <h4 id="pName">${ product.product_name }</h4>
                <span style="margin-left: 240px;" >￦</span><span id="ppPrice">${ product.product_price }</span> <br>
                <span>
                <b>Stock</b><br>
                240 size : ${product.product_stock_240 }<br>
                250 size : ${product.product_stock_250 }<br>
                260 size : ${product.product_stock_260 } 
                </span>
                <hr>
                
                <dl>
                    <dt class="drop"><b>Product Detail</b> 
                        <span class="accIcon" style="float: right; margin-right: 30px;"> 
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
                            </svg>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
                                <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
                            </svg>
                        </span>
                    </dt> 
                    <dd class="ddd"><span class="pInfoText">
                        ${ product.product_detail }
                    </span> <br></dd>
                    <hr>
                    <dt class="drop"><b>Size, Color</b> 
                        <span class="accIcon" style="float: right; margin-right: 30px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
                            </svg>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
                                <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
                            </svg>
                        </span>
                    </dt>
                    <dd class="ddd"><span class="pInfoText">
                        ${ product.product_sizeinfo }
                    </span> <br></dd>
                    <hr>
                    <dt>
                        <b>Select Size</b>
                        <select name="" id="selectSize" class="selectSize" style="width: 140px; float: right; margin-right: 30px;" >
                            <option value="">선택안함</option>
                           	<c:if test="${ product.product_stock_240 != 0}">
                            	<option value="S">240</option>
                            </c:if>
                            <c:if test="${ product.product_stock_240 == 0}">
                            	<option value="">240 - 품절</option>
                            </c:if>
                            <c:if test="${ product.product_stock_250 != 0}">
                            	<option value="M">250</option>
                            </c:if>
                            <c:if test="${ product.product_stock_250 == 0}">
                            	<option value="">250 - 품절</option>
                            </c:if>
                            <c:if test="${ product.product_stock_260 != 0}">
                            	<option value="L">260</option>
                            </c:if>
                            <c:if test="${ product.product_stock_260 == 0}">
                            	<option value="">260 - 품절</option>
                            </c:if>
                        </select> <br>
                    </dt><hr>
                    <dt class="pOrigin">
                        <div id="origin" class="selectedPList">
                       		<input type="hidden" class="product_no" value="${product.product_no }"/>
                       		<input type="hidden" class="product_type" value="${product.product_type }"/>
                            <span>${ product.product_name }<b class="selectedSize"></b> </span>
                            <input type="number" class="quantity" id="pQuan" name="pQuan" value="1" min="1"> <!-- input value 값 ??  -->
                            <img src="${pageContext.request.contextPath }/resources/images/xx.png" alt="" style="width: 15px; height: 15px; margin-right: 5px;" class="pdeleteBtn" >
                            <span>￦</span><span class="pPrice">${ product.product_price }</span>
                            <input type="hidden" class="selSize" />
                        </div>
                    </dt>
                    <dt class="pResult">
                    </dt>

                    <dt><br /><br />
                        <div>   
                            <b>Total :</b> <span id="won">0</span> <span class="totalPD"></span> <span id="totalQ"></span>
                        </div>
                    </dt>
                </dl>
				<div class='btnArea'>
	                <button class="btn" onclick="addCart();">add to cart</button>
	                <button class="btn" onclick="goBuy();">buy now</button>
                </div>

            </div>
        </div>
    </div>

    <div class="review_list" style="clear:both;">
        <br><br><br><hr>

        <div style="margin-bottom: 15px;">
        	<span class="underMenu review" style="margin-bottom: 50px;">REVIEW</span><span class="underMenu faq" style="margin-bottom: 50px;">FAQ</span>
        </div><hr>
        
        <dl id="review-table">
        	<dt class="showArea">
				<span class="th">평점</span>
				<span class="th">제목</span>
				<span class="th">작성자</span>
				<span class="th">작성일</span>
	            <span class="accIcon" style="float: right; margin-right: 30px;">
                </span>
            </dt><hr>
            
            <c:forEach items="${ review }" var="r">
            	<dt class="showArea">
					<span class="th">
						<c:choose> 
							<c:when test="${r.review_rating == 5}">
								<img src="<c:url value="/resources/images/star/5_star.png"/>"/>
							</c:when> 
							<c:when test="${r.review_rating == 4 }">
								<img src="<c:url value="/resources/images/star/4_star.png"/>"/>
							</c:when> 
							<c:when  test="${r.review_rating == 3}">
								<img src="<c:url value="/resources/images/star/3_star.png"/>"/>
							</c:when>
							<c:when test="${r.review_rating == 2 }">
								<img src="<c:url value="/resources/images/star/2_star.png"/>"/>
							</c:when>
							<c:otherwise>
								<img src="<c:url value="/resources/images/star/1_star.png"/>"/>
							</c:otherwise> 
						</c:choose>
					</span>
					<span class="th">${ r.review_title }</span>
					<span class="th">${ r.member_nickname }</span>
					<span class="th">${ r.review_date }</span>
		            <span class="accIcon" style="float: right; margin-right: 30px;">
		                 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
		                      <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
		                 </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
	           	<dd class="dropArea">
	            	<div>
	                	<br />
	                	<span class="review-content">
		                	${ r.review_contents }
	                	</span>
	            	</div>
	            </dd><hr>
            </c:forEach>
            
            
        </dl>
        
        
        
        
        <dl id="FAQ-table">
            
	            <dt class="showArea-faq">
	                주문내역을 확인하고 싶어요.
	               
	                <span class="accIcon" style="float: right; margin-right: 30px;">
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
	                          <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
	                     </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
            	<dd class="dropArea">
	            	<div>
	                	<br />
	                	<span class="faq-text">
	                		SHOEPER 회원일 경우 로그인 후 <br />
	                		프로필 아이콘 클릭 > MYPAGE > 주문내역에서 <br /> 
	                		주문내역 확인 가능합니다.
	                	</span>
	                	
	            	</div>
	            </dd><hr>
	            
	            <dt class="showArea-faq">
	                주문현황을 확인하고 싶어요.
	               
	                <span class="accIcon" style="float: right; margin-right: 30px;">
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
	                          <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
	                     </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
            	<dd class="dropArea">
	            	<div>
	                	<br />
	                	<span class="faq-text">
	                		SHOEPER 회원일 경우 로그인 후 프로필 아이콘 클릭 > MYPAGE > 주문내역에서 <br /> 
	                		주문 및 배송현황 확인 가능합니다. <br /><br /> 
	                		
	                		- 배송준비중 : 결제완료 후 해당 브랜드로부터 상품 발송을 대기중<br /> 
	                		- 배송중 : 브랜드에서 상품 발송 완료<br />
	                		- 구매완료 : 고객이 상품을 받고 구매완료 신청했을 경우 <br />
	                	</span>
	                	
	            	</div>
	            </dd><hr>
	            
	            <dt class="showArea-faq">
	                중고상품 결제/결제후엔 어떻게 하나요?
	               
	                <span class="accIcon" style="float: right; margin-right: 30px;">
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
	                          <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
	                     </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
            	<dd class="dropArea">
	            	<div>
	                	<br />
	                	<span class="faq-text">
		                	SHOEPER에서 결제해주시면 판매자에게 전달해드립니다. <br /> 
		                	판매자가 입금 확인 후 상품을 발송할 예정이오니,<br />
		                	마이페이지 > 주문내역 에서 주문 현황을 확인해주시기 바랍니다.<br />
	                	</span>
	            	</div>
	            </dd><hr>
	            
	            <dt class="showArea-faq">
	                내 정보는 어떻게 수정하나요?
	               
	                <span class="accIcon" style="float: right; margin-right: 30px;">
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
	                          <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
	                     </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
            	<dd class="dropArea">
	            	<div>
	                	<br />
	                	<span class="faq-text">
		                	로그인 아이콘 클릭 > 마이페이지 > 회원 정보에서 <br />
		                	원하시는 정보만 수정할 수 있습니다. <br />
	                	</span>
	            	</div>
	            </dd><hr>
	            
	            <dt class="showArea-faq">
	                리뷰는 어떻게 작성하나요?
	               
	                <span class="accIcon" style="float: right; margin-right: 30px;">
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
	                          <path d="M8 0a1 1 0 0 1 1 1v6h6a1 1 0 1 1 0 2H9v6a1 1 0 1 1-2 0V9H1a1 1 0 0 1 0-2h6V1a1 1 0 0 1 1-1z"/>
	                     </svg>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
	                          <path d="M0 8a1 1 0 0 1 1-1h14a1 1 0 1 1 0 2H1a1 1 0 0 1-1-1z"/>
	                     </svg>
	                </span>
	            </dt>
            	<dd class="dropArea" id="accordion2" class="collapse2">
	            	<div>
	                	<br />
	                	<span class="faq-text">
		                	로그인 아이콘 클릭 > 마이페이지에서 주문하신 상품의 리뷰만 작성하실 수 있습니다. <br /> 
	                		리뷰 내용은 텍스트만 작성할 수 있으며 사용하시는 닉네임으로 등록됩니다. <br />
	                	</span>
	                	
	            	</div>
	            </dd>
	            
	         </dl>   
	        
        <hr />
        
        
        <!-- 우선 틀만 잡아놓음 -->
            <!-- 페이지네이션 (임시) -->
            <c:out value="${pageBar}" escapeXml="false"/>



    </div>

</section>

<c:import url="../common/footer.jsp"/>
    
	<script>
	
		$(function() {
		    $(document).ready(function(){
		        $('#ex1').zoom();
		      
		    });
		});
    
    	// 장바구니에 선택상품 담기
		function addCart() {
				if(${empty member}){
					alert("PLEASE LOGIN")
				}else{
				 var pp = $('.selectedSize').text();
			 if(pp == ""){
	       		  alert('선택된 항목이 없습니다.');
	       	  } else {
        		 if(product_size != ""){
        	   	 var product_size = [];
        		 $('.selSize').each(function(){
        			 product_size.push($(this).val());
        		 })
        		 
        		  var order_quantity = [];
				 $('.quantity').each(function(){
					 order_quantity.push($(this).val());
				 })
        		 var product_no = [];
				 $('.product_no').each(function(){
					product_no.push($(this).val()); 
				 	})
        		 }	
       	   		$.ajax({
	       		    method: 'POST',
	       		    url: "${pageContext.request.contextPath}/order/addCartList.or",
	       		   	data: {
						"product_size" :  product_size,
						"order_quantity" : order_quantity,
						"product_no" : product_no
					}, 
					success: function(){
						// 장바구니 이동 확인
			        	 if(confirm("장바구니에 상품이 담겼습니다. 장바구니로 이동하시겠습니까?") == true){
			        	        location.href="${pageContext.request.contextPath}/order/cart.or"
			        	    } else{
			        	        return ;
			        	    };
						}, error : function(){
							alert("실패");
						}
					});    
	   			 }
				}
    	}
		
		
		  // 상품 상세페이지에서 바로 구매
          function goBuy() {
        	  if(${empty member}){
					alert("LOGIN FIRST.");
				}else{
					 var pp = $('.selectedSize').text();
					 if(pp == ""){
			       		  alert('죄송합니다. 현재 재고가 없습니다.');
			       	  } else {
						  var buyList = [];
			        	  $('.selectedPList').each(function(){
				        	  var product_no = $(this).children('.product_no').val();
				        	  var cart_quantity = $(this).children('.quantity').val();
				        	  var cart_size = $(this).children('.selSize').val();
				        	  var product_name = '<c:out value="${ product.product_name }"/>';
				        	  var brand_name = '<c:out value="${ product.brand_name }"/>';
				        	  var product_price = '<c:out value="${ product.product_price}"/>';
				        	  var att_name = '<c:out value="${ attachment[1].att_name }"/>';
				        	 
				        	 
				        	  if(cart_size != ""){
					        	 var product = {
					        			 'product_no' : product_no,
					        			 'cart_quantity' : cart_quantity,
					        			 'cart_size' : cart_size,
					        			 'product_name' : product_name,
					        			 'brand_name' : brand_name,
					        			 'product_price' : product_price,
					        			 'att_name' : att_name
					        			 
					        	 }
					        	  buyList.push(product);
				        	  }
		        		  })
		        	  
		        		var data = JSON.stringify(buyList);
			        
		        	  
		        	   $.ajax({
		       		    method: 'POST',
		       		    url: '${pageContext.request.contextPath}/order/buyList.or',
		       		    traditional: true,
						data: {data}, 
						success: function(data){
								console.log("전송 성공")
								location.href="${pageContext.request.contextPath}/order/order.or?selectedCart_no="+data;
							}, error : function(){
								console.log("실패");
							}
						});        	  
        	  }
			}
        	  			
		  }
          
          
          /*
        	 $('.selectedPList').each(function(){
        		 var product_no = $(this).children('.product_no').val();
	        	 var cart_quantity = $(this).children('.quantity').val();
	        	 var cart_size = $(this).children('.selSize').val();
	        	 var brand_name = ${ product.brand_name };
	        	 var product_name = ${ product.product_name };
	        	 var product_price = ${ product.product_price};
	        	// var att_name = ${ attachment[1].att_name };
	        	  
        	 })
        	 
        	 console.log('구매버튼 자료 확인');
        	 console.log(product_no);
        	 console.log(cart_quantity);
        	 console.log(cart_size);
        	 console.log(brand_name);
        	 console.log(product_name);
        	 console.log(product_price);
        	 //console.log(att_name);

        	 
        	 
         } */

        // $(function() {
        //     if($('.totalPD').text()== "") {
        //         console.log("totalPD::" + $('.totalPD').text())
        //         $('#won').text('0')
        //     }
        // });
        
         $('.pResult img').on('click', function() {
         	console.log('test');
             $(this).parent().remove();
         	totalCalc();
         });
            
        $('#pQuan').on('change', function() {
            var uuu = $(this).val()
            
            // var ggg = $('#ppPrice').text().str.substring(indexStart[2, indexEnd])
            // var ggg = $('#ppPrice').text()
            // console.log(uuu);
            // console.log(ggg);
            // console.log(uuu*hhh);
            $(this).siblings('.pPrice').text(thousandComma(uuu*hhh));
            totalCalc();
        });
        var hhh;
        $(function() {
            hhh = $('#ppPrice').text();
            // console.log(hhh);
            $('#ppPrice').text(thousandComma($('#ppPrice').text()));
            if($("#pQuan").val() < 1) alert("최소 주문수량은 1개 입니다.");
        });
        $('.pOrigin').hide();
        // $('.pResult').hide();
        
        $('#selectSize').on('change', function() {
            $('.pResult').show();
            if($('.frmSize.'+$('#selectSize').val()).length == 0){
                var result = $('#origin').clone(true);
                result.removeClass('#origin');
                result.addClass($('#selectSize').val());
                result.addClass('frmSize');
                result.find('.selectedSize').text("[" + $('#selectSize').val() + "]");
                result.find('.selSize').val($('#selectSize').val());
                
                $('.pResult').append(result);
                $('.pPrice').each(function(){
                    $(this).text(thousandComma($(this).text()));
                });
            } else {
                var quan = $('.frmSize.'+$('#selectSize').val()).find('[name=pQuan]');
                quan.val(parseInt(quan.val()) + 1);
                var priceTag = quan.siblings('.pPrice');
                priceTag.text(thousandComma(parseInt((priceTag.text()).replace(',','')) * quan.val()));
            }
            
            $('.pResult img').on('click', function() {
            	console.log('test');
                $(this).parent().remove();
            	totalCalc();
            });
            
            totalCalc();
            $('#won').text('￦')
            // $('.pResult').$('#selectedSize').text($('#selectSize').val())
        })
        
        
       function totalCalc(){
            var totalPrice = 0;
            // console.log("totalPrice before :: " + totalPrice);
            
            $('.pResult .pPrice').each(function(){
                // console.log("parse : "+$(this).text());
                // console.log("count = " + Number(($(this).text()).replace(/,/gm,'')))
                totalPrice += Number(($(this).text()).replace(/,/gm,''));
            })
            
            // var totalQuan = 0;
            // $('.pResult #pQuan').each(function() {
            //     totalQuan += Number($('#pQuan').val())
            //     $('#totalQ').text("(" + totalQuan + "개)")
            // })
            $('.totalPD').text(thousandComma(totalPrice));
            // console.log("totalPrice after :: " + totalPrice);
       }
        
        function thousandComma(x){
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        $('.drop').on('click', function () {
        	$(this).next('.ddd').slideToggle(300);
        	
            // +, - 아이콘 바꾸기
            var plus = $(this).children('span').children('.bi-plus-lg');
            var dash = $(this).children('span').children('.bi-dash-lg');
            if ( dash.css('display') == 'none' ) {
                dash.css('display', 'inline-block');
                plus.css('display', 'none');
            } else {
                plus.css('display', 'inline-block');
                dash.css('display', 'none');
            }
            // if ($(this).hasClass('on')) {
            //     slideUp();
            // } else {
            //     slideUp();
            //     $(this).addClass('on').next().slideDown();
            // }
            // function slideUp() {
            //     $('.drop').removeClass('on').next().slideUp();
            // };
        });
        $(function() {
        	$('#imgDetail').children().children().attr('src', $('#contentImg1').attr('src'));
        });
        $('#contentImgArea1').on('click', function() { 
			$('#imgDetail').children().children().attr('src', $('#contentImg1').attr('src'));
		});
		
		$('#contentImgArea2').on('click', function() {
			$('#imgDetail').children().children().attr('src', $('#contentImg2').attr('src'));
		});
		
		$('#contentImgArea3').on('click', function() {
			$('#imgDetail').children().children().attr('src', $('#contentImg3').attr('src'));
		});
		
		$('#contentImgArea4').on('click', function() {
			$('#imgDetail').children().children().attr('src', $('#contentImg4').attr('src'));
		});
		
		// icon, review-content toggle
		$('.showArea, .showArea-faq').on('click', function() {
			$(this).next('.dropArea').slideToggle(300);
            // +, - 아이콘 바꾸기
            var plus = $(this).children('.icon-td').children('span').children('.bi-plus-lg');
            var dash = $(this).children('.icon-td').children('span').children('.bi-dash-lg');
			
            console.log(plus);
            console.log(dash);
            
            if ( dash.css('display') == 'none' ) {
                dash.css('display', 'block');
                plus.css('display', 'none');
            } else {
                plus.css('display', 'block');
                dash.css('display', 'none');
            }
        });
		
		// REVIEW 클릭 시 리뷰 테이블만 보이기
		$('.review').on('click', function() {
			$('#FAQ-table').css('display', 'none');
			$('#review-table').css('display', 'block');
			$(this).css({
				'text-decoration': 'underline'
			});
			$(this).siblings('.faq').css({
				'text-decoration': 'none'
			});
		});
		
		// FAQ 클릭 시 FAQ 테이블만 보이기
		$('.faq').on('click', function() {
			$('#review-table').css('display', 'none');
			$('#FAQ-table').css('display', 'block');
			$(this).css({
				'text-decoration': 'underline'
			});
			$(this).siblings('.review').css({
				'text-decoration': 'none'
			});
		});
		
		
		$(function() {
			
			var str = $('#currPage').text();
			// var index = str.indexOf('currPage');
			
			// var result = str.substring(index+11, index+12);
			console.log(str);
			
			if ( str > 1 ) {
				var offset = $(".review_list").offset();
	        	$('html, body').animate({scrollTop : offset.top}, 50);
			}
		});
			
	
			
		
		
		
	
		
		 
    </script>
</body>
</html>