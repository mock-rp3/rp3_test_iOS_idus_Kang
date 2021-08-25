//
//  EmailLoginViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import UIKit
import SnapKit

class EmailLoginViewController: BaseViewController, UITextFieldDelegate {
      
    lazy var dataManager: EmailLoginDataManager = EmailLoginDataManager()
    
    let timeSelector: Selector = #selector(LoginViewController.updateTime)
    var index = 0
    var i = 0
    var images = [UIImage]()

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!


    // status bar 숨겨 풀스크린 만들기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()
        setKeyboardEvent()
        
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

    // MARK: - 텍스트 필드
    @IBAction func loginButtonTaapped(_ sender: UIButton) {
        // Email validation
        guard let email = emailTextField.text?.trim, email.isExists else {
            self.presentAlert(title: "이메일을 입력해주세요")
            return
        }
        
        // Password validation
        guard let password = passwordTextField.text, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        
        // Requst Login
        self.dismissKeyboard()
        let input = EmailLoginRequest(email: email, password: password)
        dataManager.postLogin(input, delegate: self)
    }
    
    // MARK: modal 내리기
    @IBAction func dismissModalButtonTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
}

extension EmailLoginViewController {
    func didSuccessLogin(_ result: LoginResult) {
        // 유저 디폴트로 userIdx와 jwt 저장
        UserDefaults.standard.set(result.userIdx, forKey: "userIdxKey")
        UserDefaults.standard.set(result.jwt, forKey: "jwtKey")
        
//         로그인 메인화면으로 이동
        let loginedMainTabBarController = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
        self.changeRootViewController(loginedMainTabBarController)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

// 텍스트필드 키보드 관리
extension EmailLoginViewController {
    
    func setKeyboardEvent() {
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisAppear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(_ senderr: NotificationCenter) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y = -150
        }
    }
    @objc func keyboardWillDisAppear(_ senderr: NotificationCenter) {
        if self.view.frame.origin.y == -150 {
            self.view.frame.origin.y = 0
        }
    }
    
}
