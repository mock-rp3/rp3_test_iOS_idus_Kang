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
    static var viewController: (UIColor) -> UIViewController = { (color) in
       let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }

    var dataSource = [(menuTitle: "투데이", vc: viewController(.red)), (menuTitle: "실시간", vc: viewController(.blue)), (menuTitle: "NEW", vc: viewController(.yellow))]
    
    
    // MARK: -생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메뉴 셀 & 포커스 셀 자체 등록
//        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        // 기존 메뉴 셀 & 포커스 셀 등록
        menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "TitleMenuCell")
//        menuViewController.registerFocusView(view: UnderlineFocusView())
        
        // 메뉴&컨텐츠 데이터 리로드
        menuViewController.reloadData()
        contentViewController.reloadData()
        
    }
    
    // Paging Kit 세그웨이 준비
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
    
}

// MARK: - 메뉴 데이터 소스_Paging Kit
extension MainPageViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
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
        return dataSource[index].vc
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
