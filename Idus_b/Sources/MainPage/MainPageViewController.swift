//
//  MainPageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/16.
//

import UIKit
import PagingKit

class MainPageViewController: BaseViewController {

    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    // 데이터 소스 정의
    var dataSource = [(menuTitle: String, content: UIViewController)]() {
        didSet {
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    // 메뉴&컨텐츠 데이터 리로드
    lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }
    
    // MARK: -생명주기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메뉴 셀 & 포커스 셀 자체 등록
//        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        // 기존 메뉴 셀 & 포커스 셀 등록
        menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "TitleMenuCell")
//        menuViewController.registerFocusView(view: UnderlineFocusView())
        
        menuViewController.cellAlignment = .center
        
        dataSource = makeDataSource()
        
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()
        
    }
    
    // MARK: - Actions
    
    @IBAction func goToCart(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "CartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen

        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        self.presentAlert(title: "검색에 성공하셨습니다!!")
    }
    
    // MARK: - Paging Kit 세그웨이 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self // <- set menu data source
            menuViewController.delegate = self // <- set menu delegate
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self // <- set content data source
            contentViewController.delegate = self // <- set content delegate
        }
    }
    
    fileprivate func makeDataSource() -> [(menuTitle: String, content: UIViewController)] {
        let myMenuArray = ["투데이", "실시간", "NEW"]
        return myMenuArray.map {
            let title = $0
            
            switch title {
            case "투데이":
                let vc = UIStoryboard(name: "FirstVCStoryboard", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menuTitle: title, content: vc)
            case "실시간":
                let vc = UIStoryboard(name: "SecondVCStoryboard", bundle: nil).instantiateViewController(identifier: "SecondVC") as! SecondVC
                return (menuTitle: title, content: vc)
            case "NEW":
                let vc = UIStoryboard(name: "ThirdVCStoryboard", bundle: nil).instantiateViewController(identifier: "ThirdVC") as! ThirdVC
                return (menuTitle: title, content: vc)
                
            default:
                let vc = UIStoryboard(name: "FirstVCStoryboard", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menuTitle: title, content: vc)
            }
        }
        
    }
    
}

// MARK: - 메뉴 데이터 소스_Paging Kit
extension MainPageViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return viewController.view.frame.size.width / CGFloat(dataSource.count)
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        // 메뉴 셀 & 포커스 셀 자체 등록
//        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        // 기존 메뉴 셀 & 포커스 셀 등록
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "TitleMenuCell", for: index) as! TitleLabelMenuViewCell
        
        // 메뉴 셀 작업
        cell.titleLabel.text = dataSource[index].menuTitle
//        cell.menu1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return cell
    }
}

// MARK: - 컨텐츠 데이터 소스_Paging Kit
extension MainPageViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

// MARK: - 메뉴 컨트롤러 델리게이트_Paging Kit
extension MainPageViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

// MARK: - 컨텐츠 컨트롤러 델리게이트_Paging Kit
extension MainPageViewController: PagingContentViewControllerDelegate {
    // 컨텐츠 컨트롤러 스크롤하면, 메뉴 컨트롤러도 함께 움직임
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
