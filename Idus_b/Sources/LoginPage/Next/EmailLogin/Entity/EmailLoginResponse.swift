//
//  EmailLoginResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

struct EmailLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LoginResult?
}

struct LoginResult: Decodable {
    var userIdx: Int
    var jwt: String
    var statusAt: String
}
