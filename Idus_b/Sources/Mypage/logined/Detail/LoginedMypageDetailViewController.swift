//
//  LoginedMypageDetailViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit

class LoginedMypageDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var topEmail: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    @IBOutlet weak var emailL: UILabel!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
