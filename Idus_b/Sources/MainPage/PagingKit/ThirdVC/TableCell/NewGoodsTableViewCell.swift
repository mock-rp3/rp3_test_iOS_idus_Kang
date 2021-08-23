//
//  ThirdVCTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit

protocol NewGoodsViewDelegate: AnyObject { // class로 타입 제한
    func didSelectedGoods(_ index: Int)
}

class NewGoodsTableViewCell: UITableViewCell {
    
    var delegate: NewGoodsViewDelegate?
    
    static let identifier = "NewGoodsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewGoodsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var newGoodsCollectionView: UICollectionView!
    var models = [imgModel]()
    
    func configure30(with models: [imgModel]) {
        self.models = models
        newGoodsCollectionView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        newGoodsCollectionView.register(NewGoodsCollectionViewCell.nib(), forCellWithReuseIdentifier: NewGoodsCollectionViewCell.identifier)
        
        newGoodsCollectionView.dataSource = self
        newGoodsCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - NewGoodsCollectionView
extension NewGoodsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newGoodsCollectionView.dequeueReusableCell(withReuseIdentifier: NewGoodsCollectionViewCell.identifier, for: indexPath) as? NewGoodsCollectionViewCell else { return UICollectionViewCell()}
        cell.configure30(with: models[indexPath.row])
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newGoodsCollectionView.frame.size.width, height:  newGoodsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectedGoods(indexPath.item)
        }
    }
    
}
