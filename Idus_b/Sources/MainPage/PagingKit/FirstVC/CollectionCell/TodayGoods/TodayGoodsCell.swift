//
//  TodayGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit

class TodayGoodsCell: UICollectionViewCell {

    // MARK: - 프로퍼티
    @IBOutlet weak var todayGoodsBtn: UIButton!
    @IBOutlet weak var goodsTitle: UILabel!
    @IBOutlet weak var review: UILabel!
    
    
    static let identifier = "TodayGoodsCell"
    static func nib() -> UINib {
        return UINib(nibName: "TodayGoodsCell", bundle: nil)
    }
    
    var click : (() -> ()) = {}
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Action
    @IBAction func clickGoodsBtn(_ sender: UIButton) {
       //Call your closure here
        click()
    }
    
    // MARK: - Helper
    public func configure4(with model: TodayGoodsResult) {
//        self.todayGoodsBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
        // 작품 이미지
        let url = URL(string: model.image)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { self.todayGoodsBtn.setImage(UIImage(data: data!), for: .normal)
            }
        }
        
        goodsTitle.text = model.title
        review.text = model.reviewContent
    }

}
