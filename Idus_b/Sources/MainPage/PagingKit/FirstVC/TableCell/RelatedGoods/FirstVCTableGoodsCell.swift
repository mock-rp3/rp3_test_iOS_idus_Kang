//
//  FirstVCTableGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

protocol GoodsViewDelegate: AnyObject { // class로 타입 제한
    func didSelectedGoodsBtn(_ index: Int)
}

class FirstVCTableGoodsCell: UITableViewCell {
    
    // MARK: - 프로퍼티
    var delegate: GoodsViewDelegate? // 의존성 주입할 프로퍼티 선언
    
    @IBOutlet weak var goodsCollectionView: UICollectionView!
    
    var relatedGoodsResult = [RelatedGoodsResult]()
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableGoodsCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableGoodsCell", bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
 
        goodsCollectionView.register(GoodsCell.nib(), forCellWithReuseIdentifier: GoodsCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helper
    func configure3(with models: [RelatedGoodsResult]) {
        self.relatedGoodsResult = models
        goodsCollectionView.reloadData()
    }
    
}

// MARK: - CollectionView Delegate
extension FirstVCTableGoodsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedGoodsResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: GoodsCell.identifier, for: indexPath) as! GoodsCell
        cell.configureRelatedGoodsResult(with: relatedGoodsResult[indexPath.row])
        cell.click = { [unowned self] in
            if let delegate = delegate {
                delegate.didSelectedGoodsBtn(indexPath.item)
            }
        }
        return cell
    }
    
    // height값을 collectionView의 height만큼 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: goodsCollectionView.frame.height)
    }    

}
