//
//  EmailLoginViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import UIKit
import SnapKit

class EmailLoginViewController: BaseViewController {
      
    lazy var dataManager: EmailLoginDataManager = EmailLoginDataManager()

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
        
        // 배경 애니메이션
        backgroundImageView.animationImages = animatedImages(for: "login&SIgnupPage_background_gif")
        backgroundImageView.animationDuration = 10
        backgroundImageView.image = backgroundImageView.animationImages?.first
        backgroundImageView.startAnimating()
    }

    // MARK: - 배경 애니메이션
    func animatedImages(for name: String) -> [UIImage] {
        
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)/login&SIgnupPage_background\(i)") {
            images.append(image)
            i += 1
        }
        return images
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
        self.showIndicator()
        let input = EmailLoginRequest(email: email, password: password)
        dataManager.postLogin(input, delegate: self)
        
        // 로그인 메인화면으로 이동
        let loginedMainTabBarController = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
            self.changeRootViewController(loginedMainTabBarController)
    }
    
    // MARK: modal 내리기
    @IBAction func dismissModalButtonTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
}

extension EmailLoginViewController {
    func didSuccessLogin(_ result: LoginResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: result.jwt)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
