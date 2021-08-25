//
//  UserrsInfoResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

// MARK: - Welcome
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


/*
struct UsersInfoResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: GetUserInfoResult?
}

struct GetUserInfoResult: Decodable {
    var userIndex: Int
    var email: String
    var name: String
    var tel: String
    var token: String?
    var profileImg: String
    var grade: String
    var birthday: String?
    var gender: String?
    var holder: String?
    var number: String?
    var bankingName: String?
    var reserves: Int
    var coupon: Int
    var notice: Notice
    var shippingAddresses: [ShippingAddresses?]
    var lastLoginAt: String
    var statusAt: String
}

struct Notice: Decodable {
    var message: String
    var riview: String
    var app: String
    var sms: String
    var email: String
    var followDiscount: String
    var followStory: String
    var wish: String
    var work: String
    
}

struct ShippingAddresses: Decodable {
    var addressIndex: Int
    var name: String?
    var tel: String?
    var zipcode: String?
    var address: String?
    var detailAddress: String?
    var number: Int
}
*/
