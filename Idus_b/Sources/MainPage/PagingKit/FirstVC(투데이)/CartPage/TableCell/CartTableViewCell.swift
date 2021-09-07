//
//  CartTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var goodsImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var optionName1: UILabel!
    @IBOutlet weak var costNum: UILabel!
    @IBOutlet weak var itemCountNum: UILabel!
    @IBOutlet weak var finalCostNum: UILabel!
    @IBOutlet weak var deliveryNum: UILabel!
    
    let numberFormatter = NumberFormatter()
    static let identifier = "CartTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberFormatter.numberStyle = .decimal
        setFinalItem()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFinalItem() {
        sellerName.text = UserDefaults.standard.value(forKey: "sellerName") as? String
        
        let url = URL(string: UserDefaults.standard.value(forKey: "itemImageUrl") as! String)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.goodsImg.image = UIImage(data: data!)!
            }
        }
        
        itemName.text = UserDefaults.standard.value(forKey: "goodsTitle") as? String
        
        optionName1.text = UserDefaults.standard.value(forKey: "plusSelectedItem") as? String
        
        let sellNum = UserDefaults.standard.value(forKey: "finalCostNum") as! Int
        let sumResult = numberFormatter.string(from: NSNumber(value: sellNum))! + "원"
        costNum.text = sumResult
        finalCostNum.text = sumResult
    }
    

    @IBAction func itemPlusBtn(_ sender: UIButton) {
    }
    
    @IBAction func itemOptionBtn(_ sender: UIButton) {
    }
    
    @IBAction func itemCancleBtn(_ sender: UIButton) {
    }
    
}
