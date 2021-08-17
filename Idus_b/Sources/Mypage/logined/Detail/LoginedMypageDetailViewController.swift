//
//  LoginedMypageDetailViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import NaverThirdPartyLogin
import Alamofire

class LoginedMypageDetailViewController: BaseViewController {
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginInstance?.delegate = self
    }

    // MARK: - 로그아웃 버튼
    @IBAction func logoutBtn(_ sender: UIButton) {
        
        // 카카오 연결 끊기 (+ 로그아웃)
        if (AuthApi.hasToken()) {
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("unlink() success.")
                    
                    let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
                    self.changeRootViewController(loginViewController)
                }
            }
        }
        
        // 네이버 소셜로그인 로그아웃(토큰 제거)
        loginInstance?.requestDeleteToken()
        
    }

}

// MARK: - 네이버 로그인 프로토콜 채택
extension LoginedMypageDetailViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공한 경우 호출
    @objc func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {

        print("Success login")
    }

    // referesh token
    @objc func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
//        loginInstance?.accessToken
    }

    // 로그아웃
    @objc func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
        let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
        self.changeRootViewController(loginViewController)
    }

    // 모든 error
    @objc func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
}
