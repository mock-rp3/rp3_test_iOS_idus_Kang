//
//  ShoppingListViewModel.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import Foundation

// 구매 옵션 더미데이터
class ShoppingListViewModel {
    
    // MARK: - 프로퍼티
    
    // Storage
    private var items = [ShoppingList]()
    var index = 0
    
    init() {
        while let shoppingOptionNames = UserDefaults.standard.value(forKey: "shoppingOptionNames\(index)") as? String {
            items.append(ShoppingList(shoppingOptionName: shoppingOptionNames,
                                      shoppingItem: UserDefaults.standard.array(forKey: "shoppingItems\(index)") as! [String],
                                      isSelected: UserDefaults.standard.array(forKey: "isSelecteds\(index)") as! [Bool]))
            index += 1
        }
    }
    
    public var count: Int {
        return items.count
    }
    
    public func itemAt(index: Int) -> ShoppingList {
        return self.items[index]
    }
    
    public func setCompletionState(dateIndex: Int, itemIndex: Int) {
        
        // 첫 번째 "index"는 어떤 옵션명에 있는지에 대한 인덱스이다.
        // 두 번째 "index"는 어떤 옵션내용인지 알려주는 인덱스이다.
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

