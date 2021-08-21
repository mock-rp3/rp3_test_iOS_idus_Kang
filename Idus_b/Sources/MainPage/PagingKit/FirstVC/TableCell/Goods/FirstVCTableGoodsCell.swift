//
//  FirstVCTableGoodsCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class FirstVCTableGoodsCell: UITableViewCell {
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableGoodsCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableGoodsCell", bundle: nil)
    }

    @IBOutlet weak var goodsCollectionView: UICollectionView!
    
    var models = [btnImgModel]()

    func configure3(with models: [btnImgModel]) {
        self.models = models
        goodsCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goodsCollectionView.register(GoodsCell.nib(), forCellWithReuseIdentifier: GoodsCell.identifier)
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - CollectionView Delegate
extension FirstVCTableGoodsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: GoodsCell.identifier, for: indexPath) as! GoodsCell
        cell.configure3(with: models[indexPath.row])
        return cell
    }
    
    // height값을 collectionView의 height만큼 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: goodsCollectionView.frame.height)
    }
}
