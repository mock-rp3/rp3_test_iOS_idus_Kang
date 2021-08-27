//
//  LoginedMypageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import NaverThirdPartyLogin
import Alamofire

class LoginedMypageViewController: BaseViewController {
    
    lazy var dataManager: LoginedMypageDataManager = LoginedMypageDataManager()
    
    // UserDefault
    var loadedUserIdx = UserDefaults.standard.value(forKey: "userIdxKey") as? Int
    var loadedJwt : String = UserDefaults.standard.value(forKey: "jwtKey") as! String
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var myLevel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyNum: UILabel!
    @IBOutlet weak var couponNum: UILabel!
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginInstance?.delegate = self
        getNaverUserInfo()
        if (AuthApi.hasToken()) {
            getKakaoUserInfo()
        }
        
        makeCircleImg()
        
        // Request UserLoginInfo
        dataManager.getUserInfo(userIdx: loadedUserIdx ?? 17, jwt: loadedJwt, delegate: self)
        
    }
    
    // MARK: - Actions
    
    @IBAction func messageBtn(_ sender: UIButton) {
    }
    
    @IBAction func noticeBtn(_ sender: UIButton) {
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
    }
    
    @IBAction func checkLebelBtn(_ sender: UIButton) {
    }
    
    @IBAction func deliveryBtn(_ sender: UIButton) {
    }
    
    @IBAction func likesBtn(_ sender: UIButton) {
    }
    
    @IBAction func followsBtn(_ sender: UIButton) {
    }
    
    @IBAction func reviewsBtn(_ sender: UIButton) {
    }
    
    @IBAction func settingBtn(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "LoginedMypageStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMypageDetailViewController")
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // 로그아웃 버튼
    @IBAction func logOutBtn(_ sender: UIButton) {
        // 카카오 연결 끊기 (+ 로그아웃)
        if (AuthApi.hasToken()) {
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("unlink() success.")
                    
                    // 유저 디폴트로 userIdx와 jwt에 빈 값 저장
//                    UserDefaults.standard.set(0, forKey: "userIdxKey")
//                    UserDefaults.standard.set("", forKey: "jwtKey")
                    
                    let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
                    self.changeRootViewController(loginViewController)
                }
            }
        }
        
        // 네이버 소셜로그인 로그아웃(토큰 제거)
        loginInstance?.requestDeleteToken()
        
        if loadedJwt != "" {
            let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
            self.changeRootViewController(loginViewController)
        } else {
            // 유저 디폴트로 userIdx와 jwt 빈 값 저장
//            UserDefaults.standard.set(0, forKey: "userIdxKey")
//            UserDefaults.standard.set("", forKey: "jwtKey")
        }
    }
    
    // MARK: - 프로필 원형 이미지 만들기
    func makeCircleImg() {
        // 프로필 이미지 원형으로 만들기
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
    }
    
    // MARK: - 카카오 유저 정보 가져오기
    func getKakaoUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                
                // 닉네임
                self.nameLabel.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    // 프로필 이미지
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - 네이버 RESTful API, id가져오기
    func getNaverUserInfo() {
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
        guard let profile_image = object["profile_image"] as? String else { return }
        
        print(email)
        
        // 이름
        self.nameLabel.text = "\(name)"
        // 프로필 이미지
        let url = URL(string: "\(profile_image)")
        do {
            let data = try Data(contentsOf: url!)
            self.profileImageView.image = UIImage(data: data)
        }
        catch { }
        
      }
    }
    
}

// MARK: - 네이버 로그인 프로토콜 채택
extension LoginedMypageViewController: NaverThirdPartyLoginConnectionDelegate {
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
        
        // 유저 디폴트로 userIdx와 jwt에 빈 값 저장
//        UserDefaults.standard.set(0, forKey: "userIdxKey")
//        UserDefaults.standard.set("", forKey: "jwtKey")
        
        let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
        self.changeRootViewController(loginViewController)
    }

    // 모든 error
    @objc func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
}

// MARK: - userLooginIfo
extension LoginedMypageViewController {
    
    func successGetInfo(result: GetUserInfoResult) {
        
        // 이메일 가입 유저 정보 가져오기
        // 프로필 이미지
        let url = URL(string: result.profileImg)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { self.profileImageView.image = UIImage(data: data!)
            }
        }
        print(result.grageName)
        myLevel.text = result.grageName
        nameLabel.text = result.name
        moneyNum.text = "\(result.reserves)"
        couponNum.text = "\(result.coupon)"
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
