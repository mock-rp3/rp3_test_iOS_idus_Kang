//
//  EmailSignUpResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/17.
//

struct EmailSignUpResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}
