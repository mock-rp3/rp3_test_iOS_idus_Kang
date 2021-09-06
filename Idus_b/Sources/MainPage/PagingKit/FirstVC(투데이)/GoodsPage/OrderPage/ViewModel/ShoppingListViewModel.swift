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
//    var selectedOptionIndex = [(Int,Int)]()
    var selectedOptionIndex0 = [SelectedOptionIndex]()
    
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
    
    public func setCompletionState(optionIndex: Int, itemIndex: Int) {
        
        // 첫 번째 "index"는 어떤 옵션명에 있는지에 대한 인덱스이다.
        // 두 번째 "index"는 어떤 옵션내용인지 알려주는 인덱스이다.
        items[optionIndex].isSelected[itemIndex] = !(items[optionIndex].isSelected[itemIndex])
        
        // 선택한 옵션 아이템 정보 유저디폴트로 저장
        let selectedOptionName = items[optionIndex].shoppingOptionName
        let selectedItem = items[optionIndex].shoppingItem[itemIndex]
        
            // 결제 페이지에 보낼 선택한 옵션&아이템 인덱스 값 저장

            selectedOptionIndex0.append(SelectedOptionIndex(selectedOptionIndex: optionIndex, selectedItemIndex: itemIndex))
            let selectedOptionIndex = try! PropertyListEncoder().encode(selectedOptionIndex0)
            UserDefaults.standard.set(selectedOptionIndex, forKey: "selectedOptionIndex")
        
        if items.count != optionIndex + 1 {
            let plusSelectedItem0 = "\(selectedOptionName) : \(selectedItem) / "
            UserDefaults.standard.set(plusSelectedItem0, forKey: "plusSelectedItem\(optionIndex)")
        } else {
            let plusSelectedItem0 = "\(selectedOptionName) : \(selectedItem)"
            UserDefaults.standard.set(plusSelectedItem0, forKey: "plusSelectedItem\(optionIndex)")
        }
        plusSelectedItem += UserDefaults.standard.value(forKey: "plusSelectedItem\(optionIndex)") as! String
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

