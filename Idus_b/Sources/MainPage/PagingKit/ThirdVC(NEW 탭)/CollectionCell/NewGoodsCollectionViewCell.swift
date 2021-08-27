////
////  ThirdVCCollectionViewCell.swift
////  Idus_b
////
////  Created by 강성수 on 2021/08/22.
////
//
//import UIKit
//
//class NewGoodsCollectionViewCell: UICollectionViewCell {
//
//    static let identifier = "NewGoodsCollectionViewCell"
//
//    static func nib() -> UINib {
//        return UINib(nibName: "NewGoodsCollectionViewCell", bundle: nil)
//    }
//
//    @IBOutlet weak var imgView: UIImageView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    public func configure30(with model: imgModel) {
//        self.imgView.image = UIImage(named: model.imageName)
//        self.imgView.contentMode = .scaleToFill
//    }
//
//}
