//
//  GoodsPageMainInfoTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class GoodsPageMainInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sellerImg: UIButton!
    @IBOutlet weak var sellerName: UIButton!
    @IBOutlet weak var goodsTitle: UILabel!
    @IBOutlet weak var saleNum: UILabel!
    @IBOutlet weak var sellNum: UILabel!
    @IBOutlet weak var firstSellNum: UILabel!
    
    static let identifier = "GoodsPageMainInfoTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageMainInfoTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setSellerImg()
        firstSellNum.attributedText = firstSellNum.text?.strikeThrough()
    }
    
    // 작가(셀러) 이미지
    func setSellerImg() {
        sellerImg.layer.cornerRadius = 0.5 * sellerImg.bounds.size.width
        sellerImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
