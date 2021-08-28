//
//  KakaoSignUpRequest.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/29.
//

import Foundation

struct KakaoSignUpRequest: Encodable {
    var email: String
    var name: String
    var password: String
    var tel: String
    var pushAgreement: String
}
