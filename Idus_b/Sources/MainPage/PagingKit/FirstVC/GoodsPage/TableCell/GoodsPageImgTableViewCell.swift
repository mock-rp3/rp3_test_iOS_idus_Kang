//
//  GoodsPageImgTableViewCell.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/23.
//

import UIKit
import RxGesture // collectionView의 cell내부 contentsView tapGesture() rx 사용위해 import
import RxSwift
import RxCocoa

protocol GoodsImgDelegate: AnyObject { // class로 타입 제한
    func didSelectedGoodsBtn(_ index: Int)
}

class GoodsPageImgTableViewCell: UITableViewCell {

    var delegate: GoodsImgDelegate?
    
    static let identifier = "GoodsPageImgTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageImgTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var goodsImgCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIView!
    
    // currentPage 정의: 현재 페이지가 collectionView나 pageViewController 둘 중 하나로 바뀌면 싱크를 맞추는 옵저버 프로퍼티
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    var smallGoodsImgs = [btnImgModel]()
    
    // CollectionViewCell에 사용될 dataSource 정의
    var dataSource: [MyCollectionViewModel] = []
    // PageViewController에 사용되는 dataSourceVC 정의
    var dataSourceVC: [UIViewController] = []
    
    // pageViewController 초기화
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    func configureGoodsPageImg(with models: [btnImgModel]) {
        self.smallGoodsImgs = models
        goodsImgCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goodsImgCollectionView.delegate = self
        goodsImgCollectionView.dataSource = self
        
        setupDataSource()
        setupDelegate()
        registerCell()
        setupViewControllers()
        addSubviews()
//        configure()
        setViewControllersInPageVC()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // viewDidAppear 시 0번 페이지가 선택되도록 설정
        currentPage = 0
    }
    
    // MARK: - CollectionViewCell에 사용될 dataSource 정의
    private func setupDataSource() {
        var k = 0
        while let _ = UIImage(named: "goodsDummy\(k)") {
            let model = MyCollectionViewModel(title: k)
            dataSource += [model]
            k += 1
        }
    }
    
    // MARK: - PageViewController 추가
    private func setupViewControllers() {

        var i = 0
        dataSource.forEach { _ in
            let vc = UIViewController()
            let imgBtn = UIButton()
            
            imgBtn.setImage(UIImage(named: "goodsDummy\(i)"), for: .normal)
            imgBtn.contentMode = .scaleAspectFill
            imgBtn.contentHorizontalAlignment = .fill
            imgBtn.contentVerticalAlignment = .fill
            imgBtn.heightAnchor.constraint(equalToConstant: 400).isActive = true
            vc.view.addSubview(imgBtn)
            i += 1
            
            imgBtn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                
                
            }
            dataSourceVC += [vc]
        }
    }
    
    // MARK: - addSubviews()
    private func addSubviews() {
//        pageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        pageView.addSubview(pageViewController.view)
    }
    
    // MARK: - 레이아웃 설정
    private func configure() {
        // pageView 레이아웃
        pageViewController.view.snp.makeConstraints { make in
            make.bottom.equalTo(pageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        goodsImgCollectionView.delegate = self
        goodsImgCollectionView.dataSource = self
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    private func registerCell() {
        goodsImgCollectionView.register(GoodsPageCollectionViewCell.nib(), forCellWithReuseIdentifier: GoodsPageCollectionViewCell.identifier)
    }
    
    // MARK: - firstViewController 설정
    private func setViewControllersInPageVC() {
        if let firstVC = dataSourceVC.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - CollectionView와 PageViewController 연동
    private func bind(oldValue: Int, newValue: Int) {

        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([dataSourceVC[currentPage]], direction: direction, animated: true, completion: nil)

        // pageViewController에서 paging한 경우
        goodsImgCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    // MARK: - ColelctionViewCell안에 contentsView가 tap될때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
    
}

// MARK: - GoodsPageCollectionView delegate 구현
extension GoodsPageImgTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = goodsImgCollectionView.dequeueReusableCell(withReuseIdentifier: GoodsPageCollectionViewCell.identifier, for: indexPath) as! GoodsPageCollectionViewCell
        cell.configureGoodsPageImg(with: smallGoodsImgs[indexPath.row])
        cell.click = { [unowned self] in
            delegate?.didSelectedGoodsBtn(indexPath.item)
        }
        return cell
    }
    
    // 높이 설정: 수평 스크롤이 되도록 height를 collectionView의 height와 동일하도록 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.frame.height)
    }
}

// MARK: - 페이지뷰 delegate 구현
extension GoodsPageImgTableViewCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataSourceVC[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataSourceVC.count {
            return nil
        }
        return dataSourceVC[nextIndex]
    }
        
    // pageViewController 애니메이션이 끝난 경우 호출되는 UICollectionViewDeleagteFlowLayout 델리게이트
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceVC.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}
