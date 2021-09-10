//
//  NowGoodsTopTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/09/09.
//

import UIKit

class NowGoodsTopTableViewCell: UITableViewCell {

    @IBOutlet weak var atDayTime: UILabel!
    
    static let identifier = "NowGoodsTopTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Action
    
    
    @IBAction func onlyImageBtn(_ sender: Any) {
    }
    
    
    @IBAction func nowBtn(_ sender: Any) {
    }
    
    
    @IBAction func commentBtn(_ sender: Any) {
    }
}
