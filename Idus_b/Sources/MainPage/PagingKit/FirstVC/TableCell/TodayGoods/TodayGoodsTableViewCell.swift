//
//  TodayGoodsTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit

protocol TodayGoodsViewDelegate: AnyObject { // class로 타입 제한
    func didSelectedGoods(_ index: Int)
}

class TodayGoodsTableViewCell: UITableViewCell {
    
    var delegate: TodayGoodsViewDelegate? // 의존성 주입할 프로퍼티 선언

    static let identifier = "TodayGoodsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TodayGoodsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var todayGoodsCollectionView: UICollectionView!
    var models = [imgModel]()
    
    func configure4(with models: [imgModel]) {
        self.models = models
        todayGoodsCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        todayGoodsCollectionView.register(TodayGoodsCell.nib(), forCellWithReuseIdentifier: TodayGoodsCell.identifier)
        
        todayGoodsCollectionView.dataSource = self
        todayGoodsCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - TodayGoodsCollectionView
extension TodayGoodsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = todayGoodsCollectionView.dequeueReusableCell(withReuseIdentifier: TodayGoodsCell.identifier, for: indexPath) as! TodayGoodsCell
        cell.configure4(with: models[indexPath.row])
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: todayGoodsCollectionView.frame.size.width, height:  todayGoodsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectedGoods(indexPath.item)
        }
    }
    
}
