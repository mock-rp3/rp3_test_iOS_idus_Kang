//
//  GoodsPageResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Foundation

// MARK: - GoodsPageResponse
struct GoodsPageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: GoodsPageResponseResult?
}

// MARK: - Result
struct GoodsPageResponseResult: Codable {
    let workInfo: GoodsPageWorkInfo
    let workDiscount: Int
    let categoryName: String
    let orderUserCount: Int
    let review: GoodsPageReview
    let author: GoodsPageAuthor
    let keyword: [GoodsPageKeyword]
    let workImage: [String]
    let options: [GoodsPageOption]
}

// MARK: - Author
struct GoodsPageAuthor: Codable {
    let authorIndex: Int
    let authorName: String
    let authorImage: String
}

// MARK: - Keyword
struct GoodsPageKeyword: Codable {
    let keywordIndex: Int
    let keywordName: String
}

// MARK: - Option
struct GoodsPageOption: Codable {
    let optionIndex: Int
    let optionName: String
    let optionDetailList: [GoodsPageOptionDetailList]
}

// MARK: - OptionDetailList
struct GoodsPageOptionDetailList: Codable {
    let optionDetailIndex: Int
    let optionDetailName: String
    let price: Int
}

// MARK: - Review
struct GoodsPageReview: Codable {
    let reviewCount, reviewGrade: Int
}

// MARK: - WorkInfo
struct GoodsPageWorkInfo: Codable {
    let worksIndex, authorIndex, categoryIndex: Int
    let title: String
    let price, fee: Int
    let start: String
    let quantity: Int
    let content, deliveryContent, option, exchangeRefundContent: String
    let advertisement, createdAt, updatedAt: String
}
