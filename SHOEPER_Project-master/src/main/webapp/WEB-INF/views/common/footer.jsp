<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/footer.css">


	<footer class="footer">
        <div class="wrapper">
            <img src="${pageContext.request.contextPath }/resources/images/shoeper.png" alt="풋터이미지" id="logo_footer">
        
            <div class="footer_contents">

                <div class="content">
                    <div class="title">
                        <h3>SHOEPER</h3>
                    </div>
                    
                    <div class="company">
                        <p>
                            주식회사 : SHOEPER 경기도 안산시 상록구 이젠 빌딩<br>
                            대표 : 이재원 <br>
                            사업자 등록번호 : 123-45-67890 <br>
                            통신판매업신고 :  2022-안산-0000 <br>
                            ShoePer@ShoePer.com <br>
                            copyright &copy; 2022 SHOEPER Inc
                        </p>
                    </div>
                

                    <div class="customer_center">
                        <h3>CUSTOMER CENTER</h3>
                        <h3>010-1234-5678</h3>
                    </div>

                    <div class="officeHour">
                        <p>
                            평일 오전 9시 - 오후 6시 <br>
                            점심시간 오후 12시 - 14시 <br>
                            주말, 공휴일 휴무
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script>
    $("#logo_footer").on("click",function(){
		location.href = "${pageContext.request.contextPath}/product/ending.do";
		});
    </script>
    