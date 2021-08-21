//
//  CellProtocol.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import Foundation
import UIKit

// MARK: -cell 이 어떤 셀인지
protocol ListItem {
    var isBanner: Bool {get}
    var isCategory: Bool {get}
    var isGoods: Bool {get}
}

// MARK: -테이블 뷰 셀 프로토콜
protocol TableCellController {
    static func registerCell(on tableView: UITableView)
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell
    func didSelectCell()
}

// MARK: - ReusableCell
protocol ReusableCell: AnyObject {
    associatedtype CellHolder: ReusableCellHolder
}

extension UITableViewCell: ReusableCell {
    typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
    typealias CellHolder = UICollectionView
}

// MARK: - ReusableCellHolder
protocol ReusableCellHolder: AnyObject {
    associatedtype CellType: ReusableCell where CellType.CellHolder == Self

    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
    
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
}

extension UITableView: ReusableCellHolder {

    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

protocol CellControllerType {

    associatedtype CollectionType: ReusableCellHolder

    static func registerCell(on reusableCellHolder: CollectionType)
    func cellFromReusableCellHolder(_ reusableCellHolder: CollectionType, forIndexPath indexPath: IndexPath) -> CollectionType.CellType
    func didSelectCell()
}

extension UICollectionView: ReusableCellHolder {}
