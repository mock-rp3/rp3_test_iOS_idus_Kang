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

class LoginedMypageDetailViewController: BaseViewController, NaverThirdPartyLoginConnectionDelegate {
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginInstance?.delegate = self
    }

    // 로그인에 성공한 경우 호출
    @objc func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {

        print("Success login")
    }

    // referesh token
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
    

    @IBAction func logoutBtn(_ sender: UIButton) {
        
        if (AuthApi.hasToken()) {
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")
                    
                    let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
                    self.changeRootViewController(loginViewController)
                }
            }
        }
        
        //        loginInstance?.requestDeleteToken()
    }

}
