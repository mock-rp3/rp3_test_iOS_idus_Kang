//
//  BannerTableCellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit
    
class BannerTableCellController: TableCellController { // GenericCellController<FirstVCTableBannerCell> {
    
    // 코드로 식별자 부여
    static let identifier = "BannerTableCellController"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "BannerTableCellController", bundle: nil)
    }
    
    var models = [imgModel]()
    var i = 1
    
    fileprivate let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
    // MARK: - 축약형
//    override func configureCell(_ cell: FirstVCTableBannerCell) {
//        // Configure banner cell...
//        cell.configure(with: models)
//    }
//
//    override func didSelectCell() {
//        // Do something for banner...
//        while let _ = UIImage(named: "main_banner\(i)") {
//            models.append(imgModel(imageName: "main_banner\(i)"))
//            i += 1
//        }
//    }
    
    // MARK: -원본
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: FirstVCTableBannerCell.self))
    }

    static func registerCell(on tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: FirstVCTableBannerCell.self)), forCellReuseIdentifier: cellIdentifier)
    }

    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! FirstVCTableBannerCell

        // Configure banner cell...
        cell.configure(with: models)

        return cell
    }

    func didSelectCell() {
        // Do something for banner...
        while let _ = UIImage(named: "main_banner\(i)") {
            models.append(imgModel(imageName: "main_banner\(i)"))
            i += 1
        }
    }
    
}
