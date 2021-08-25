//
//  LoginedMypageDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import Alamofire

class LoginedMypageDataManager {
    func getUserInfo(userIdx: Int, jwt: String, delegate: LoginedMypageViewController) {
            
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
                    if response.isSuccess, let userInfo = response.result {
                        delegate.successGetInfo(result: userInfo)
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                    print("DEBUG>> 유저 정보 가져오기 API Error : \(error.localizedDescription)")
                }
            }
    }
}


