//
//  EmailSignUpViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import UIKit
import SnapKit

class EmailSignUpViewController: BaseViewController {
  
    lazy var dataManager: EmailSignUpDataManager = EmailSignUpDataManager()

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var telTextField: UITextField!
    @IBOutlet var pushAgreementTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()
        
    }
    
    @IBAction func signUpButtonTaapped(_ sender: UIButton) {
        // Email validation
        guard let email = emailTextField.text?.trim, email.isExists else {
            self.presentAlert(title: "이메일을 입력해주세요")
            return
        }
        
        // name validation
        guard let name = nameTextField.text?.trim, name.isExists else {
            self.presentAlert(title: "이름을 입력해주세요")
            return
        }
        
        // Password validation
        guard let password = passwordTextField.text, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        
        // Tel validation
        guard let tel = telTextField.text, tel.isExists else {
            self.presentAlert(title: "전화번호를 입력해주세요")
            return
        }
        
        // pushAgreement validation
        guard let pushAgreement = pushAgreementTextField.text, pushAgreement.isExists else {
            self.presentAlert(title: "쿠폰/이벤트알림받기(선택사항값)을 입력해주세요")
            return
        }
        
        // Requst SignUp
        self.dismissKeyboard()
        self.showIndicator()
        let input = EmailSignUpRequest(email: email, name: name, password: password, tel: tel, pushAgreement: pushAgreement)
        dataManager.postSignUp(input, delegate: self)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: modal 내리기
    @IBAction func dismissModalBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension EmailSignUpViewController {
    func didSuccessSignUp(_ result: String) {
        self.presentAlert(title: "회원가입에 성공하였습니다", message: result)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
