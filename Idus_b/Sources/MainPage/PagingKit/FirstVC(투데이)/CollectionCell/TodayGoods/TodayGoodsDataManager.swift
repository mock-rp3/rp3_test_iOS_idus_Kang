//
//  TodayGoodsDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Alamofire

class TodayGoodsDataManager {
    func getTodayGoodsData(delegate: FirstVC) {
            
        let params : Parameters = [
            "kidx" : "4"
        ]
        
        // GET
        // /works/keyword?kidx=4
        AF.request("\(Constant.BASE_URL)/works/keyword",
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
//                   encoding: JSONEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: TodayGoodsResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> 연관된 작품 가져오기 성공 ")
                    if response.isSuccess, let todayGoodsData = response.result {
                        delegate.successTodayGoodsData(result: todayGoodsData)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 연관된 작품 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}
