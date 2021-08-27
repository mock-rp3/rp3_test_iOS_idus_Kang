//
//  PayDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import Alamofire

class PayDataManager {
//    func postPayment(_ parameters: PayRequest, jwt: String, delegate: PayVC) {
//        
//        let header: HTTPHeaders = [
//            "X-ACCESS-TOKEN" : jwt
//        ]
//        
//        AF.request("\(Constant.BASE_URL)/works/order",
//                   method: .post,
//                   parameters: parameters,
//                   encoder: JSONParameterEncoder(),
//                   headers: header)
//            .validate()
//            .responseDecodable(of: EmailSignUpResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess {
//                        let result = response.result
//                        delegate.didSuccessPayment(result)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        case 1000: delegate.failedToRequestPayment(message: "요청에성공하였습니다.")
//                        case 4000: delegate.failedToRequestPayment(message: "데이터베이스에러")
//                        
//                        default: delegate.failedToRequestPayment(message: "피드백을 주세요.")
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    delegate.failedToRequestPayment(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
}
