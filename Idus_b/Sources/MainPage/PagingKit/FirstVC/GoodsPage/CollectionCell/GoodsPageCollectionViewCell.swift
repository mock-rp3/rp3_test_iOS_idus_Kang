//
//  GoodsPageCollectionViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit
import SnapKit
import RxSwift

class GoodsPageCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "GoodsPageCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageCollectionViewCell", bundle: nil)
    }
    
    var click : (() -> ()) = {}

    @IBOutlet weak var smallImgBtn: UIButton!

    @IBAction func clickGoodsImgBtn(_ sender: UIButton) {
        click()
    }

    override var isSelected: Bool {
        didSet {
            smallImgBtn.alpha = isSelected ? 1.0 : 0.5
        }
    }    
    
    public func configureGoodsPageImg(with model: btnImgModel) {
        self.smallImgBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }
}
