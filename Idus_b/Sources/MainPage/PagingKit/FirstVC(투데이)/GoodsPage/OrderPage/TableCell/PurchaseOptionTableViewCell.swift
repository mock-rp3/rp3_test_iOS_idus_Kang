//
//  PurchaseOptionTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

/// "InsideTableView"를 클릭했을 때, 로직을 Controller에서 처리하도록 하는 프로토콜
protocol MainTableViewCellDidTapDelegate: AnyObject {
    func InsideCellDidTap(dateIndex: Int, itemIndex: Int)
}

class PurchaseOptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: MainTableViewCellDidTapDelegate?
    
    var currentDateIndex: Int = 0
    var dataArr: ShoppingList?
    
    @IBOutlet weak var optionNameView: UIView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var insideTableView: UITableView!
    @IBOutlet weak var selectImg: UIImageView!
    
    static let identifier = "PurchaseOptionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PurchaseOptionTableViewCell", bundle: nil)
    }

    // MARK: - Lifecylce
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helpers
    func configureUI() {                
//        insideTableView.register(InsideTableViewCell.self, forCellReuseIdentifier: "InsideTableViewCell")
        insideTableView.register(InsideTableViewCell.nib(), forCellReuseIdentifier: InsideTableViewCell.identifier)
        insideTableView.delegate = self
        insideTableView.dataSource = self
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension PurchaseOptionTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let dataArr = self.dataArr else { return 0 }
        print(dataArr.shoppingItem.count)
        return dataArr.shoppingItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InsideTableViewCell.identifier, for: indexPath) as? InsideTableViewCell else { return UITableViewCell()}

        cell.selectionStyle = .none
        
        guard let dataArr = self.dataArr else { return UITableViewCell() }
        
        // 데이터에서 특정 값을 Label에 할당한다.
        cell.titleLabel.text = dataArr.shoppingItem[indexPath.row]

        if dataArr.isSelected[indexPath.row] {
            // 셀 선택 이벤트
            
        }
        
        return cell
    }
    
    // 테이블(옵션명) 클릭했을 때 액션
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dataArr.setCompletionState(index: indexPath.row)
        
        delegate?.InsideCellDidTap(dateIndex: self.currentDateIndex, itemIndex: indexPath.row)
        insideTableView.reloadData()
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
