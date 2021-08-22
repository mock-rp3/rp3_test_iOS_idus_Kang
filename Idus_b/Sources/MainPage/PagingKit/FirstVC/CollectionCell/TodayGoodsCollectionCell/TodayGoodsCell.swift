//
//  TodayGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit

class TodayGoodsCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    static let identifier = "TodayGoodsCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TodayGoodsCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure4(with model: imgModel) {
        self.imgView.image = UIImage(named: model.imageName)
        self.imgView.contentMode = .scaleToFill
    }

}
