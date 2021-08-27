//
//  PayTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import UIKit

class PayTableViewCell: UITableViewCell {
    
    static let identifier = "PayTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PayTableViewCell", bundle: nil)
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
