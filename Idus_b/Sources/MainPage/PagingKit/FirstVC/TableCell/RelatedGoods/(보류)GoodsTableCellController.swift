//
//  GoodsTableCellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class GoodsTableCellController: TableCellController { // GenericCellController<FirstVCTableGoodsCell> { 
    
    // 코드로 식별자 부여
    static let identifier = "GoodsTableCellController"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "GoodsTableCellController", bundle: nil)
    }
    
    var relatedGoodsResult = [RelatedGoodsResult]()
//    var j = 1
    
    fileprivate let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
//    lazy var dataManager: RelatedGoodsDataManager = RelatedGoodsDataManager()
    
    
    
    // MARK: - 축약형
//    override func configureCell(_ cell: FirstVCTableGoodsCell) {
//        // Configure FirstVCTableGoodsCell...
//        cell.configure3(with: btnImgModels)
//    }
//
//    override func didSelectCell() {
//        // Do something for FirstVCTableGoodsCell...
//        while let _ = UIImage(named: "main_category\(j)") {
//            btnImgModels.append(btnImgModel(btnImageName: "main_category\(j)"))
//            j += 1
//        }
//    }
    
    // MARK: - 원본
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: FirstVCTableGoodsCell.self))
    }
    
    static func registerCell(on tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: FirstVCTableGoodsCell.self)), forCellReuseIdentifier: cellIdentifier)
    }
    
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! FirstVCTableGoodsCell
        
        // Configure Goods cell...
        cell.configure3(with: relatedGoodsResult)
        
        return cell
    }
    
    func didSelectCell() {
        // Do something for Goods...
//        dataManager.getRelatedGoodsData(delegate: self)
    }
}

//// MARK: - RelatedGoodsResult
//extension GoodsTableCellController {
//
//    func successGetInfo(result: [RelatedGoodsResult]) {
//        for index in 0...11 {
//            self.relatedGoodsResult.append(result[index])
//        }
//    }
//
//    func failedToRequest(message: String) {
//        print(message)
//    }
//}
