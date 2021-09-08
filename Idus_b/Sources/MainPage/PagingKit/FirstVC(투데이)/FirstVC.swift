//
//  FirstVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class FirstVC: BaseViewController {
    
    
    // MARK: - 프로퍼티
    
    lazy var relatedGoodsDataManager: RelatedGoodsDataManager = RelatedGoodsDataManager()
    lazy var todayGoodsDataManager: TodayGoodsDataManager = TodayGoodsDataManager()
    
    // (보류) 셀 컨트롤러
//    fileprivate var cellControllers = [CellController<UITableView>]() // 축약형
//    fileprivate var cellControllers = [TableCellController]() // 원본
//    fileprivate let cellControllerFactory = MyCellControllerFactory()
    
    @IBOutlet var table: UITableView!
    var bannerImgs = [imgModel]()
    var i = 1
    var categoryImgs = [btnImgModel]()
    var j = 1
    var goods = [RelatedGoodsResult]()
    var todayGoods = [TodayGoodsResult]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        registDatamanager()
        setDataSource()
        registTableCell()
        
        //(보류) 셀 컨트롤러 셀 등록
//        cellControllerFactory.registerCells(on: table)
        
        // 인디케이터 (로딩)
        showIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.table.reloadData()
            self.dismissIndicator()
        }
        
    }
    
    // MARK: - Helper
    private func setDataSource() {
        while let _ = UIImage(named: "main_banner\(i)") {
            bannerImgs.append(imgModel(imageName: "main_banner\(i)"))
            i += 1
        }
        
        while let _ = UIImage(named: "main_category\(j)") {
            categoryImgs.append(btnImgModel(btnImageName: "main_category\(j)"))
            j += 1
        }
    }
    
    private func registTableCell() {
        table.delegate = self
        table.dataSource = self
        table.register(FirstVCTableBannerCell.nib(), forCellReuseIdentifier: FirstVCTableBannerCell.identifier)

        table.register(FirstVCTableCategoryCell.nib(), forCellReuseIdentifier: FirstVCTableCategoryCell.identifier)

        table.register(FirstVCTableGoodsCell.nib(), forCellReuseIdentifier: FirstVCTableGoodsCell.identifier)
        
        table.register(TodayGoodsTableViewCell.nib(), forCellReuseIdentifier: TodayGoodsTableViewCell.identifier)
    }
    
    func registDatamanager() {
        relatedGoodsDataManager.getRelatedGoodsData(delegate: self)
        todayGoodsDataManager.getTodayGoodsData(delegate: self)
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
            cell.configure(with: bannerImgs)
            cell.delegate = self
            return cell
        } else if indexPath.row == 1{
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableCategoryCell.identifier, for: indexPath) as! FirstVCTableCategoryCell
            cell.configure2(with: categoryImgs)
            cell.delegate = self
            return cell
        } else if indexPath.row == 2{
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableGoodsCell.identifier, for: indexPath) as! FirstVCTableGoodsCell
            cell.delegate = self
            cell.configure3(with: goods)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: TodayGoodsTableViewCell.identifier, for: indexPath) as! TodayGoodsTableViewCell
            cell.configure4(with: todayGoods)
            cell.delegate = self
            return cell
        }

        // (보류) 셀 컨트롤러 활용 축약형
//        return cellControllers[indexPath.row].cellFromReusableCellHolder(table, forIndexPath: indexPath)
      
        // (보류) 셀 컨트롤러 활용 원본
//        return cellControllers[indexPath.row].cellFromTableView(table, forIndexPath: indexPath)

    }
    
    // (보류) 셀 컨트롤러 활용
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        cellControllers[indexPath.row].didSelectCell()
//    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 190
        } else if indexPath.row == 1 {
            return 84
        } else if indexPath.row == 2 {
            return 380
        } else {
            return 520
        }
    }
    
}

// MARK: - 배너 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: BannerDelegate {
    func didSelectedBanner(_ index: Int) {
        self.presentAlert(title: "\(index)번째 배너입니다.")
    }
}

// MARK: - 카테고리 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: CategoryDelegate {
    func didSelectedCategory(_ index: Int) {
        self.presentAlert(title: "\(index)번째 카테고리입니다.")
    }
}

// MARK: - 작품 컬렉션뷰 이미지 버튼 클릭 이벤트 델리게이트 채택
extension FirstVC: GoodsViewDelegate {
    func didSelectedGoodsBtn(_ index: Int) {
        
        //nextVC : push 될 뷰
        let pushedVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController") as! GoodsPageViewController

        pushedVC.goodsIndexNum = index+1
         
        self.navigationController?.pushViewController(pushedVC, animated: true)
        
        // 모달 방식
//        nextVC.modalTransitionStyle = .partialCurl
//        pushedVC.modalPresentationStyle = .fullScreen
//        self.present(pushedVC, animated: true, completion: nil)
        
    }
}


// MARK: - 오늘의 작품 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension FirstVC: TodayGoodsViewDelegate {
    func didSelectedGoods(_ index: Int) {
        self.presentAlert(title: "\(index)번째 작품입니다.")
    }
}

// MARK: - DataManager

// RelatedGoodsResult
extension FirstVC {
    func successGetRelatedGoodsData(result: [RelatedGoodsResult]) {
        for index in 0...5 {
            self.goods.append(result[index])
        }
    }
}

// TodayGoodsResult
extension FirstVC {
    func successTodayGoodsData(result: [TodayGoodsResult]) {
        for index in 0...11 {
            self.todayGoods.append(result[index])
        }
    }
}
