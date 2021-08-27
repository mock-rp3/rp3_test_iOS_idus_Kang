//
//  RelatedGoodsResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Foundation

struct RelatedGoodsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RelatedGoodsResult]?
}

// MARK: - Result
struct RelatedGoodsResult: Codable {
    let workIndex, reviewGrade, reviewCount: Int
    let authorName: String
    let reviewContent: String?
    let title: String
    let image: String
}
