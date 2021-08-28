//
//  EmailSignUpViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import UIKit
import SnapKit

class EmailSignUpViewController: BaseViewController {
  
    // MARK: - Property
    lazy var dataManager: EmailSignUpDataManager = EmailSignUpDataManager()

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var telTextField: UITextField!
    @IBOutlet var pushAgreementTextField: UITextField!
    
    @IBOutlet weak var AllCheckBtn: UIButton!
    @IBOutlet weak var agreeBtn2: UIButton!
    @IBOutlet weak var agreeBtn3: UIButton!
    @IBOutlet weak var agreeBtn4: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    var allChecked: Bool = false
    var mustChecked: Bool = false
    var agreeBtn2Checked:Bool = false
    var agreeBtn3Checked:Bool = false
    var agreeBtn4Checked:Bool = false
    
    let timeSelector: Selector = #selector(LoginViewController.updateTime)
    var index = 0
    var i = 0
    var images = [UIImage]()
    
    // status bar 숨겨 풀스크린 만들기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()

        tags()
        setBackImg()
    }
    
    // MARK: - 약관 태그
    func tags() {
        AllCheckBtn.tag = 1
        agreeBtn2.tag = 2
        agreeBtn3.tag = 3
        agreeBtn4.tag = 4
    }
    
    // MARK: - 배경 애니메이션 이미지 세팅
    func setBackImg(){
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

    // MARK: - modal 내리기
    @IBAction func dismissModalBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 약관 체크
    @IBAction func CheckBtn(_ sender: UIButton) {
        
        if sender.tag == 1 {
            if allChecked == false {
                AllCheckBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn4.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                allChecked = true
                mustChecked = true
                agreeBtn2Checked = true
                agreeBtn3Checked = true
                agreeBtn4Checked = true
            } else {
                AllCheckBtn.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn2.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn3.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn4.setImage(UIImage(systemName: "square"), for: .normal)
                allChecked = false
                mustChecked = false
                agreeBtn2Checked = false
                agreeBtn3Checked = false
                agreeBtn4Checked = false
            }
        }
        
        if sender.tag == 2 {
            if agreeBtn2Checked == false {
                agreeBtn2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn2Checked = true
            } else {
                agreeBtn2.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn2Checked = false
            }
        }
        
        if sender.tag == 3 {
            if agreeBtn3Checked == false {
                agreeBtn3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn3Checked = true
            } else {
                agreeBtn3.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn3Checked = false
            }
        }
        
        if sender.tag == 2 || sender.tag == 3  {
            if agreeBtn2Checked == true && agreeBtn3Checked == true {
                mustChecked = true
            } else {
                mustChecked = false
            }
        }
        
        if sender.tag == 4 {
            if agreeBtn4Checked == false {
                agreeBtn4.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                agreeBtn4Checked = true
            } else {
                agreeBtn4.setImage(UIImage(systemName: "square"), for: .normal)
                agreeBtn4Checked = false
            }
        }
         
        if sender.tag == 2 || sender.tag == 3 || sender.tag == 4 {
            if agreeBtn2Checked == true && agreeBtn3Checked == true && agreeBtn4Checked == true {
                AllCheckBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                allChecked = true
            } else {
                AllCheckBtn.setImage(UIImage(systemName: "square"), for: .normal)
                allChecked = false
            }
        }
    }
    
    // MARK: - 회원가입 버튼
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
        
        if mustChecked == false {
            // 회원가입 버튼 비활성화
            self.presentAlert(title: "필수 약관에 동의해주세요")
            return
        }
    }
    
}

// MARK: - 이메일 회원가입 델리게이트
extension EmailSignUpViewController {
    func didSuccessSignUp() {
        self.presentAlert(title: "회원가입에 성공하였습니다") { action in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

// MARK: - 텍스트필드 키보드 관리
extension EmailSignUpViewController: UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        self.emailTextField.becomeFirstResponder()
    }

}
