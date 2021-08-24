//
//  ShoppingList.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import Foundation

struct ShoppingList {
    
    var shoppingOptionName: String    // "1. 쇼핑백"
    var isFolding: Bool = false
    var shoppingItem: [String]  // ["쇼핑백 : 미포함 구매", "쇼핑백 : 포함 구매(개당500원추가) (+500원)", "기부"]
    var isSelected: [Bool]      // [true, false, true]
}
