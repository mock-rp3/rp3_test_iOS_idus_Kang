//
//  NowGoodsDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/09/10.
//

import Alamofire

class NowGoodsDataManager {
    func getNowGoodsData(delegate: SecondVC) {

        let params : Parameters = [
            "index" : "1"
        ]
        
        // GET
        // /works/realtime-purchase?index=1
        AF.request("\(Constant.BASE_URL)/works/realtime-purchase",
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
//                   encoding: JSONEncoding.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: NowGoodsResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> 작품 정보 가져오기 성공 ")
                    if response.isSuccess, let nowGoodsPageData = response.result?.workList {
                        delegate.successGetNowGoodsData(result: nowGoodsPageData)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 작품 정보 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}
