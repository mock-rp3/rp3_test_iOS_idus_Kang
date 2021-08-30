//
//  GoodsPageCollectionViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit
import SnapKit
import RxSwift

class GoodsPageCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "GoodsPageCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageCollectionViewCell", bundle: nil)
    }
    
    var click : (() -> ()) = {}
    @IBOutlet weak var smallImgBtn: UIButton!
    @IBAction func clickGoodsImgBtn(_ sender: UIButton) {
        click()
    }
    
    @IBOutlet weak var smallImage: UIImageView!
    
    var bag = DisposeBag()
    
    lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange.withAlphaComponent(0.5)

        return view
    }()
    
    lazy var smallImg: UIImageView = {
        let img = UIImageView()

        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            contentsView.alpha = isSelected ? 1.0 : 0.5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        bag = DisposeBag()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubviews() {
        addSubview(contentsView)
        contentsView.addSubview(smallImg)
    }
    
    private func configure() {
        contentsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        smallImg.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        contentsView.alpha = 0.5
    }
    
//    public func configuresmallGoodsPageImg(with model: btnImgModel) {
//        self.smallImgBtn.setImage(UIImage(named: model.btnImageName), for: .normal)
//    }
    
    
    public func configuresmallGoodsImg(with model: String) {

        let url = URL(string: model)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
//                self.smallImgBtn.setImage(UIImage(data: data!), for: .normal)
//                self.smallImage?.image = UIImage(data: data!)
                self.smallImg.image = UIImage(data: data!)
            }
            
        }
    }
    
    public func goodsPageResponseResult(with model: [GoodsPageResponseResult], idx: Int, index: Int) {
    
        let url = URL(string: model[index].workImage[idx])
//        let data = try? Data(contentsOf: url!)
//        self.smallImgBtn.setImage(UIImage(data: data!), for: .normal)
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.smallImgBtn.setImage(UIImage(data: data!), for: .normal)
            }
        }
        
    }
    
}
