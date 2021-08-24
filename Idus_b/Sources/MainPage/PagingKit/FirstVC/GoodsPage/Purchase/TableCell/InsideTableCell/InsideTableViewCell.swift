//
//  InsideTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/25.
//

import UIKit

class InsideTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "InsideTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "InsideTableViewCell", bundle: nil)
    }
    
    // MARK: - Lifecylce
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.text = "  - InsideTableViewCell 입니다."
    }
    
}
