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

class GoodsPageImgTableViewCell: UITableViewCell {

    // MARK: - 프로퍼티
    
    static let identifier = "GoodsPageImgTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GoodsPageImgTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var goodsImgCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIView!
    
    var smallGoodsImgs = [String]()
    var bigGoodsImgs : [String] = UserDefaults.standard.value(forKey: "bigGoodsImgs") as! [String]
    
    // CollectionViewCell에 사용될 dataSource 정의
    var dataSource: [MyCollectionViewModel] = []
    
    // PageViewController에 사용되는 dataSourceVC 정의
    var dataSourceVC: [UIViewController] = []
    
    // pageViewController 초기화
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    // currentPage 정의: 현재 페이지가 collectionView나 pageViewController 둘 중 하나로 바뀌면 싱크를 맞추는 옵저버 프로퍼티
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupDataSource()
        configurePageVCImg()
        addSubviews()
        configure()
        setupDelegate()
        registerCell()
        setViewControllersInPageVC()
        pageViewController.reloadInputViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // viewDidAppear 시 0번 페이지가 선택되도록 설정
        currentPage = 0
    }
    
    // MARK: - Helper
    
    func configureGoodsImg(with models: [String]) {
        for index in 0...8 {
            self.smallGoodsImgs.append(models[index])
        }
        goodsImgCollectionView.reloadData()
    }
    
    // MARK: - CollectionViewCell에 사용될 dataSource 정의
    
    private func setupDataSource() {
        for k in 0...8 {
            let model = MyCollectionViewModel(title: k)
            dataSource += [model]
        }
    }
    
    // MARK: - PageViewController 및 데이터 정의
    func configurePageVCImg() {

        var index = 0
        dataSource.forEach { _ in
            let vc = UIViewController()
//            let imgBtn = UIButton()
            let imgView = UIImageView()
            let url = URL(string: bigGoodsImgs[index])
                UserDefaults.standard.set(bigGoodsImgs[0], forKey: "itemImageUrl")
            DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    imgView.image = UIImage(data: data!)!
                }
            }
            
            imgView.contentMode = .scaleAspectFit
            imgView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            
            index += 1
            
            vc.view.addSubview(imgView)

            imgView.snp.makeConstraints { make in
//                make.top.equalToSuperview()
                make.center.equalToSuperview()
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
            make.top.equalToSuperview()
            make.bottom.equalTo(goodsImgCollectionView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        // collectionView 레이아웃
        goodsImgCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
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
        goodsImgCollectionView.register(GoodsPageCollectionViewCell.self, forCellWithReuseIdentifier: GoodsPageCollectionViewCell.identifier)
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

// MARK: - GoodsPageCollectionView delegate 구현
extension GoodsPageImgTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = goodsImgCollectionView.dequeueReusableCell(withReuseIdentifier: GoodsPageCollectionViewCell.identifier, for: indexPath)
        if let cell = cell as? GoodsPageCollectionViewCell {
            
            cell.configuresmallGoodsImg(with: smallGoodsImgs[indexPath.row])
            
            cell.contentsView.rx.tapGesture(configuration: .none)
                .when(.recognized)
                .asDriver { _ in .never() }
                .drive(onNext: { [weak self] _ in
                    self?.didTapCell(at: indexPath)
                }).disposed(by: cell.bag)
        }
        return cell
    }
    
    // 높이 설정: 수평 스크롤이 되도록 height를 collectionView의 height와 동일하도록 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.frame.height)
    }
}
