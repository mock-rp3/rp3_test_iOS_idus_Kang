//
//  CellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//


import UIKit

class CellController<T: ReusableCellHolder>: CellControllerType {

    class var cellClass: AnyClass {
        fatalError("Must be implemented by children")
    }

    static var cellIdentifier: String {
        return String(describing: cellClass)
    }

    static func registerCell(on reusableCellHolder: T) {
        let bundle = Bundle(for: cellClass)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }

    final func cellFromReusableCellHolder(_ reusableCellHolder: T, forIndexPath indexPath: IndexPath) -> T.CellType {
        let cell = reusableCellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
        configureCell(cell)
        return cell
    }

    func configureCell(_ cell: T.CellType) {
        // To be defined by children. By default do nothing.
    }
    
    func didSelectCell() {
        // To be defined by children. By default do nothing.
    }
    
}
