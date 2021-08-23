//
//  TodayGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit

class TodayGoodsCell: UICollectionViewCell {

    
    @IBOutlet weak var todayGoodsBtn: UIButton!
    
    static let identifier = "TodayGoodsCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TodayGoodsCell", bundle: nil)
    }
    
    var click : (() -> ()) = {}
    
    @IBAction func clickGoodsBtn(_ sender: UIButton) {
       //Call your closure here
        click()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure4(with model: btnImgModel) {
        self.todayGoodsBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }

}
