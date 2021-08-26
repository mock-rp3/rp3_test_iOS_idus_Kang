//
//  RelatedGoodsDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Alamofire

class RelatedGoodsDataManager {
    func getRelatedGoodsData(delegate: FirstVC) {
            
        // windex의 start 값으로부터 kindex 값 작품 최대 10개 가져옴
        // 현재 12개의 더미 데이터 있음
        let params : Parameters = [
            "kindex" : "4",
            "windex" : "0",
            "start" : "6"
        ]
        
        // GET
        // /works/related-work?kindex=4&windex=1&start=0
        AF.request("\(Constant.BASE_URL)/works/related-work",
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
//                   encoding: JSONEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: RelatedGoodsResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> 연관된 작품 가져오기 성공 ")
                    if response.isSuccess, let relatedGoodsData = response.result {
                        delegate.successGetRelatedGoodsData(result: relatedGoodsData)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 연관된 작품 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}
