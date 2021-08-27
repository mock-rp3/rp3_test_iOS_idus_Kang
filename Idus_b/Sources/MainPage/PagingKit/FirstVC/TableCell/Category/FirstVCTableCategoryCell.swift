//
//  FirstVCTableCategoryCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/20.
//

import UIKit
import SnapKit

protocol CategoryDelegate: AnyObject {
    func didSelectedCategory(_ index: Int)
}

class FirstVCTableCategoryCell: UITableViewCell {
    
    var delegate: CategoryDelegate?
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableCategoryCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableCategoryCell", bundle: nil)
    }
    
    // MARK: - 컬렉션뷰
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var models = [btnImgModel]()

    func configure2(with models: [btnImgModel]) {
        self.models = models
        categoryCollectionView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryCollectionView.register(CategoryCell.nib(), forCellWithReuseIdentifier: CategoryCell.identifier)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    // MARK: - 스크롤뷰
    /*
    let view = HorizontalScrollView()
    lazy var horizontalScrollView: HorizontalScrollView = {
        let view = HorizontalScrollView()

        return view
    }()

    
    @IBOutlet weak var categoryScrollView: UIScrollView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()

        insertDataSource()
        
    }
    
    private func configure() {
        view.addSubview(horizontalScrollView)

        horizontalScrollView.snp.makeConstraints { make in
            make.center.width.equalToSuperview()
            make.height.equalTo(56)
        }

    }

    private func insertDataSource() {
        horizontalScrollView.dataSource = Mocks.getDataSource()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
}

// MARK: - CollectionView Delegate
extension FirstVCTableCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.configureCategoryCell(with: models[indexPath.row])
        cell.click = { [unowned self] in
            if let delegate = delegate {
                delegate.didSelectedCategory(indexPath.item)
            }
        }
        return cell
    }
    
    // height값을 collectionView의 height만큼 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: categoryCollectionView.frame.height)
    }

}
