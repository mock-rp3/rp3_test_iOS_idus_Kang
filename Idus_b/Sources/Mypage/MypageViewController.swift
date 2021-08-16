//
//  MypageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit

class MypageViewController: BaseViewController {
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let spalshViewController = UIStoryboard(name: "SplashStoryboard", bundle: nil).instantiateViewController(identifier: "SplashStoryboard")
        changeRootViewController(spalshViewController)
    }
}
