//
//  CodableExtension.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> JSON {
        let data = try JSONEncoder().encode(self.self)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return json as? JSON ?? [:]
    }
}

extension Decodable {
    static func fromDictionary(_ object: Any) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        return try JSONDecoder().decode(self.self, from: data)
    }
}
