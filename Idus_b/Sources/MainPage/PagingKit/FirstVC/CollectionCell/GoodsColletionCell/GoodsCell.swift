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
    
    // input이 없고 void를 반환하는 클로저 타입 변수 선언
    var click : (() -> ()) = {}
    
    @IBAction func clickGoodsBtn(_ sender: UIButton) {
       //Call your closure here
        click()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure3(with model: btnImgModel) {
        self.GoodsBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }
}
