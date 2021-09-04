# **본 템플릿은 (주)소프트스퀘어드의 템플릿으로 상업적인 용도의 활용 및  무단배포를 금합니다.**

***

# **rp3_test_iOS_idus_Kang 개발일지**


***

## 21.09.04
+ 작품 옵션 셀 취소 버튼 누르면 삭제되는 기능 추가
  - 셀 버튼 클릭 이벤트 넘겨줄 클로저 작성 후, 컨트롤러 테이블 델리게이트에서 이벤트 처리
  - 셀 취소 버튼 누르면, 데이터 셀 삭제

***

## 21.09.03
+ 작품 주문 옵션 정보 유저디폴트로 저장해 작품 주문 창으로 넘겨주는 작업 완료
  - 여러 옵션들 선택함에 따라 텍스트 더해서 최종 텍스트 따로 저장해서 넘겨줌
+ 작품 주문 창에서 옵션 수에 따라 가격 변동되는 작업 완료
  - 넘겨받은 String을 map으로 Int로 형 변환해 보기도 하고, 그냥 Int(Stirng)으로 계산 처리함
  - NumberFormatter().numberStyle = .decimal 로 금액 숫자 세자리마다 콤마도 넣어줌
+ 런치스크린 safe area로 돼있어서 풀스크린 안되던거 super view로 바꿔서 풀스크린으로 만듬
  - info.plist에서 Status bar is initially hidden까지 true로 해줘서 status bar도 
+ 앱 아이콘 설정 완료
  - https://appicon.co/ 사이트에서 1024x1024만 있으면 앱 아이콘 폴더 쉽게 만들 수 있음

***

## 21.09.02
+ 작품 주문 옵션 테이블 in 테이블 모달 에러 발견
  - 작품 주문 옵션 모달 순서대로 누르면, 두번째 테이블셀은 첫번째 테이블 뷰 셀 개수대로 나옴
    - 셀 개수에 넣는 데이터가 테이블이 들어있는 테이블셀을 클릭했을 때, 들어오기 때문에 처음 누른 셀에 따라 개수 정해지는 거였음.
  - 테이블을 하나 열었다가 닫고 다른 테이블을 열면, 동일한 테이블 셀 데이터가 나옴
  - 근데 또 두번째 테이블을 먼저 닫고 첫번째 테이블을 닫고 순서대로 누르면, 셀 개수가 정상적으로 나옴
  - 두번째 테이블 누르고 첫번째 테이블 누르면, index out of range 에러 발생함
    - 셀을 눌렀을 때 셀 안에 있는 테이블 데이터를 리로드되게 해서 해결함. (기존에 있던 tableView.reloadRows(at: [indexPath], with: .automatic) 코드를 지우고 tableView.reloadData() 코드로 바꾸니 간단하게 해결함)

***

## 21.09.01
+ 작품 주문 옵션 API 배열 개수에 맞게 표시하게끔 업데이트
  - 작품 주문 옵션 API 배열 정보 유저 디폴트로 배열 하나씩 받아서 처리

***

## 21.08.31
+ 작품 상세 페이지 UI API 연동 완료
  - 상품 설명란은 api에 문단 띄어쓰기 명령어까지 들어있어서 일단 더미데이터로 대체함
+ 작품 주문 옵션 UI API 연동 완료

***

## 21.08.30
+ 작품 상세페이지에서 페이저로 구현한 작품이미지들 중, 컬렉션뷰는 REST API 잘 받아와서 처리했는데, 페이지 컨트롤러를 코드로 구현했더니, 코드 실행순서가 API보다 앞이어서 이미지가 매핑안돼 곤란했음.
  - 싱크 처리해야하나 싶다가, 그냥 유저디폴트로 앞에서 먼저 저장해놓고 사용함
  - 오토레이아웃도 코드로 구현해보며, 드디어 상품 상세페이지 페이지 컨트롤러와 컬렉션뷰에 이미지 매핑하고, 두 뷰의 현재 이미지 위치 연결하여, 하나라도 움직이면 같이 움직이게 만듬

***

## 21.08.29
+ 소셜로그인 로직 변경 후, 자꾸 아래 에러 발생함
  - canOpenURL: failed for URL: "naversearchapp://" - error: "The operation couldn’t be completed. (OSStatus error -10814.)"
  - 원인은 로그아웃을 안해주고 앱 껐다 키면서 자꾸 로그인 시도 해서 그런 거였음. 앱 꺼지면 무조건 로그아웃되게 생명주기에 추가함.
+ 비회원 상태에서 상품 상세 페이지에서 구매하기 버튼 누르면 로그인하라는 알림창 뜨게 함.
  - 확인 버튼 누르면 로그인 창으로 화면 이동함

***

## 21.08.28
+ 소셜로그인 시 회원가입API 활용하여, 정보넘겨주고, 이미 회원가입된 소셜 id일 경우, 그냥 로그인 로직 타게끔 함

***

## 21.08.27
+ 작품 상세페이지 정보 GET으로 받아오는 것은 성공했으나, 결과값중, 리스트 안의 리트스 속에 있는 이미지 url 값을 계속 못받아와서 몇시간을 그냥 날리고, 이미지는 그냥 더미데이터 얹어놓아 둠..
+ 못다한 나머지 페이지들은 이미지로 대체하고, 버튼들에는 알림창이 뜨게끔 만들며 마무리함.
+ 유저디폴트로 루트 텝바 컨트롤러를 구분했는데, 그 과정에서 소셜로그인 정보와 충돌이 생기는 이슈 발생한 것을 영상을 찍으며 발견함.
  - 유저디폴트 저장 코드를 없애줌으로서 일단 영상을 마무리했는데, 마이페이지로 넘겨주던 이메일 회원 정보까지 막혀서 난감했음.
+ 최종적으로 API는 6개 엮었고, 페이지는 17개 정도 가량 꾸밈
  - 로그인 메인, 회원가입, 이메일 로그인, 메인 페이지 페이징 킷 메뉴-콘텐츠 3개(투데이, 실시간, NEW), 투데이 테이블 셀 안에 컬렉션 뷰 구현(메인페이지 자동 이동 배너, 카테고리, 연관 작품, 테마 작품) 4개, 마이페이지, 작품 상세 페이지, 작품 구매 옵션 페이지, 작품 주문 페이지, 작품 결제 페이지, 클래스&검색&카테고리&상세마이페이지 등의 캡쳐이미지 넣어서 꾸민 것들 제외

+ +a
  - 폴더 구조 업데이트
  - 에러 났던 유저디폴트 원인 찾고 구조 갱신
    - 마이페이지에서 사용자 정보를 띄우기 위해, 이메일 로그인했을 때의 유저인덱스와 jwt 값을 유저디폴트로 강제 언랩핑 옵셔널 처리해서 저장하게 한 것이 원인.
    - 이메일 로그인 이력 없이, 소셜로그인 했을 때를 고려해 nil값 방지를 해줬어야 했음.(옵셔널 바인딩은 코드가 길어, 그냥 nil 에 대비해 디폴트 값 설정함
    - 원래 구조에서는 이메일 로그인을 한 번만이라도 했으면 기본값으로 들어가 있었기 때문에 잘 구동 됐었는데, 영상을 찍기 위해 앱을 지웠다가 다시 깔고 소셜로그인부터 하니 에러가 발생했던 것임.
    - 로그아웃할 때마다 유저디폴트를 UserDefaults.standard.removeObject(forkey: forkey) 코드로 지워주는 구조 추가하며 초기값을 nil값으로 세팅함
  - 영상에서 네이버 로그인하고 내정보 페이지에서 사진이 바뀌지 않았는데, 그건 네이버로 로그인하기 창에서 추가 제공 항목에서 프로필사진을 체크하지 않아서 그랬던 것임.(네이버 아이디를 입력하는 단계가 없는 것은, 시뮬레이터의 인앱 사파리 브라우저에서 네이버 로그인이 이뤄지는데, 이미 로그인 돼 있기 때문임.)

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
+ 연동한 API 개수 중간 체크
  - 이메일 회원가입 POST, 이메일 로그인 POST, 회원정보 GET, 연관된 작품정보 GET, 키워드 작품정보 GET, 작품 상세페이지 정보 GET
  - 총 6개

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
