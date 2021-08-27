////
////  MyCellControllerFactory.swift
////  Idus_b
////
////  Created by 강성수 on 2021/08/21.
////
//
//import Foundation
//import UIKit
//
//
//// MARK: -cell 이 어떤 셀인지
//protocol ListItem {
//    var isBanner: Bool {get}
//    var isCategory: Bool {get}
//    var isGoods: Bool {get}
//}
//
//// MARK: -테이블 뷰 셀 프로토콜
//protocol TableCellController {
//    static func registerCell(on tableView: UITableView)
//    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell
//    func didSelectCell()
//}
//
//class MyCellControllerFactory {
//    
//    // xib 등록
//    func registerCells(on tableView: UITableView) {
//        BannerTableCellController.registerCell(on: tableView)
//        CategoryTableCellController.registerCell(on: tableView)
//        GoodsTableCellController.registerCell(on: tableView)
//    }
//    
//    func cellControllers(with items: [ListItem]) -> [TableCellController] {
//        // items에 맞는 Cell Controller를 모두 생성해서 리턴
//        return items.map { item in
//            
//            if item.isBanner {
//                return BannerTableCellController(item: item) as TableCellController
//            } else if item.isCategory {
//                return CategoryTableCellController(item: item) as TableCellController
//            } else {
//                return GoodsTableCellController(item: item) as TableCellController
//            }
//        }
//    }
//}
