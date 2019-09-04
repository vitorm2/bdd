//
//  Currency.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let symbolsReturned: Int?
    let symbolsRequested: Int?
    let base: String?
    let data: [String : String]?
    enum CodingKeys: String, CodingKey {
        case symbolsRequested = "symbols_requested"
        case symbolsReturned = "symbols_returned"
        case base, data
    }
}
