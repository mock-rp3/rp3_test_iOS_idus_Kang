//
//  NaverSignUpResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/29.
//

struct NaverSignUpResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}
