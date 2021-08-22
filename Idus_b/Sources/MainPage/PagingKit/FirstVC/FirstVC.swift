//
//  FirstVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class FirstVC: BaseViewController {
    
    // 셀 컨트롤러
//    fileprivate var cellControllers = [CellController<UITableView>]() // 축약형
//    fileprivate var cellControllers = [TableCellController]() // 원본
//    fileprivate let cellControllerFactory = MyCellControllerFactory()
    
    @IBOutlet var table: UITableView!
    var models = [imgModel]()
    var i = 1
    var btnImgModels = [btnImgModel]()
    var j = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while let _ = UIImage(named: "main_banner\(i)") {
            models.append(imgModel(imageName: "main_banner\(i)"))
            i += 1
        }
        table.register(FirstVCTableBannerCell.nib(), forCellReuseIdentifier: FirstVCTableBannerCell.identifier)

        while let _ = UIImage(named: "main_category\(j)") {
            btnImgModels.append(btnImgModel(btnImageName: "main_category\(j)"))
            j += 1
        }
        table.register(FirstVCTableCategoryCell.nib(), forCellReuseIdentifier: FirstVCTableCategoryCell.identifier)

        table.register(FirstVCTableGoodsCell.nib(), forCellReuseIdentifier: FirstVCTableGoodsCell.identifier)
        
        table.register(TodayGoodsTableViewCell.nib(), forCellReuseIdentifier: TodayGoodsTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        // 셀 컨트롤러 셀 등록
//        cellControllerFactory.registerCells(on: table)
    }
    
}

// MARK: - Table
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableBannerCell.identifier, for: indexPath) as! FirstVCTableBannerCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        } else if indexPath.row == 1{
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableCategoryCell.identifier, for: indexPath) as! FirstVCTableCategoryCell
            cell.configure2(with: btnImgModels)
            cell.delegate = self
            return cell
        } else if indexPath.row == 2{
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableGoodsCell.identifier, for: indexPath) as! FirstVCTableGoodsCell
            cell.configure3(with: btnImgModels)
            cell.delegate = self
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: TodayGoodsTableViewCell.identifier, for: indexPath) as! TodayGoodsTableViewCell
            cell.configure4(with: models)
            cell.delegate = self
            return cell
        }

        // 셀 컨트롤러 활용 축약형
//        return cellControllers[indexPath.row].cellFromReusableCellHolder(table, forIndexPath: indexPath)
      
        // 셀 컨트롤러 활용 원본
//        return cellControllers[indexPath.row].cellFromTableView(table, forIndexPath: indexPath)

    }
    
    // 셀 컨트롤러 활용
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        cellControllers[indexPath.row].didSelectCell()
//    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 190
        } else if indexPath.row == 1 {
            return 84
        } else {
            return 150
        }
    }
    
}

// MARK: - 배너 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: BannerDelegate {
    func didSelectedBanner(_ index: Int) {
        print("\(index)번째 셀")
    }
}

// MARK: - 카테고리 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: CategoryDelegate {
    func didSelectedCategory(_ index: Int) {
        print("\(index)번째 셀")
    }
}

// MARK: - 작품 컬렉션뷰 이미지 버튼 클릭 이벤트 델리게이트 채택
extension FirstVC: GoodsViewDelegate {
    func didSelectedGoodsBtn(_ index: Int) {
        
        print("\(index)번째 셀")
        
        // 텝바 컨트롤러 루트 뷰 전환
//        let goodsBtnController = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(identifier: "GoodsPageViewController")
//        changeRootViewController(goodsBtnController)
        
        //nextVC : popover 될 뷰
//        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")
//
//        nextVC.modalTransitionStyle = .partialCurl
//        nextVC.modalPresentationStyle = .fullScreen
//
//        self.present(nextVC, animated: true, completion: nil)
        
    }
}

// MARK: - 오늘의 작품 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: TodayGoodsViewDelegate {
    func didSelectedGoods(_ index: Int) {
        
        print("\(index)번째 셀")
    }
}
