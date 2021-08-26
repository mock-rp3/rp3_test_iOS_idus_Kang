# **rp3_test_iOS_idus_Kang 개발일지**

***

## 21.08.26
+ 메인 페이지 UI 및 API 엮는 작업 완료
  - 최근 본 관련 작품 테이블 셀
  - 키워드 관련 테마 작품 테이블 셀
+ api 받아올때, query string과 path variable 방식이 혼합돼 있어서 혼란스러웠음. 인코딩 방식이 다르다는 걸 깨닫고 해결함.
+ 이미지 로딩이 느려서 비동기 프롤그래밍을 하면 빨라질 줄 알았으나, 그저 서버 요청이 느려서 그런 거였음. 인디케이터를 적용하여 로딩되기까지 대기하게 만듦.
  - 데이터 패치 -> 스레드(백그라운드) 비동기
  - 이미지 랜더링 -> 메인스레드 비동기
+ 주문 페이지 UI 구현 완료
  - 주문 옵션 테이블 셀 가져오는 부분에서 막혀서 일단 화면전환으로 넘김
+ tableView에서 dequeuing 과정에서 업로드가 되는 문제 발생
  - 네트워킹 이후에 수동으로 tableView.reloadData()와 collectionView.reloadData() 해줘서 해결함 
+ 결제 페이지 UI 구현중..

***

## 21.08.25
+ 작품 구매 옵션 페이지 UI 구현 100%
  - 모달 기능은 뷰컨트롤러 따로 만들어서, 배경색 없애고 테이블뷰 하나 넣어서 모달 화면 띄움
  - 옵션 선택 기능은 테이블뷰 안에 테이블뷰 넣고, 선택에 따라 열고 닫히는 모달 구현
    - 라이브러리 가져다가 쓰면서 안쪽 테이블 셀에서 데이터 못가져오는 문제 발생
      - 셀 가져오는 부분에 BreakPoint 넣으면서 초기화 부분에 문제 있음을 발견하고 해결함
+ 작품 구매 옵션 선택 후 페이지 UI 구현 70%
  - 테이블 세팅 완료
  - 옵션 선택한 값을 받아와서 셀에 넘겨줘야 함
  - 구매 옵션 모달 창에서 옵션 선택 후 바뀌는 구매 모달 창을 내리는 부분에서 뷰가 겹쳐지는 문제 발생
      - dismiss 안하고 네비게이션으로도 뷰 바꿔보고, 모달 뷰로도 원래 창으로 돌아가게끔 해봤는데, 뷰가 위로 올라가는 바람에 일단 dismiss로 해둠
+ 비회원 마이페이지 UI 구성 완료
+ 로그인 회원 마이페이지 UI 구성 완료
  - 로그인 했을 때, UserDefault로 userIndex와 jwt 값을 저장하고, 마이페이지를 불러올 때 활용함
    - UserDefault로 값을 저장할 때, Int값도 String으로 전환돼서 문제 발생했었음. 로그인 단계별로 디버깅 해보며 해결.
  - 회원정보 GET API 엮는 중에, 서버분의 명세서 상 표시 돼 있는 자료형과 실제가 다른 게 있고, null값까지 표시가 안돼 있는 바람에 많은 시간을 허비함ㅠㅠ
    - https://app.quicktype.io/ 사이트를 통해 해결함

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
