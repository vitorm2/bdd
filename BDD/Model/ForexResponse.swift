//
//  ForexResponse.swift
//  BDD
//
//  Created by Vitor Demenighi on 15/09/21.
//  Copyright © 2021 LeonardoBSR. All rights reserved.
//

import Foundation

struct ForexResponse: Codable {
    let base: String
    let quote: [String: Double]
}
