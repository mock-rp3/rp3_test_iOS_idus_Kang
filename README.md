# **rp3_test_iOS_idus_Kang 개발일지**

***

## 21.08.19
+ 메인 페이지 작업 30%
  - 자동 콜렉션뷰 배너 완성 100%
  - 페이징 킷 활용해 콜렉션뷰 메뉴와 콜렉션뷰 컨텐츠 생성 100%
  - 테이블 뷰 안에 콜렉션 뷰 넣기 시도중 50%
  - 메인 페이지 속 세 가지 뷰 UI 구현 30%
  - 메인 페이지 UI 구현 20%
+ 키보드 가림 문제 해결

***

## 21.08.18
+ 로그인/회원가입 페이지 작업 100%
  - 페이지 UI 구성 100%
    - 이메일 회원가입 동의 체크박스 구현 100%
    - 배경 화면 이미지 변환되는 기능 구현 100%
  - 소셜로그인 연동
    - 카카오 100%
    - 네이버 100%
  - 이메일 회원가입/로그인 구현
    - 이메일 회원가입 100%
    - 이메일 로그인 100%
+ ImageView 애니메이션 View 애니메이션 효과 곁들이는 법 알게 돼서, 로그인 페이지 배경 이미지 변환 작업 해결함

***

## 21.08.17
+ 마이페이지 로그인 여부 확인 가능한 UI(프로필정보)
  - 소셜 로그인 유저 정보 받아오기 100%
  - 이메일 로그인 유저 정보 받아오기(API 구현 아직 안돼서 못받음)
+ 로그인/회원가입 페이지 작업 90%
  - 페이지 UI 구성 90%
    - 이메일 회원가입 동의 체크박스 구현 0%
    - 배경 화면 이미지 변환되는 기능 구현 30%
  - 소셜로그인 연동
    - 카카오 100%
    - 네이버 100%
  - 이메일 회원가입/로그인 구현
    - 이메일 회원가입 100%
    - 이메일 로그인 100%
+ 메인페이지 UI 구성 10%
+ 로그인 페이지 풀스크린 못해 헤매다가 satus bar 숨겨 풀스크린 하는 법 알게 돼 해결함

***

## 21.08.16
+ 메인페이지 UI 구성 10%
+ 마이페이지 UI 구성 100%
+ 로그인/회원가입 페이지 작업 70%
  - 페이지 UI 구성 100%
  - 소셜로그인 연동
    - 카카오 100%
    - 네이버 100%
  - 이메일 회원가입/로그인 구현
    - 이메일 회원가입 0%
    - 이메일 로그인 0%

***

## 21.08.15
+ LaunchScreen.storyboard 작업 100%
+ 첫 화면(로그인/회원가입 페이지) 작업 30%
  - 페이지 UI 구성 100%
  - 소셜로그인 연동
    - 카카오 0%
    - 네이버 0%
  - 이메일 회원가입/로그인 구현
    - 이메일 회원가입 0%
    - 이메일 로그인 0%

#### 템플릿 파일 토대로 파일 구성
+ 기본 설정
  - iOS 13부터 지원
  - iPhone 방향 - Portrait만 유지
  - iPad 지원, 방향 - 완전 삭제
  - Status bar style - dark Content
  - Info.plist-Appearance - Light
+ Configuration 폴더
  - Constant.swifft - 자주 쓰이는 상수 값 저장
  + Certificate 폴더 - 인증서 저장
  + Secret 폴더 - 중요한 값 저장
  + Font 폴더 - 폰트 파일(otf, rtf) 저장
  + Extension 폴더 - 기존 클래스의 extension 파일 저장
  + Custom 폴더 - 커스텀 클래스 저장
  + Base 폴더 - 기본으로 사용되는 클래스 저장
+ Sources 폴더
  + Splash 폴더
    - SplashStoryboard.storyboard - 첫 화면 구성
    - SplashViewController.swift - 첫 화면 컨트롤러
  + Action 폴더
    - 화면 전환 - modal, navigation, window 이용
    - 인디케이터 - 기본, gif 커스텀
    - 경고창, 팝업 - alert, action sheet, 하단 custom
  + Network 폴더
    - 로그인 API
      - method : POST
      - encodable을 이용한 request entity
      - decodable을 이요한 response entity
    - API를 이용한 정보 가져오기
      - method : GET
      - decodable을 이용한 response entity
+ Design Pattern
  - View
    - View(.xib) + ViewController(.swift)
    - View와 ViewController는 @IBOutlet과 @IBAction으로 연결
    - 눈에 보이는 UI적 부분과 사용자 인터렉션에 의한 동작을 다루는 역할
  - DataManager
    - 네트워크 통신을 담당하는 역할
    - Alamofire 이용
  - Entity
    - Encodable, Decodable을 이용한 입/출력 객체
    - View와 DataManager를 연결하는 역할

***

## 21.08.14 
+ 21.08.17 14:00 까지 구현할 사항 확인
  - 로그인
  - 회원가입
  - 소셜로그인 연동 (카카오, 네이버)
  - 내정보
  - 로그인 여부 확인 가능한 UI(프로필정보)
+ 기획서 제출 (100%)
+ README.md 생성
