//
//  LoginViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class LoginViewController: BaseViewController {
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let timeSelector: Selector = #selector(LoginViewController.updateTime)
    var index = 0
    var i = 0
    var images = [UIImage]()
        
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // status bar 숨겨 풀스크린 만들기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // 배경 이미지 배열
        while let image = UIImage(named: "login&SIgnupPage_background\(i)") {
            images.append(image)
            i += 1
        }
        
        // 배경 애니메이션
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    // MARK: - 배경 애니메이션 초별 업데이트
    @objc func updateTime(){
        self.index += 1
        if index >= images.count {
            index = 0
        }
        
        backgroundImageView.image = images[index]
        UIView.transition(with: self.backgroundImageView,
                          duration: 3.0,
                           options: [.allowAnimatedContent, .transitionCrossDissolve],
                           animations: { self.backgroundImageView.image = self.images[self.index] },
                           completion: nil)
    }
    
    // MARK: - 카카오 로그인
    
    @IBAction func kakaoLoginBtn(_ sender: UIButton) {
        
        // 카카오톡 설치 여부 확인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
//        }
        
        // 시뮬레이터 웹 브라우저를 통해 로그인
        // 기존 로그인 여부와 상관없이 로그인 요청(웹 브라우저에서 이미 카카오계정으로 로그인한 상태에도 로그인 화면을 출력)
        // 카카오톡 로그인 api 호출 결과를 클로저로 전달.
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
            if let error = error {
                // 예외 처리 (로그인 취소 등)
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
            
            //do something
                _ = oauthToken
                
            // 엑세스토큰
//            let accessToken = oauthToken?.accessToken
                
            //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
//            self.
            
            // 로그인 메인화면으로 이동
            let loginedMainTabBarController = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
                self.changeRootViewController(loginedMainTabBarController)
            }
        }
    }
    
    // MARK: - 다른 방법으로 가입하기:
    // 커스텀 UIAlertAction들이 있는 Action Sheet
    @IBAction func actionSheetWithCustomActionsButtonTouchUpInside(_ sender: UIButton) {
        let actionR = UIAlertAction(title: "이메일", style: .default) { action in
            
            //nextVC : popover 될 뷰
            let nextVC = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "EmailSignUpStoryboard")
            
            nextVC.modalTransitionStyle = .coverVertical
            nextVC.modalPresentationStyle = .fullScreen

            self.present(nextVC, animated: true, completion: nil)
                   
        }
        
        let actionG = UIAlertAction(title: "네이버", style: .default) { action in
            self.loginInstance?.delegate = self
            self.loginInstance?.requestThirdPartyLogin()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        
        self.presentAlert(
            title: "다른 방법으로 가입하기",
            preferredStyle: .actionSheet,
            with: actionR, actionG, cancelAction
        )
    }
    
    // MARK: - 네이버 로그인
    
    @IBAction func naverLoginBtn(_ sender: UIButton) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    // MARK: - 회원가입 없이 둘러보기
    
    @IBAction func noLoginBtn(_ sender: UIButton) {
        
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        changeRootViewController(mainTabBarController)
        
    }
}

// MARK: - 네이버 로그인 프로토콜 채택
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인에 성공한 경우 호출
    @objc func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        let loginedMainTabBarController = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
        changeRootViewController(loginedMainTabBarController)
        
        print("Success login")
    }
    
    // 접근 토큰 갱신
    @objc func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 로그아웃
    @objc func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    @objc func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
}
