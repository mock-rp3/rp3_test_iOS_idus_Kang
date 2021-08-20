//
//  CategoryTableCellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class CategoryTableCellController: TableCellController {
    
    // 코드로 식별자 부여
    static let identifier = "CategoryTableCellController"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "CategoryTableCellController", bundle: nil)
    }
    
    fileprivate let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: FirstVCTableCategoryCell.self))
    }
    
    static func registerCell(on tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: FirstVCTableCategoryCell.self)), forCellReuseIdentifier: cellIdentifier)
    }
    
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! FirstVCTableCategoryCell
        
        // Configure FirstVCTableCategoryCell...
        
        return cell
    }
    
    func didSelectCell() {
        // Do something for FirstVCTableCategoryCell...
    }
    
}
