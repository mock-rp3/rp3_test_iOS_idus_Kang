//
//  GoodsPageTextTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class GoodsPageTextTableViewCell: UITableViewCell {
    
    static let identifier = "GoodsPageTextTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageTextTableViewCell", bundle: nil)
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
