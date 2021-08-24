//
//  ShoppingListViewModel.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import Foundation

class ShoppingListViewModel {
    
    // Storage
    private var items = [ShoppingList]()
    
    init() {
        // dummy data
        for index in 0...5 {
            self.items.append(ShoppingList(shoppingOptionName: "   \(index). 쇼핑백",
                                           shoppingItem: ["쇼핑백 : 미포함 구매", "쇼핑백 : 포함 구매(개당500원추가) (+500원)"],
                                           isSelected: [false, false]))
        }
    }
    
    
    public var count: Int {
        return items.count
    }
    
    public func itemAt(index: Int) -> ShoppingList {
        return self.items[index]
    }
    
    public func setCompletionState(dateIndex: Int, itemIndex: Int) {
        
        // 첫 번째 "index"는 어떤 날짜에 있는지에 대한 인덱스이다.
        // 두 번째 "index"는 어떤 식재료인지 알려주는 인덱스이다.
        items[dateIndex].isSelected[itemIndex] = !(items[dateIndex].isSelected[itemIndex])
    }
    
    public func updateShoppingItem(dateIndex: Int, itemIndex: Int, newValue: String) {
        
        items[dateIndex].shoppingItem[itemIndex] = newValue
    }
    
    public func addShoppingList(item: ShoppingList) {
        items.append(item)
    }
    
    public func updateIsFoldingState(dateIndex: Int) {
        
        items[dateIndex].isFolding = !items[dateIndex].isFolding
    }
}
