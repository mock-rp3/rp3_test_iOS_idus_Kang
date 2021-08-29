//
//  SearchVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit

class SearchVC: BaseViewController {
    
    var loadedJwt : String = UserDefaults.standard.value(forKey: "jwtKey") as? String ?? ""
    
    @IBOutlet weak var searchTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    @IBAction func bactToMain(_ sender: UIButton) {
        
        if loadedJwt != "" {
            let mainPage = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
            changeRootViewController(mainPage)
            
        } else {
            let mainPage = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
            changeRootViewController(mainPage)
        }
        
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        self.presentAlert(title: "검색에 성공하셨습니다!!")
    }
}

// 텍스트필드 키보드 관리
extension SearchVC: UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchTF.becomeFirstResponder()
    }

}
