//
//  NowGoodsCollectionViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit

class NowGoodsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var goodsName: UILabel!
    
    static let identifier = "NowGoodsCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
}
