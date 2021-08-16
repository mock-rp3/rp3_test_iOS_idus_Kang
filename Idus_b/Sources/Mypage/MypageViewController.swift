//
//  MypageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit

class MypageViewController: BaseViewController {
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
        changeRootViewController(loginViewController)
    }
}
