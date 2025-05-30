# 🥗 MEALPICK

MEALPICK은 사용자 맞춤형 식단을 추천하고, 간편하게 주문할 수 있는 밀키트 쇼핑몰 웹 서비스입니다.
전문가가 설계한 건강한 식단과 신선한 재료, 맞춤형 추천 시스템을 통해 바쁜 현대인을 위한 스마트한 식생활을 지원합니다.


### 📌 프로젝트 개요

[프로젝트 발표.pdf](https://github.com/user-attachments/files/20277596/default.pdf)

● 프로젝트명: MEALPICK

● 목표: 사용자 건강 정보 및 선호도에 기반한 맞춤형 식단 추천 + 밀키트 주문 서비스

● 기획 의도: 건강, 저속노화, 지속가능한 식생활을 도와주는 식단 추천 기반 쇼핑몰 구축


### 🔑 주요 기능

🍱 밀키트 판매

● 알레르기 및 비선호 식품 알림

● 회원 별 추천 밀키트


🏅 회원 등급 및 혜택

● 등급: 뉴픽 → 라이트픽 → 굿픽 → 탑픽 → VVIPICK (5단계)

● 혜택: 할인율, 포인트 적립률, 쿠폰, 무료 시식 제공 등


👨‍👩‍👧‍👦 그룹 회원 시스템

● 그룹 단위 구매 금액 공유

● 그룹 멤버 전원 혜택 공유

● 그룹 가입/채팅 기능


💳 결제 및 포인트

● 포인트 페이백 시스템

● 결제 시 회원 등급별 포인트 적립

● 포인트를 결제에 사용 가능


🗣 커뮤니티 기능

● 사용자 간 식단/건강 정보 공유

---


## 📆 개발 기간

● 25.03.10 ~ 25.04.14


## 팀 소개
|이름|역할|담당 기능|깃허브|
|------|---|---|---|
|천상욱|팀장, 프론트엔드, 백엔드|마이 페이지, 관리자 페이지, 소개 페이지|https://github.com/chonsa29|
|윤수빈|프론트엔드, 백엔드|장바구니, 메인 페이지, 커뮤니티(레시피, 그룹), 그룹 시스템(채팅)|https://github.com/sbsssb|
|조나경|프론트엔드, 백엔드|단품 상품 페이지, 상세보기 페이지|https://github.com/jonagyeong|
|나예린|프론트엔드, 백엔드|문의, 결제 시스템|https://github.com/nerongnyr|
|이흥열|프론트엔드, 백엔드|회원가입,  로그인|https://github.com/LHY950626|

## 🛠️ 기술 스택
|구분|기술|
|------|---|
|Frontend|Vue 3, JavaScript, HTML, CSS|
|Backend|Java (Spring MVC), MyBatis|
|Database|Oracle|
|기타|JSP, AJAX (jQuery), LocalStorage 사용 등|

## 📂 프로젝트 구조

```bash
mealpick/
├── pom.xml
├── README.md
├── schema.sql
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/demo/
│   │   │       ├── common/               # 공통 설정 및 유틸
│   │   │       ├── config/               # 보안 및 환경 설정
│   │   │       ├── controller/           # 컨트롤러 (웹 요청 처리)
│   │   │       ├── dao/                  # 서비스 로직
│   │   │       ├── mapper/               # MyBatis 매퍼 인터페이스
│   │   │       └── model/                # VO/DTO 클래스
│   │   ├── resources/
│   │   │   ├── application.properties    # 환경 설정
│   │   │   └── mybatis-mapper/           # XML 매퍼 (sql-*.xml)
│   │   └── webapp/
│   │       ├── css/                      # 전역 CSS 파일
│   │       ├── js/                       # JavaScript 파일
│   │       ├── img/                      # 이미지 리소스
│   │       └── WEB-INF/
│   │           ├── common/              # 헤더/푸터 JSP
│   │           ├── cart/                # 장바구니/결제 JSP
│   │           ├── chatting/            # 채팅 JSP
│   │           ├── community/           # 커뮤니티 관련 JSP
│   │           ├── help/                # 공지, 문의 관련 JSP
│   │           ├── member/              # 회원가입/마이페이지 JSP
│   │           └── product/             # 상품 정보 JSP
└── test/
    └── java/com/example/demo/           # JUnit 테스트
```

---
## 📸 시연 영상
https://www.youtube.com/watch?v=F9O0MT5TcLo&feature=youtu.be

