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
    @IBOutlet weak var reviewNum: UIButton!
    @IBOutlet weak var likeBtnNum: UIButton!
    @IBOutlet weak var orderUserNum: UILabel!
    var heartChecked: Bool = false
    
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
    
    // MARK: - Helper
    
    func configureAuthor(with models: [GoodsPageResponseResult]) {
        let url = URL(string: models[0].author.authorImage)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.sellerImg.setImage(UIImage(data: data!), for: .normal)
            }
        }
        sellerName.setTitle(models[0].author.authorName, for: .normal)
        goodsTitle.text = models[0].workInfo.title
        saleNum.text = "\(models[0].workDiscount)%"
        firstSellNum.text = "\(models[0].workInfo.price)원"
        
        let sellNum0 = models[0].workInfo.price - models[0].workInfo.price * models[0].workDiscount
        UserDefaults.standard.set(sellNum0, forKey: "sellNum")
        sellNum.text = "\(sellNum0)원"
        reviewNum.setTitle("(\(models[0].review.reviewCount))", for: .normal)
        orderUserNum.text = "\(models[0].orderUserCount)명의 고객들이 구매했어요."
        
    }
    
    @IBAction func likeBtn(_ sender: UIButton) {
        if heartChecked == false {
            likeBtnNum.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeBtnNum.setTitle("찜하기 545", for: .normal)
            
            heartChecked = true
        } else {
            likeBtnNum.setImage(UIImage(systemName: "heart"), for: .normal)
            likeBtnNum.setTitle("찜하기 544", for: .normal)
            heartChecked = false
        }
    }
}
