//
//  GoodsPageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit
import RxGesture // collectionView의 cell내부 contentsView tapGesture() rx 사용위해 import
import RxSwift
import RxCocoa

class GoodsPageViewController: UIViewController {
    
    // MARK: - CollectionViewCell에 사용될 dataSource 정의
    var dataSource: [MyCollectionViewModel] = []

    // collectionView 초기화
    lazy var collectionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        flowLayout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .lightGray

        return view
    }()
    
    // MARK: - PageViewController에 사용되는 dataSourceVC 정의
    var dataSourceVC: [UIViewController] = []
    
    // pageViewController 초기화
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    // MARK: - CollectionView와 PageViewController 연동
    // currentPage 정의: 현재 페이지가 collectionView나 pageViewController 둘 중 하나로 바뀌면 싱크를 맞추는 옵저버 프로퍼티
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    private func bind(oldValue: Int, newValue: Int) {

        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([dataSourceVC[currentPage]], direction: direction, animated: true, completion: nil)

        // pageViewController에서 paging한 경우
        collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - 생명주기
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)

        // viewDidAppear 시 0번 페이지가 선택되도록 설정
       currentPage = 0
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ColelctionViewCell안에 contentsView가 tap될때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
    
    // MARK: - pageViewController 애니메이션이 끝난 경우 호출되는 UICollectionViewDeleagteFlowLayout 델리게이트
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceVC.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
    
    // MARK: - firstViewController 설정
    private func setViewControllersInPageVC() {
        if let firstVC = dataSourceVC.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - pageViewController에 사용되는 dataSourceVC 정의
    private func setupViewControllers() {

        var i = 0
        dataSource.forEach { _ in
            let vc = UIViewController()
            let red = CGFloat(arc4random_uniform(256)) / 255
            let green = CGFloat(arc4random_uniform(256)) / 255
            let blue = CGFloat(arc4random_uniform(256)) / 255

            vc.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)

            let label = UILabel()
            label.text = "\(i)"
            label.font = .systemFont(ofSize: 56, weight: .bold)
            i += 1

            vc.view.addSubview(label)
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            dataSourceVC += [vc]
        }
    }
    

    // MARK: -
    private func setupDataSource() {
        for i in 0...10 {
            let model = MyCollectionViewModel(title: i)
            dataSource += [model]
        }
    }
    
    // MARK: - 레이아웃 설정
    private func configure() {
        // collectionView 레이아웃 (기존에 있던 코드)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(96)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        pageViewController.didMove(toParent: self)
    }
    
    // MARK: - addSubviews()
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func registerCell() {
        collectionView.register(GoodsPageCollectionViewCell.self, forCellWithReuseIdentifier: GoodsPageCollectionViewCell.id)
    }

}

// MARK: - 콜렉션뷰 delegate 구현
extension GoodsPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsPageCollectionViewCell.id, for: indexPath)
        if let cell = cell as? GoodsPageCollectionViewCell {
            cell.model = dataSource[indexPath.item]

            cell.contentsView.rx.tapGesture(configuration: .none)
                .when(.recognized)
                .asDriver { _ in .never() }
                .drive(onNext: { [weak self] _ in
                    self?.didTapCell(at: indexPath)
                }).disposed(by: cell.bag)

        }
        return cell
    }
    
    // 높이 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.height)
    }
}

// MARK: - 페이지뷰 delegate 구현
extension GoodsPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

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
}
