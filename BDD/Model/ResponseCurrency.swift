//
//  ResponseCurrency.swift
//  BDD
//
//  Created by Vitor Demenighi on 04/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

// MARK: - ResponseCurrency
struct ResponseCurrency: Codable {
    let symbolsReturned: Int?
    let base: String?
    let data: Currency?
    enum CodingKeys: String, CodingKey {
        case symbolsReturned = "symbols_returned"
        case base, data
    }
}
