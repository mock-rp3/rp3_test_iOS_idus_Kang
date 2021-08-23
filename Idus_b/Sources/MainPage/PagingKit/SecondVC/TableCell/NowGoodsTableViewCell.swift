//
//  NowGoodsTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit

protocol CVCellDelegate {
    func selectedCVCell(_ index: Int)
}

class NowGoodsTableViewCell: UITableViewCell {
    
    static let identifier = "NowGoodsTableViewCell"
    
    var delegate: CVCellDelegate?
    
    let horizonInset: CGFloat = 20
    let lineSpacing: CGFloat = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        let collectionViewNib = UINib(nibName: "NowGoodsCollectionViewCell", bundle: nil)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "NowGoodsCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension NowGoodsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowGoodsCollectionViewCell.identifier, for: indexPath) as? NowGoodsCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
extension NowGoodsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        let cellWidth = collectionView.frame.width / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: horizonInset, bottom: 0, right: horizonInset)
    }
}
extension NowGoodsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectedCVCell(indexPath.item)
        }
    }
}
