//
//  GoodsPageDeliveryTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class GoodsPageDeliveryTableViewCell: UITableViewCell {
    
    static let identifier = "GoodsPageDeliveryTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageDeliveryTableViewCell", bundle: nil)
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
