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
    
    // 셀 버튼 클릭 이벤트 넘겨주기 위한 클로저 소스 코드
    var clickCancleBtn : (() -> ()) = {}
    var clickMinusBtn : (() -> ()) = {}
    var clickPlusBtn : (() -> ()) = {}
    
    static let identifier = "PurchaseVCTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PurchaseVCTableViewCell", bundle: nil)
    }

    // MARK: - Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Actions
    
//    func cancleBtn2() {
//        cancleBtn.addTarget(self,
//                         action: #selector(buttonDidTap(_:)),
//                         for: .touchUpInside)
//    }
//
//    @objc func buttonDidTap(_ sender: UIButton) {
//
//    }
    
    @IBAction func cancleBtn(_ sender: UIButton) {
        clickCancleBtn()
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        clickMinusBtn()
    }
    
    @IBAction func plusBtn(_ sender: UIButton) {
        clickPlusBtn()
    }
    
    // MARK: - Helpers



}
