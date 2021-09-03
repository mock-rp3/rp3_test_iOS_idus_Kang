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
    var plusSelectedItem = ""
    
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
        
        // 선택한 옵션 아이템 정보 유저디폴트로 저장
        let selectedOptionName = items[dateIndex].shoppingOptionName
        let selectedItem = items[dateIndex].shoppingItem[itemIndex]
        
        if items.count != dateIndex + 1 {
            let plusSelectedItem0 = "\(selectedOptionName) : \(selectedItem) / "
            UserDefaults.standard.set(plusSelectedItem0, forKey: "plusSelectedItem\(dateIndex)")
        } else {
            let plusSelectedItem0 = "\(selectedOptionName) : \(selectedItem)"
            UserDefaults.standard.set(plusSelectedItem0, forKey: "plusSelectedItem\(dateIndex)")
        }
        plusSelectedItem += UserDefaults.standard.value(forKey: "plusSelectedItem\(dateIndex)") as! String
        UserDefaults.standard.set(plusSelectedItem, forKey: "plusSelectedItem")
        
    }
    
    public func updateShoppingItem(dateIndex: Int, itemIndex: Int, newValue: String) {
        
        items[dateIndex].shoppingItem[itemIndex] = newValue
    }
    
    public func addShoppingList(item: ShoppingList) {
        items.append(item)
    }
    
    public func updateIsFoldingState(dateIndex: Int) {
        
        if items.count == dateIndex {
            return
        } else {
            items[dateIndex].isFolding = !items[dateIndex].isFolding
        }
    }
}

