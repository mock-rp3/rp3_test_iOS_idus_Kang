//
//  CollectionViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak var rectangle2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 원래 여기다 안쓰고 따로 func 두는데 그냥 이렇게 하겠음
        rectangle2.layer.cornerRadius = 10
    }
}
