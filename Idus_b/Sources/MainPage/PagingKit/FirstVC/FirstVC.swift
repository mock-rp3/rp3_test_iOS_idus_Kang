//
//  FirstVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class FirstVC: BaseViewController {
    
    fileprivate var cellControllers = [TableCellController]()
    fileprivate let cellControllerFactory = MyCellControllerFactory()
    
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
        
        table.delegate = self
        table.dataSource = self
        
        cellControllerFactory.registerCells(on: table)
    }
    
}

// MARK: - Table
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableBannerCell.identifier, for: indexPath) as! FirstVCTableBannerCell
            cell.configure(with: models)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: FirstVCTableCategoryCell.identifier, for: indexPath) as! FirstVCTableCategoryCell
            cell.configure2(with: btnImgModels)
            return cell
        }
        
        // 셀 컨트롤러 활용
//        cellControllers[indexPath.row].cellFromTableView(tableView, forIndexPath: indexPath)
    }
    
    // 셀 컨트롤러 활용
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        cellControllers[indexPath.row].didSelectCell()
//    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.rowHeight
        return 190
    }
    
}
