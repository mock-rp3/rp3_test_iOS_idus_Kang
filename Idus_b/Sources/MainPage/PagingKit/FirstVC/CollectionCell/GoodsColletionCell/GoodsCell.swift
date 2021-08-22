//
//  GoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class GoodsCell: UICollectionViewCell {
    
    static let identifier = "GoodsCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GoodsCell", bundle: nil)
    }

    @IBOutlet weak var GoodsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func configure3(with model: btnImgModel) {
        self.GoodsBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }
}
