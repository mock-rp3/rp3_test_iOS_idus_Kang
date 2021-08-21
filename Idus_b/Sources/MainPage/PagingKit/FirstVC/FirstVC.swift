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
        
        table.delegate = self
        table.dataSource = self
        
        // 셀 컨트롤러 셀 등록
//        cellControllerFactory.registerCells(on: table)
    }
    
}

// MARK: - Table
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableBannerCell.identifier, for: indexPath) as! FirstVCTableBannerCell
            cell.configure(with: models)
            return cell
        } else if indexPath.row == 1{
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableCategoryCell.identifier, for: indexPath) as! FirstVCTableCategoryCell
            cell.configure2(with: btnImgModels)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableGoodsCell.identifier, for: indexPath) as! FirstVCTableGoodsCell
            cell.configure3(with: btnImgModels)
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
