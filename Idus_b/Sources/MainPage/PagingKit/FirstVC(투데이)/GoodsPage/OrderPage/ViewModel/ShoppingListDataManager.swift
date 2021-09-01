//
//  ShoppingListDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/31.
//

import Alamofire

class ShoppingListDataManager {
    func getShoppinListData(delegate: GoodsPageViewController) {

        // GET
        // /works/:workIndex    path variable(:workIndex 부분은 그냥 숫자 넣어줘도 됨)
        AF.request("\(Constant.BASE_URL)/works/1",
                   method: .get,
                   parameters: nil,
//                   encoding: URLEncoding.queryString,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: GoodsPageResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> 작품 정보 가져오기 성공 ")
                    if response.isSuccess, let shoppingListData = response.result {
                        delegate.successShoppingListData(result: shoppingListData)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 작품 정보 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}
