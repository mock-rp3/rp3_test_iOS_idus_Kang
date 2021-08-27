//
//  CategoryCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCell", bundle: nil)
    }
    
    @IBOutlet weak var CategoryBtn: UIButton!
    
//    internal var aspectConstraint: NSLayoutConstraint? {
//        didSet{
//            if oldValue != nil{
//                CategoryBtn.removeConstraint(oldValue!)
//            }
//            if aspectConstraint != nil{
//                CategoryBtn.addConstraint(aspectConstraint!)
//            }
//        }
//    }
//    override func prepareForReuse() {
//        aspectConstraint = nil
//    }
//    func setIvMedia(image: UIImage){
//        let aspect = image.size.width / image.size.height
//        aspectConstraint = NSLayoutConstraint(item: CategoryBtn!, attribute: .width, relatedBy: .equal, toItem: CategoryBtn, attribute: .height, multiplier: aspect, constant: 0)
//        CategoryBtn.setImage(image, for: .normal)
//    }
    
    var click : (() -> ()) = {}
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Action
    @IBAction func clickGoodsBtn(_ sender: UIButton) {
       //Call your closure here
        click()
    }
    
    public func configureCategoryCell(with model: btnImgModel) {
        self.CategoryBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
    }
    
    

}
