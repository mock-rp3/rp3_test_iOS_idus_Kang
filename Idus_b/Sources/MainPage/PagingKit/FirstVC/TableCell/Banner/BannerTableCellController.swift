//
//  BannerTableCellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit
    
class BannerTableCellController: TableCellController {
    
    // 코드로 식별자 부여
    static let identifier = "BannerTableCellController"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "BannerTableCellController", bundle: nil)
    }
    
    fileprivate let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: FirstVCTableBannerCell.self))
    }
    
    static func registerCell(on tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: FirstVCTableBannerCell.self)), forCellReuseIdentifier: cellIdentifier)
    }
    
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! FirstVCTableBannerCell
        
        // Configure FirstVCTableBannerCell...
        
        return cell
    }
    
    func didSelectCell() {
        // Do something for FirstVCTableBannerCell...
    }
    
}
