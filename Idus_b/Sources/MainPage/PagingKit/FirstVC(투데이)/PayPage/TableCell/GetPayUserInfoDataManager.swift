//
//  GetPayUserInfoDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/09/08.
//

import Alamofire

class GetPayUserInfoDataManager {
    func getPayUserInfo(userIdx: Int, jwt: String, delegate: PayTableViewCell) {
            
        let header: HTTPHeaders = [
            "X-ACCESS-TOKEN": jwt
        ]
        
        // GET
        AF.request("\(Constant.BASE_URL)/users/\(userIdx)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .validate()
            .responseDecodable(of: UsersInfoResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> 유저 정보 가져오기 성공 ")
                    if response.isSuccess, let payUserInfo = response.result {
                        delegate.successGetPayUserInfo(result: payUserInfo)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 유저 정보 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}
