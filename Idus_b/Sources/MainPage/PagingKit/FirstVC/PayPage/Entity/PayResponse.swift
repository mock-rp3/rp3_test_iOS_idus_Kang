//
//  PayResponse.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/27.
//

import Foundation

struct PayResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
