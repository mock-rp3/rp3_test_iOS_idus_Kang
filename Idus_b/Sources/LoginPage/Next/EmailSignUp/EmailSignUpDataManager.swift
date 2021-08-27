//
//  EmailSignUpDataManager.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

import Alamofire

class EmailSignUpDataManager {
    func postSignUp(_ parameters: EmailSignUpRequest, delegate: EmailSignUpViewController) {
        AF.request("\(Constant.BASE_URL)/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmailSignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.result
                        delegate.didSuccessSignUp(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2020: delegate.failedToRequest(message: "유효하지않은 이메일입니다.")
                        case 2021: delegate.failedToRequest(message: "유요하지않은 이름입니다.")
                        case 2022: delegate.failedToRequest(message: "유효하지않은 비밀번호입니다.")
                        case 2023: delegate.failedToRequest(message: "유효하지않은 전화번호입니다.")
                        case 2024: delegate.failedToRequest(message: "유효하지않은 전달값입니다.")
                        case 2025: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2026: delegate.failedToRequest(message: "비밀번호 형식을 확인해주세요.")
                        case 2030: delegate.failedToRequest(message: "이메일이 공백입니다.")
                        case 2031: delegate.failedToRequest(message: "이메일의 길이가 유효하지않습니다.")
                        case 2032: delegate.failedToRequest(message: "이름이공백입니다.")
                        case 2033: delegate.failedToRequest(message: "이름의 길이가 유효하지않습니다.")
                        case 2034: delegate.failedToRequest(message: "비밀번호가 공백입니다.")
                        case 2035: delegate.failedToRequest(message: "비밀번호의 길이가 유효하지않습니다.")
                        case 2036: delegate.failedToRequest(message: "전화번호가 공백입니다")
                        case 2037: delegate.failedToRequest(message: "전화번호의 길이가 유효하지않습니다.")
                        case 2038: delegate.failedToRequest(message: "전화번호의 형식을 확인해주세요")
                        case 3010: delegate.failedToRequest(message: "이미 회원가입된 이메일입니다.")
                            
                        case 5000: delegate.failedToRequest(message: "회원가입에 실패하였습니다.")
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
