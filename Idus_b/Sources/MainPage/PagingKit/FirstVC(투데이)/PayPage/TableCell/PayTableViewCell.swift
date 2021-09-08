//
//  PayTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import UIKit

class PayTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    lazy var dataManager: GetPayUserInfoDataManager = GetPayUserInfoDataManager()
    
    var loadedUserIdx = UserDefaults.standard.value(forKey: "userIdxKey") as? Int ?? nil
    var loadedJwt : String = UserDefaults.standard.value(forKey: "jwtKey") as? String ?? ""
    
    @IBOutlet weak var userNameNum: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    @IBOutlet weak var userAdress: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    static let identifier = "PayTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PayTableViewCell", bundle: nil)
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Request UserLoginInfo
        if loadedUserIdx != nil {
            dataManager.getPayUserInfo(userIdx: loadedUserIdx!, jwt: loadedJwt, delegate: self)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - payUserIfo
extension PayTableViewCell {
    
    func successGetPayUserInfo(result: GetUserInfoResult) {
        
        userName.text = result.name
        userNum.text = result.tel
        userNameNum.text = userName.text! + "(\(userNum.text!)"
        itemName.text = ""
        
    }
}
