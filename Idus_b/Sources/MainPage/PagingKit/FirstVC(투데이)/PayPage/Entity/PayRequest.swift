//
//  PayRequest.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import Foundation

// MARK: - Welcome
struct PayRequest: Codable {
    let userIndex, addressIndex, totalPrice: Int
    let orderDetails: [OrderDetail]
}

// MARK: - OrderDetail
struct OrderDetail: Codable {
    let workIndex, workNumber, workPrice, workfee: Int
    let requests: String
    let detailOptionList: [DetailOptionList]
}

// MARK: - DetailOptionList
struct DetailOptionList: Codable {
    let workOptionIndex, workOptionDetailIndex: Int
}
