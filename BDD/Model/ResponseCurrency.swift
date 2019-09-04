//
//  ResponseCurrency.swift
//  BDD
//
//  Created by Vitor Demenighi on 04/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

struct ResponseCurrency: Codable {
    let symbolsReturned: Int?
    let symbolsRequested: Int?
    let base: String?
    let data: [Currency]?
    enum CodingKeys: String, CodingKey {
        case symbolsRequested = "symbols_requested"
        case symbolsReturned = "symbols_returned"
        case base, data
    }
}
