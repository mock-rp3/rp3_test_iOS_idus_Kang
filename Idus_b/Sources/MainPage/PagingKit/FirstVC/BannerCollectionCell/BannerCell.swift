//
//  BannerCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    static let identifier = "BannerCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BannerCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: Model) {
        self.imgView.image = UIImage(named: model.imageName)
        self.imgView.contentMode = .scaleToFill
    }
}
