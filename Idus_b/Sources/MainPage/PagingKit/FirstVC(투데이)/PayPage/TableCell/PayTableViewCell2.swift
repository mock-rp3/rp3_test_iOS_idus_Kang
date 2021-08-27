//
//  PayTableViewCell2.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import UIKit

class PayTableViewCell2: UITableViewCell {
    
    static let identifier = "PayTableViewCell2"
    static func nib() -> UINib {
        return UINib(nibName: "PayTableViewCell2", bundle: nil)
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
