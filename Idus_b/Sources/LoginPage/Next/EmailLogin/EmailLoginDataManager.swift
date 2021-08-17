//
//  EmailLoginDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import Alamofire

class EmailLoginDataManager {
    func postLogin(_ parameters: EmailLoginRequest, delegate: EmailLoginViewController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmailLoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLogin(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2020: delegate.failedToRequest(message: "유효하지않은 이메일입니다.")
                        case 2022: delegate.failedToRequest(message: "유효하지않은 비밀번호입니다.")
                        case 2025: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 3014: delegate.failedToRequest(message: "없는아이디거나 비밀번호가틀렸습니다.")
                        case 3020: delegate.failedToRequest(message: "탈퇴한회원입니다.")
                        case 3021: delegate.failedToRequest(message: "정지된회원입니다.")
                        default: delegate.failedToRequest(message: "피드백을 주세요.")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
