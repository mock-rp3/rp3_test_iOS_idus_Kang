# **rp3_test_iOS_idus_Kang 개발일지**

***

## 21.08.24
+ 작품 상세 페이지 UI 구현 80%
  - 확대 이미지 및 미리보기 이미지 
    - 콜렉션 뷰 + 페이지 뷰 컨트롤러 페이징
  - 네비게이션 바 이전 버튼 구현 및 우측 상단 버튼 UI 배치
  - 찜, 구매하기, 선물하기 버튼 UI 배치
    - 구매하기 로직 아직 구현 못함
  - 더미 데이터 구축해서 실제 작품 페이지 이미지 그대로 하나 구현함

***

## 21.08.23
+ 셀 클릭 정보 못받아오던 문제 원인 발견
  - 페이징 킷을 쓰면서 메인 뷰컨트롤러 뷰 안에 뷰컨트롤러를 넣어서 충돌났던 거였음.
    - 13:39: 원인은 발견했으나, 해결은 못한 상태
    - 14:06: Closure Source code와 함께 써서 해결!!
+ 작품 상세 페이지 이미지 UI 구성 100%
  - 테이블 뷰 > 테이블 뷰 셀 > 컬렉션 뷰 + 페이지 뷰 컨트롤러 연결 페이저로 해결

***

## 21.08.22
+ 메인 페이지 > 테이블뷰 > 테이블뷰 셀 > 컬렉션뷰 > 컬렉션뷰 셀 안에 있는, 상품 상세 페이지로 이동하는 프로토콜&델리게이션 작업만 어제 새벽부터 작업중..
  - 새로운 프로젝트 열어서 테스트해본 결과 방식은 맞는데, 기존 프로젝트에 적용하면서 어디선가 셀 클릭 정보를 못받아오는 중임.

***

## 21.08.21
+ 메인 페이지 작업 60%
  - 자동 콜렉션뷰 배너 완성 100%
  - 페이징 킷 활용해 콜렉션뷰 메뉴와 콜렉션뷰 컨텐츠 생성 100%
  - 테이블 뷰 안에 콜렉션 뷰 넣기 100%
  - 메인 페이지 속 세 가지 뷰 UI 구현 30%
  - 메인 페이지 UI 구현 50%
    - 상품 콜렉션 뷰 추가 50%
+ 상품 페이지 작업 30%
  - 상품 상세 페이지 UI 구현 30%
    - 뷰 페이저 적용 50%
+ 테이블 뷰 셀에 팩토리 패턴 디자인 적용하려다가 인덱스 오류로 실패하고 하루 날림

***

## 21.08.20
+ 메인 페이지 작업 50%
  - 자동 콜렉션뷰 배너 완성 100%
  - 페이징 킷 활용해 콜렉션뷰 메뉴와 콜렉션뷰 컨텐츠 생성 100%
  - 테이블 뷰 안에 콜렉션 뷰 넣기 100%
  - 메인 페이지 속 세 가지 뷰 UI 구현 30%
  - 메인 페이지 UI 구현 30%
+ 테이블뷰 셀 안에 콜렉션 뷰 넣는 중 에러 다수 발생
  - 기존에 만들어 둔 자동 콜렉션뷰 배너를 활용하려다 보니, 코드가 자꾸 충돌하고 더 복잡해짐
  - Xib 파일 내에 뷰가 2개 이상이면 에러난다는 걸 알게 됨
  - 식별자를 처음에 선언해둔 것과 다르게 설정해서 몇시간을 헤맸음.
    - 새로 프로젝트를 열어서, 차근차근 해나가다 보니 하나하나 해결함.
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
