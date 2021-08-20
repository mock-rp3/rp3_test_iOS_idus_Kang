//
//  CategoryCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCell", bundle: nil)
    }
    
    @IBOutlet weak var CategoryBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }    
    
    public func configure2(with model: btnImgModel) {
        self.CategoryBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }

}
