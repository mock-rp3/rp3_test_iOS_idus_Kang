//
//  SignInViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit
import AuthenticationServices   // Apple Login

class SignInViewController: BaseViewController {
    lazy var dataManager: SignInDataManager = SignInDataManager()

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var appleLoginView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()
        
        // Apple Login Button
        let appleLoginButton = ASAuthorizationAppleIDButton()
        self.appleLoginView.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints { $0.center.equalToSuperview() }
        appleLoginButton.addTarget(self, action: #selector(appleLogin(_:)), for: .touchUpInside)
    }

    @IBAction func loginButtonTaapped(_ sender: UIButton) {
        // ID validation
        guard let id = idTextField.text?.trim, id.isExists else {
            self.presentAlert(title: "아이디를 입력해주세요")
            return
        }
        
        // Password validation
        guard let password = passwordTextField.text, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        
        // Requst Sign In
        self.dismissKeyboard()
        self.showIndicator()
        let input = SignInRequest(id: id, password: password)
        dataManager.postSignIn(input, delegate: self)
    }
}

extension SignInViewController {
    func didSuccessSignIn(_ result: SignInResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: result.token)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

// MARK: Apple Login
extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @objc func appleLogin(_ sender: ASAuthorizationAppleIDButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let email = credential.email
            let familyName = credential.fullName?.familyName ?? ""
            let givenName = credential.fullName?.givenName ?? ""
            let fullName = familyName + givenName
            
            self.presentAlert(
                title: "애플로그인 성공",
                message: """
                    userIdentifier : \(userIdentifier)
                    email : \(email ?? "불러오지 못함")
                    fullName : \((fullName.count > 0) ? fullName : "불러오지 못함")
                """
            )
            
            // 자동로그인을 위해 토근 저장
            UserDefaults.standard.set(userIdentifier, forKey: "AppleLoginUserIdentifier")
        } else {
            self.presentAlert(title: "애플로그인 실패")
        }
    }
}
