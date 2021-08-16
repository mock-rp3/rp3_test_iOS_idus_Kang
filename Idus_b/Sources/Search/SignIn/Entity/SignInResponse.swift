//
//  SignInResponse.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

struct SignInResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: SignInResult?
}

struct SignInResult: Decodable {
    var token: String
    var userInfoIdx: Int
}
