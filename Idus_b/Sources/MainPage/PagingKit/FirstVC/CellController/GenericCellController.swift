//
//  GenericCellController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import Foundation
import UIKit

class GenericCellController<T: ReusableCell>: CellController<T.CellHolder> {

    typealias BaseReusableCell = T.CellHolder.CellType
    
    final override class var cellClass: AnyClass {
        return T.self
    }

    final override func configureCell(_ cell: BaseReusableCell) {
        let cell = cell as! T
        configureCell(cell)
    }

    func configureCell(_ cell: T) {
        // By default do nothing.
    }

}
