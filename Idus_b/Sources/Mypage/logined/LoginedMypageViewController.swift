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
        
        // 프로필 이미지 원형으로 만들기
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
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
                    
                    let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
                    self.changeRootViewController(loginViewController)
                }
            }
        }
        
        // 네이버 소셜로그인 로그아웃(토큰 제거)
        loginInstance?.requestDeleteToken()
        
    }
    
    
    // MARK: - 이메일 가입 유저 정보 가져오기
    func getEmailUserInfo(_ parameters: EmailLoginRequest, delegate: EmailLoginViewController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .get, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmailLoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLogin(result)
                        // 이메일
//                        self.emailLabel.text =
                        // 이름
//                        self.nameLabel.text =
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2020: delegate.failedToRequest(message: "유효하지않은 이메일입니다.")
                        case 2022: delegate.failedToRequest(message: "유효하지않은 비밀번호입니다.")
                        case 2025: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 3014: delegate.failedToRequest(message: "없는아이디거나 비밀번호가틀렸습니다.")
                        case 3020: delegate.failedToRequest(message: "탈퇴한회원입니다.")
                        case 3021: delegate.failedToRequest(message: "정지된회원입니다.")
                        default: delegate.failedToRequest(message: "피드백을 주세요.")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
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
        let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
        self.changeRootViewController(loginViewController)
    }

    // 모든 error
    @objc func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
}
