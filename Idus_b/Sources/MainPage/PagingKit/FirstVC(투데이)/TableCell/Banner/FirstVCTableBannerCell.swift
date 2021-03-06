//
//  FirstVCTableBannerCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/20.
//

import UIKit

protocol BannerDelegate: AnyObject { // class로 타입 제한
    func didSelectedBanner(_ index: Int)
}

class FirstVCTableBannerCell: UITableViewCell {
    
    var delegate: BannerDelegate?
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableBannerCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableBannerCell", bundle: nil)
    }
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    var models = [imgModel]()
    
    var scrollTimer = Timer()
    var nowPage: Int = 0 // 현재페이지 체크 변수 (자동 스크롤할 때 필요)
    
    func configure(with models: [imgModel]) {
        self.models = models
        bannerCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bannerCollectionView.register(BannerCell.nib(), forCellWithReuseIdentifier: BannerCell.identifier)
        
        // 배너 관리
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerTimer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    // MARK: - 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
//        if nowPage == images.count-1 {
        if nowPage == models.count-1 {
        // 맨 처음 페이지로 돌아감
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
}

// MARK: - BannerCollectionView
extension FirstVCTableBannerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return models.count
    }
    
    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
//        cell.imgView.image = images[indexPath.row]
        cell.configureBannerCell(with: models[indexPath.row])
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCollectionView.frame.size.width, height:  bannerCollectionView.frame.height)
    }
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.didSelectedBanner(indexPath.item)
        if let delegate = delegate {
            delegate.didSelectedBanner(indexPath.item)
        }
    }
    
}
