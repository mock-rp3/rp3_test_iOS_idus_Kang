//
//  NaverSignUpDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/29.
//

import Alamofire

class NaverSignUpDataManager {
    func postNaverSignUp(_ parameters: NaverSignUpRequest, delegate: LoginViewController) {
        
        AF.request("\(Constant.BASE_URL)/users",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: NaverSignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessNaverSignUp(message: "네이버 가입에 성공했습니다.")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 3010: delegate.didSuccessNaverSignUp(message: "이미 회원가입된 이메일입니다.")
                        case 5000: delegate.failedNaverSignUpToRequest(message: "회원가입에 실패하였습니다.")
                        default: delegate.failedNaverSignUpToRequest(message: "피드백을 주세요.")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.didSuccessNaverSignUp(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
