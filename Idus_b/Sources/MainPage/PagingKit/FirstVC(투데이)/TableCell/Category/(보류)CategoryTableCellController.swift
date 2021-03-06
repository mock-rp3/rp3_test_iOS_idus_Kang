////
////  CategoryTableCellController.swift
////  Idus_b
////
////  Created by 강성수 on 2021/08/21.
////
//
//import UIKit
//
//class CategoryTableCellController: TableCellController { // GenericCellController<FirstVCTableCategoryCell> {
//    
//    // 코드로 식별자 부여
//    static let identifier = "CategoryTableCellController"
//    
//    // 코드로 nib명 부여
//    static func nib() -> UINib {
//        return UINib(nibName: "CategoryTableCellController", bundle: nil)
//    }
//    
//    var btnImgModels = [btnImgModel]()
//    var j = 1
//    
//    fileprivate let item: ListItem
//    
//    init(item: ListItem) {
//        self.item = item
//    }
//    
//    // MARK: - 축약형
////    override func configureCell(_ cell: FirstVCTableCategoryCell) {
////        // Configure category cell...
////        cell.configure2(with: btnImgModels)
////    }
////
////    override func didSelectCell() {
////        // Do something for category...
////        while let _ = UIImage(named: "main_category\(j)") {
////            btnImgModels.append(btnImgModel(btnImageName: "main_category\(j)"))
////            j += 1
////        }
////    }
//    
//    // MARK: - 원본
//    fileprivate static var cellIdentifier: String {
//        return String(describing: type(of: FirstVCTableCategoryCell.self))
//    }
//    
//    static func registerCell(on tableView: UITableView) {
//        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: FirstVCTableCategoryCell.self)), forCellReuseIdentifier: cellIdentifier)
//    }
//    
//    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! FirstVCTableCategoryCell
//        
//        // Configure banner cell...
//        cell.configure2(with: btnImgModels)
//        
//        return cell
//    }
//    
//    func didSelectCell() {
//        // Do something for banner...
//        while let _ = UIImage(named: "main_category\(j)") {
//            btnImgModels.append(btnImgModel(btnImageName: "main_category\(j)"))
//            j += 1
//        }
//    }
//}
