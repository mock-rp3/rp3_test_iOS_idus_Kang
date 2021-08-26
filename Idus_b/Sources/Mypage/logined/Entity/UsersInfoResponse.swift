//
//  UserrsInfoResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import Foundation

// MARK: - UsersInfoResponse
struct UsersInfoResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: GetUserInfoResult?
}

// MARK: - Result
struct GetUserInfoResult: Codable {
    let userIndex: Int
    let email, name, tel: String
    let token: JSONNull?
    let profileImg: String
    let grage: String
    let grageName: String
    let birthday, gender, holder, number: JSONNull?
    let bankingName: JSONNull?
    let reserves, coupon: Int
    let notice: Notice
    let shippingAddresses: [ShippingAddress]
    let lastLoginAt, statusAt: String
}

// MARK: - Notice
struct Notice: Codable {
    let message, review, app, sms: String
    let email, followDiscount, followStory, wish: String
    let work: String
}

// MARK: - ShippingAddress
struct ShippingAddress: Codable {
    let addressIndex: Int
    let name, tel, zipcode, address: JSONNull?
    let detailedAddress: JSONNull?
    let number: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        
        default:
            hasher.combine(0)
        }
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

