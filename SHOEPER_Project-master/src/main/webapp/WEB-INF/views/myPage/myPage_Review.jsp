<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 리뷰 작성</title>
    <script src="${pageContext.request.contextPath }/resources/asset/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css">
    <c:import url="../common/styler.jsp"/>
</head>

<body>

	<!-- HEADER IMPORT -->
	<c:import url="../common/header.jsp"/>


    <div class="container-myPage">
        <div class="body-title">REVIEW</div>
        <section class="main">
            <div class="wrap-section">
                <div class="review-detail-title">Purchased Item</div>
                <div class="review-product-info">
                    <table class="review-table">
                        <thead>
                            <tr>
                                <th colspan="2">상품정보</th>
                                <th>주문일자</th>
                                <th>주문금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="product-img">
                                        <img src="${pageContext.request.contextPath}/resources/images/productImgUpload/${ info.att_name }" alt="">
                                    </div>
                                </td>
                                <td>
                                    <div class="product-info">
                                        <div class="brand-name">${ info.brand_name }</div>
                                        <span class="product-name">${ info.product_name } </span>
                                        <span class="product-option">${ info.order_size }</span>
                                    </div>
                                </td>

                                <td class="order-date">${ info.order_date }</td>
                                <td class="total-price">${ info.total_price }&#8361;</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- 리뷰 작성 영역-->
                    <div class="reviewArea">
                        <div class="formArea">
                            <form action="reviewEnroll.mp" method="POST" id="review" enctype="multipart/form-data">
	                            	 <div class="fileArea" id="fileArea">							           
							            <input type="file" accept="image/*" name="reviewImg" id="thumbImg1" onchange="loadImg(this, 1);" />
							 							           
							        </div> 
                                <div class="review-title">
                                    <span>제목</span>
                                    <input type="text" name="review_title" class="input-review-title">
                                    <input type="hidden" name="member_no" value="${ member.member_no }" />
                                    <input type="hidden" name="product_no" value="${ info.product_no }" />
                                    <input type="hidden" name="order_no" value="${ orderNo }" />
                                </div>
                                <div class="review-content">
                                    <span>내용</span>
                                    <textarea name="review_contents" form="review" cols="113" rows="15" fixed></textarea>
                                </div>
                                <div class="review-rating">
                                	<span>평점</span>
									<input type="radio" name="review_rating" value="1" /><img src="${pageContext.request.contextPath}/resources/images/star/1_star.png"/>&nbsp;
									<input type="radio" name="review_rating" value="2" /><img src="${pageContext.request.contextPath}/resources/images/star/2_star.png"/>&nbsp;
									<input type="radio" name="review_rating" value="3" /><img src="${pageContext.request.contextPath}/resources/images/star/3_star.png"/>&nbsp;
									<input type="radio" name="review_rating" value="4" /><img src="${pageContext.request.contextPath}/resources/images/star/4_star.png"/>&nbsp;
									<input type="radio" name="review_rating" value="5" /><img src="${pageContext.request.contextPath}/resources/images/star/5_star.png"/>
								</div>
								<br/>
                                 <div id="insertArea" class="inputBox1">
						            <div id="contentImgArea1" style="cursor: pointer" class="imgInput iip">
						                <img src="${pageContext.request.contextPath }/resources/images/imgInput.png" 
						                    id="contentImg1" class="addImg"/>
						        	</div>
						        	<%-- <div id="contentImgArea2" style="cursor: pointer" class="imgInput iip">
						                <img src="${pageContext.request.contextPath }/resources/images/imgInput.png" 
						                    id="contentImg2" class="addImg"/>
						            </div> --%>
						        </div>
                                </br>
                                <div class="btnArea">
		                            <button type="submit"> 작성하기 </button>
		                            <button onclick="history.back()"> 뒤로가기 </button>
		                        </div>
                                
                            </form>
                        </div>
                        <br>
                        
                    </div>

                </div>
            </div>
        </section>
    </div>
    
            
    <!-- FOOTER IMPORT -->
   	<%@ include file="../common/footer.jsp" %>
   	
</body>

<script>
    // .sale_status의 값(value)에 따라 배송 상태 텍스트 변경
    $(function () {
        $('.sale-status').each(function () {

            var ps = $(this).text();

            compSend = $(this).parent().next().children('.complete-send');
            modiProd = $(this).parent().next().children('.modify-product');
            delProd = $(this).parent().next().children('.delete-product');

            switch (ps) {
                case "1":
                    $(this).text('판매중');
                    modiProd.show();
                    delProd.show();
                    break;
                case "2":
                    $(this).text('결제완료');
                    compSend.show();
                    break;
                case "3":
                    $(this).text('구매확정대기');
                    break;
                case "4":
                    $(this).text('거래완료');
                    break;
            }
        })
    })
    
    
    $('#contentImgArea1').on('click', function() { 
		$('#thumbImg1').click();
	});
	
	$('#contentImgArea2').on('click', function() {
		$('#thumbImg2').click();
	});
	
	$('#fileArea').hide();
	
    function loadImg(img, num) {
		if (img.files && img.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				switch (num) {
				case 1: 
					$('#contentImg1').attr('src', e.target.result); 
					break;
				case 2:
					$('#contentImg2').attr('src', e.target.result);
					break;
				}
			}
		reader.readAsDataURL(img.files[0]);
		}
    }


</script>

</html>