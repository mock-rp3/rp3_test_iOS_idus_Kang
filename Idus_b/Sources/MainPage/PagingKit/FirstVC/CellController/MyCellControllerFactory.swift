//
//  MyCellControllerFactory.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import Foundation
import UIKit

class MyCellControllerFactory {
    
    // xib 등록
    func registerCells(on tableView: UITableView) {
        BannerTableCellController.registerCell(on: tableView)
        CategoryTableCellController.registerCell(on: tableView)
        GoodsTableCellController.registerCell(on: tableView)
    }
    
    func cellControllers(with items: [ListItem]) -> [TableCellController] {
        // items에 맞는 Cell Controller를 모두 생성해서 리턴
        return items.map { item in
            
            if item.isBanner {
                return BannerTableCellController(item: item) as TableCellController
            } else if item.isCategory {
                return CategoryTableCellController(item: item) as TableCellController
            } else {
                return GoodsTableCellController(item: item) as TableCellController
            }
        }
    }
}
