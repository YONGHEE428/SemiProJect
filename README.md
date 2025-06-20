![Image](https://github.com/user-attachments/assets/a51b5362-b882-4c86-9298-c1fb17927778)

# 쇼핑몰 프로젝트
쌍용아카데미 제4강의장 1조

## 목차
1. 개요
2. 팀소개
3. 기술 스택
4. ERD
5. 주요기능
6. 프로젝트 시연
7. 후기

# 1. 개요
**[의류 쇼핑몰 웹사이트 개발 프로젝트 개요]**

본 프로젝트는 5인 팀이 협업하여 개발한 세미프로젝트형 의류 쇼핑몰 웹 애플리케이션입니다. 사용자는 카테고리별(Top, Bottom, Outer, Accessory, Shoes)로 등록된 제품을 열람하고, 위시리스트 및 장바구니 기능을 통해 관심 상품을 저장하거나 즉시 결제를 진행할 수 있습니다.

관리자(Admin)는 상품을 등록/수정/삭제할 수 있으며, 실시간으로 주문 및 회원 데이터를 관리할 수 있습니다. 회원가입 시에는 무작위 일련번호를 문자로 전송하는 SMS 인증 API 기능도 포함되어 있어, 인증 기반의 가입 프로세스를 구현하였습니다.

**주요 기능:**
+ 관리자 상품 등록/관리 (카테고리별)
+ 고객용 위시리스트 / 장바구니 / 구매 기능
+ 회원가입 시 문자 인증 API 연동
+ 결제 기능 및 주문 이력 관리

본 프로젝트는 역할 분담 기반 팀 협업으로 진행되었으며, Git을 통한 버전 관리와 정기적인 회의를 통해 안정적이고 확장 가능한 쇼핑몰 시스템을 구축하였습니다.

# 2. 팀소개
+ **팀장**  박용희 @dydgml428
+ **팀원**  손현정 @yjyj0234
+ **팀원**  현승윤 @hyeonsy99
+ **팀원**  이창연 @changyeonyes
+ **팀원**  원주희 @juxxi054
  
## 2.1 역할 분담
### **박용희**
+  메인페이지
+  로그인 / 회원가입
+  마이페이지
  
### **손현정**
+ 카테고리별 페이지
+ 위시리스트 페이지
+ 결제 페이지
  
### **현승윤**
+ 고객센터 페이지
+ 장바구니 페이지
+ 구매, 반품 상세 페이지

### **이창연**
+ 관리자 페이지
  
### **원주희**
+ 제품 상세페이지
+ 리뷰,문의 게시판

# 3. 기술 스택
  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"><img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"><img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"><img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"><br>
  <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white"><img src="https://img.shields.io/badge/amazonaws-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white"><img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"><br>
  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"><br><img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
  
# 4. ERD
<img width="858" alt="image" src="https://github.com/user-attachments/assets/7a299fab-a8ce-46ed-90e6-ed0f5749b5d3" />

# 5. 시스템 아키텍쳐
<img width="1100" alt="image" src="https://github.com/user-attachments/assets/d6e05f9d-fce7-4314-86df-ea76eff38033" />



# 5. 주요기능
## - 5.1 메인 페이지
![image](https://github.com/user-attachments/assets/a4b2cdc9-114b-4473-99af-1d2f486031b1)

<br>

## - 5.2 관리자 상품 등록/관리 (카테고리별)
|<img width="841" alt="스크린샷 2025-06-16 오후 5 13 49" src="https://github.com/user-attachments/assets/6afb2c30-ca49-489d-ae7a-abebf53f0556" />|
|-|
|상품 수정 페이지|

|<img width="769" alt="스크린샷 2025-06-16 오후 5 13 38" src="https://github.com/user-attachments/assets/16db363c-cd2f-4d0e-beef-31781a5a59f9" />|
|-|
|상품 관리 페이지|

### 관리자 페이지 주요 기술 포인트
#### aws s3 연결
이미지파일을 aws s3에 올리고 db에는 aws s3 url을 연결하였습니다.
처음에는 DB에 BLOB(Binary Large Object)형식으로 이미지파일을 업로드 했었는데, 이미지 파일이 많아지면 
DB가 올려져 있는 aws의 비용문제와 서버 과부하로 인한 속도 저하가 일어나기 때문에 aws s3를 도입하게 되었습니다.
해당 방식을 통해 비용을 감소시키고 속도를 향상시켰습니다
<br>
<br>
#### 유연하고 확장가능한 상품 db 설계
![image](https://github.com/user-attachments/assets/2c91e49d-13ad-4a1a-894e-91959b6f4498)

한 상품에 여러 색깔과 각 색깔에 대한 사이즈, 수량이 다르기 때문에 한 상품의 여러 색깔,사이즈,수량을 상품 옵션이라는 테이블로 만들었습니다.
해당 방식을 통해 product 테이블과 product_option 테이블을 1:N 관계로 분리하여 설계 및 구현하였습니다.
중복 데이터를 최소화하고 데이터 일관성 및 커리 효율성을 높였습니다.



<br>

## - 5.3 고객센터 게시판 고객용 / 관리자용
|![게시판 고객화면 ](https://github.com/user-attachments/assets/99c064b9-32f9-4a4c-9a7d-98c47fe0fc58)|
|-|
|고객용 게시판 화면|

|![3](https://github.com/user-attachments/assets/1baaf139-7b33-42ad-854c-22ce278318bf)|
|-|
|관리자 전용 화면 |

|![1](https://github.com/user-attachments/assets/f644c046-c8da-4c29-9e58-591bf48b3cb6)|
|-|
|버튼작동방식 / 팝업창으로 수정창 글쓰기창 구현 |

## - 5.4 상품 카테고리, 고객용 위시리스트 / 장바구니 / 구매 기능
<br>

|![cate1](https://github.com/user-attachments/assets/5dbf1395-4d57-48d3-8cf1-6dc9fd9a1411)|
|-|
|상품 카테고리|
### 카테고리 페이지 주요 기술 포인트
#### 무한스크롤 기능 
  window.onscroll 이벤트를 사용하여 사용자가 스크롤을 내리는 것을 지속적으로 감지 후,
  사용자가 페이지 하단에 도달하면 새로운 페이지를 불러오는 함수룰 호출하고, 다음페이지가 자동으로 생성되도록 구현.
#### 리모컨 기능(화면 우측 고정)
  페이지의 제일 위, 제일 아래로 옮길수있는 버튼, 사용자가 추가한 위시리스트만 볼수있는 페이지, 장바구니 페이지,
   카카오톡 상담 클릭 시 쇼핑몰 카카오톡채널로 이동하게 하는 버튼 구현
   
## - 5.5 회원가입 시 문자 인증 API 연동
<br>
  
## - 5.6 결제 기능 및 주문 이력 관리
<br>

## - 5.7 상세 페이지 

### 상세페이지 기술 설명

![스크린샷 2025-06-13 103930](https://github.com/user-attachments/assets/c6efe7b7-5716-4e71-b13a-515dd2547d22)
|-|
|상품상세 페이지|

![스크린샷 2025-06-13 155159](https://github.com/user-attachments/assets/46657762-8372-4aaf-9320-5571c0e01f81)
|-|
|상품 관리 페이지 문의 및 리뷰 구현|
<br>

■ 복합 인터페이스 & SPA급 UX <br>
모달, 탭, 슬라이드 패널 등 → 실제 쇼핑몰에서 요구되는 다양한 UI/UX를 JSP+JS만으로 부드럽게 구현 <br>
■ 데이터 기반 동적 UI & 완전 모듈화 <br>
DAO/DTO 패턴 활용 → 상품/옵션/회원/찜/문의/리뷰 등 다양한 DB 데이터와 실시간 연동 <br>
DB 연동 및 상태 변경 → 각종 정보(상품/옵션/회원/리뷰/문의 등) 조회·삽입·수정 완비 <br>
JSP Include 구조 → 리뷰, 문의, 모달, 안내 등 각 기능별 파일 분리 유지보수와 재사용성 극대화 <br>
세션 및 상태 관리 → 로그인/비로그인 별로 찜, 장바구니, 문의작성 등 UI·기능 제어




  
# 6. 프로젝트 시연

# 7. 보완 & 개선 

# 8. 후기







