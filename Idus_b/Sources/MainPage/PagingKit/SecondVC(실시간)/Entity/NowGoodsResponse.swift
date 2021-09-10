//
//  NowGoodsResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/09/10.
//

import Foundation

// MARK: - NowGoodsResponse
struct NowGoodsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: NowGoodsResult?
}

// MARK: - NowGoodsResult
struct NowGoodsResult: Codable {
    let workList: [NowGoodsWorkList]
    let time: String
}

// MARK: - NowGoodsWorkList
struct NowGoodsWorkList: Codable {
    let workIndex, reviewGrade, reviewCount: Int
    let authorName: String
    let reviewContent: String?
    let title: String
    let image: String
}
