//
//  PurchaseVCTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/25.
//

import UIKit

class PurchaseVCTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemNum: UILabel!
    @IBOutlet weak var CountCost: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    
    let sellNum = UserDefaults.standard.value(forKey: "sellNum") as! Int
    let numberFormatter = NumberFormatter()
    
    static let identifier = "PurchaseVCTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PurchaseVCTableViewCell", bundle: nil)
    }

    // MARK: - Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberFormatter.numberStyle = .decimal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Actions
    
    func cancleBtn2() {
        cancleBtn.addTarget(self,
                         action: #selector(buttonDidTap(_:)),
                         for: .touchUpInside)
    }
    
    @objc func buttonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        itemNum.text = "\(Int(itemNum.text!)! - 1)"
        let result = numberFormatter.string(from: NSNumber(value: sellNum * Int(itemNum.text!)!))! + "원"
        CountCost.text = result
    }
    
    @IBAction func plusBtn(_ sender: UIButton) {
        itemNum.text = "\(Int(itemNum.text!)! + 1)"
        let result = numberFormatter.string(from: NSNumber(value: sellNum * Int(itemNum.text!)!))! + "원"
        CountCost.text = result
    }
    
    // MARK: - Helpers



}
