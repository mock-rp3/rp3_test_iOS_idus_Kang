//
//  FirstVCTableGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class FirstVCTableGoodsCell: UITableViewCell {
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableGoodsCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableGoodsCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
