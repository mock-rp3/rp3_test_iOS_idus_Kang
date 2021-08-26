//
//  GoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class GoodsCell: UICollectionViewCell {
    
    // MARK: - 프로퍼티
    @IBOutlet weak var goodsTitle: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var goodsBtn: UIButton!
    
    // 식별자
    static let identifier = "GoodsCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsCell", bundle: nil)
    }
    
    // 굿즈 이미지 클릭 이벤트 넘겨주기 위한 클로저 소스 코드
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
    public func configureRelatedGoodsResult(with model: RelatedGoodsResult) {
        
        // 작품 이미지
        let url = URL(string: model.image)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { self.goodsBtn.setImage(UIImage(data: data!), for: .normal)
            }
        }
        
        goodsTitle.text = model.title
        review.text = model.reviewContent
    }
}


