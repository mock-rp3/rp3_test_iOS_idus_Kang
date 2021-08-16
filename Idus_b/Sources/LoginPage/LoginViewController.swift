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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = BaseViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
            let accessToken = oauthToken?.accessToken
                
            //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
            self.setUserInfo()
                
            let loginedMainTabBarController = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
                self.changeRootViewController(loginedMainTabBarController)
            }
        }
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                // 닉네임
//                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    // 프로필 이미지
//                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - 네이버 로그인
    
    @IBAction func naverLoginBtn(_ sender: UIButton) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
        
    @IBAction func logout(_ sender: Any) {
        loginInstance?.requestDeleteToken()
    }
    
    // RESTful API, id가져오기
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let nickname = object["nickname"] as? String else { return }
        
        print(email)
        
        // 이름
//        self.nameLabel.text = "\(name)"
        // 이메일
//        self.emailLabel.text = "\(email)"
        // 닉네임
//        self.nicknameLabel.text = "\(nickname)"
      }
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
        getInfo()
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
