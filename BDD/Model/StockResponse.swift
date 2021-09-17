//
//  Stock.swift
//  BDD
//
//  Created by Leonardo Reis on 03/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
// swiftlint:disable all
// MARK: - Stock
struct StockResponse: Decodable {
    let c: Double
}

// MARK: - StockInformationResponse
struct StockInformationResponse: Codable {
    let results: [ResultInformation]
}

// MARK: - Result
struct ResultInformation: Codable {
    let ticker, name, currency_name: String
}
