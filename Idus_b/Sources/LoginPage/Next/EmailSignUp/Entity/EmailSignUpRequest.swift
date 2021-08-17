//
//  EmailSignUpRequest.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

struct EmailSignUpRequest: Encodable {
    var email: String
    var name: String
    var password: String
    var tel: String
    var pushAgreement: String
}
