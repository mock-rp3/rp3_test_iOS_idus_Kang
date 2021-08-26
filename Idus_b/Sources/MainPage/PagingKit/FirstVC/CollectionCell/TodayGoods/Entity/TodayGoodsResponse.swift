//
//  TodayGoodsResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Foundation

struct TodayGoodsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [TodayGoodsResult]?
}

// MARK: - Result
struct TodayGoodsResult: Codable {
    let workIndex, reviewGrade, reviewCount: Int
    let authorName: String
    let reviewContent: String?
    let title: String
    let image: String
}
