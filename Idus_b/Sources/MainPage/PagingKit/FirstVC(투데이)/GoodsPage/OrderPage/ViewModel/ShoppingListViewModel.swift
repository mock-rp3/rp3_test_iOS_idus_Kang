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
    let shoppingListDataManager: ShoppingListDataManager = ShoppingListDataManager()
    var goods = [GoodsPageResponseResult]()
    
    // Storage
    private var items = [ShoppingList]()
    
    init() {
        shoppingListDataManager.getShoppinListData(delegate: self)
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

// MARK: - DataManager

// RelatedGoodsResult
extension ShoppingListViewModel {
    func successShoppingListData(result: GoodsPageResponseResult) {
        self.goods.append(result)
        for index in 0...1 {
            self.items.append(ShoppingList(shoppingOptionName: "   \(index). \(goods[0].options[index].optionName)",
                                           shoppingItem: [goods[0].options[0].optionDetailList[0].optionDetailName, goods[0].options[0].optionDetailList[1].optionDetailName],
                                           isSelected: [false, false]))
        }
    }
}
