//
//  Response.swift
//  BDD
//
//  Created by Leonardo Reis on 03/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let symbolsReturned: Int
    let symbolsRequested: Int?
    let base: String?
    let data: [Stock?]
    enum CodingKeys: String, CodingKey {
        case symbolsRequested = "symbols_requested"
        case symbolsReturned = "symbols_returned"
        case base, data
    }
}
