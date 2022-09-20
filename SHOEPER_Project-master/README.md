# shoeper(신발 중고거래 +브랜드 입점거래 웹 사이트 프로젝트)

![screencapture-localhost-8090-shoeperApp-2022-09-17-22_26_25](https://user-images.githubusercontent.com/104877508/190859462-793b98d0-1e4f-4150-9d86-aa8a8aa76080.png)


## 프로젝트 목적
* 최근 개인간 중고거래가 크게 늘어나는 사회적 분위기에 맞추어 개발 
* '알라딘' 웹사이트를 모델로 하여 신발을 중고로 구매하면서 신상품을 구매할 수 있는 쇼핑몰 


## 개발 일정
* 2022/09/01 ~ 2022/09/19


## 구현 기능
| 기능 | 내용 | 
 | ------ | ------ | 
 | 회원가입 | 일반&브랜드 회원가입,SNS로그인, 회원탈퇴 | 
 | 일반회원기능| 중고물품등록, 중고상품&브랜드상품 구매, 장바구니, 리뷰등록, 중고물품 판매시 안내창출력 | 
 | 브랜드회원기능 | 브랜드상품등록  |
 | 마이페이지 | 등록한상품, 구매한상품, 주문현황, 주문서보기, 회원정보 수정 |
 | 상품조회 | 검색, 브랜드별 & 종류별 카테고리, 평점순 보기, 상품 이미지 확대 |
 
 상품 이미지 확대 :  jquery.zoom.js
 
 페이지네이션 : 한 페이지에 컨텐츠가 12개가 넘어갈시 다음버튼 활성화


## 사용 기술
| 사용 기술 | 기술 내용 | 
| ------ | ------ | 
| API | 아임포트, SNS 로그인 | 
| 스프링시큐리티 |  해시 암호화 및 솔팅 | 
| 쿠키(cookie) | 거래완료안내 팝업창, 메인화면 팝업창 |
|MyBatis의 rowbounds|  페이징 처리   |
<details>
<summary><U>상세 내용 보기</U></summary>
<div markdown="1">
 
## 아임포트
 
 https://github.com/helpmez/spring_shoeper/blob/de8f11abc7d25adc45635bf8d679e8c61dafb9ff/SHOEPER_Project-master/src/main/webapp/WEB-INF/views/order/order.jsp#L423-L460
 
* 아임포트 JS 
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

 
* 사용법
1. 회원 가입 후
 
2.  관리자 화면 → 결제 연동
 
3.  간편결제 테스트에서 PG 대행사 ‘카카오페이’ 추가
 
4. javascript함수 에서 pg의 이름 변경
 
5. 결제 완료
 
 
![Untitled](https://user-images.githubusercontent.com/104877508/190897693-d56162ab-9278-405e-91d8-0e025e66b706.png)
 
## 카카오 로그인 
 
 https://github.com/helpmez/spring_shoeper/blob/de8f11abc7d25adc45635bf8d679e8c61dafb9ff/SHOEPER_Project-master/src/main/webapp/WEB-INF/views/member/loginModal.jsp#L227-L236
 
 * 카카오 JS
 
  <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
 
 * 사용법 
 
1. 카카오 개발자 페이지 회원가입 후
 
2. 앱키에서 JAVASCRIPT 키 확인
 
3. 플랫폼에서 도메인 등록
 
4. 카카오 로그인 활성화
 
5. 동의항목 수정 
 
6. 리다이렉트 URI 등록
 
 
 ![Untitled (1)](https://user-images.githubusercontent.com/104877508/190897887-014bd16f-dde4-4bda-a9ef-6234cf17f9c2.png)
 
7. 자바스크립트 키 SDK 이름 수정
 
## 팝업창 
 
 https://github.com/helpmez/spring_shoeper/blob/13ab7dc808d46220a9e87d4c36d641c65aa8dffc/SHOEPER_Project-master/src/main/webapp/WEB-INF/views/popup/popup.jsp#L14-L24
 
  https://github.com/helpmez/spring_shoeper/blob/13ab7dc808d46220a9e87d4c36d641c65aa8dffc/SHOEPER_Project-master/src/main/webapp/WEB-INF/views/popup/popup.jsp#L80-L88
 
 HTTP는 ‘무상태 프로토콜’ 이기떄문에 한번 연결이 끝나면, 

이전 정보를 잊어버리기때문에 쿠키를 설정해줘서 

‘오늘하루보지않기’ 클릭시 팝업창이 뜨지않게 해야한다.

setCookie 메소드를 통해 서버에서 웹브라우저에게 

쿠키 이름(maindiv) 과 expires(유효시간)을 쿠키 저장소에 저장시킨다.

브라우저는 설정된 유효 일자까지 쿠키를 유지하다가, 해당 일자가 도달하면 쿠키를 자동으로 삭제한다.

expires 으로 유효 일자를 지정하였다. (24시간)
 
![POP](https://user-images.githubusercontent.com/104877508/190898326-dea368cb-0ee6-4868-ac62-9f49b6ef6432.png)
 
![pop2](https://user-images.githubusercontent.com/104877508/190898329-8d5c5e6c-f861-4f9c-a342-b7be3cf65be8.png)
 
 
 - 쿠키 삭제하는 방법 
 

 
![Untitled (2)](https://user-images.githubusercontent.com/104877508/190898885-f0a3d061-ff58-416f-9882-1bb9c68046fd.png)
 
## ROWBOUNDS
 
rows = new RowBounds((cPage - 1) * numPerPage, numPerPage);
 
한페이지당 보일 상품 개수 : 12개 
 
cPage : 2
 
=> 
 
RowBounds( 12 ,12 ) = 24개의 상품 가져와서 앞에 12개는 건너뜀 
 
즉 1페이지에 보일 상품을 건너뛰고 2페이지에 보일 상품만.

RowBounds(int offset, int limit) 
 
=> 
 
offset은 데이터를 가져오는 시작점에서 
 
얼마나 떨어진 데이터인지를 의미하며
 
limit은 몇 개의 값을 가져올지를 의미한다.
 
https://github.com/helpmez/spring_shoeper/blob/5210c2b8deb3936b6fd9cd5fb1aa6a1cb68aeff7/SHOEPER_Project-master/src/main/java/com/shoeper/shoeperApp/product/model/dao/ProductDAOImpl.java#L19-L31
 

## 해시암호화 

 ![pw](https://user-images.githubusercontent.com/104877508/190898883-9e485ce1-af11-4c6b-a0aa-7ae099707a5f.png)
 
 
 * BCryptPasswordEncoder

 스프링 시큐리티(Spring Seurity) 프레임워크에서 제공하는 클래스 중 하나로 비밀번호를 암호화하는 데 사용할 수 있는 메서드를 가진 클래스.

BCrypt 해싱 함수(BCrypt hashing function)를 사용해서 비밀번호를 인코딩해주는 메서드(encode)와 사용자의 의해 제출된 비밀번호와 
 
저장소에 저장되어 있는 비밀번호의 일치 여부를 확인해주는 메서드(matchers)를 제공.
 
</div>
</details>


## 개발 환경 및 도구

|         |          |
| ------ | ------ |
| 운영체제 | Windows10 OS x64
|   프레임워크    |   Spring Framework 3.1       |
|    서버     |   Apache Tomcat 9.0      | 
|     언어      |    Java 11.0.8        | 
|    DBMS      |    Oracle DB 11g Express Edition 11.2.0.2.0 (64bit)        |  
|    통합개발환경       |    sts-3.9.16.RELEASE       |



## 라이브러리

|         |          |
| ------ | ------ |
| json 20210307 | gson 2.8.6 |
| commons-dbcp 1.4 | myBatis 3.5.6 |
| mybatis-spring 2.0.6 | ojdbc6 11.2.0.4 |
| lombok 1.18.18 | spring-security-core 5.3.6 RELEASE 
|commons-fileupload 1.4 | javax.mail 1.5.6 |


## ERD 설계

![erd](https://user-images.githubusercontent.com/104877508/190860268-c79b47c1-5f8b-4207-8111-121bbcbd56c0.png)

클릭시 상세화면으로 볼 수 있습니다
|   테이블      |    컬럼      |   설명  |
| ------ | ------ |------ |
|   PURCHASE     |  PURCHASE_STATUS        |    1 : 배송준비 , 2 : 배송중 , 3: 구매완료 , 4 : 후기작성완료 |
|     PRODUCT    |   PRODUCT_SIZE       |   중고상품의 사이즈        |
|     PRODUCT    |     PRODUCT_TYPE     |     1 : 브랜드상품, 2 : 중고상품      |
|     PRODUCT    |     PRODUCT_CATEGORY    |   1 : 운동화 , 2: 남성용구두, 3: 여성용구두, 4: 부츠 , 5: 샌들     |
|     PRODUCT    |     PRODUCT_STOCK_240,250,260,270,280     |     브랜드 상품의 사이즈      |
|   MEMBER      |    LOGIN_TYPE     |    1: 기업회원 2: 일반회원  |




