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
struct StockResponse: Codable {
    let c: Double
    let h: Double
    let l: Double
    let o: Double
    let pc: Double
    let t: Double
}
