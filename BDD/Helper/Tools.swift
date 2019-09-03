//
//  Tools.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import UIKit

// MARK: - JSON Struct
public typealias JSON = [String:Any]

public protocol JSONEncodable {
    func convertToDict() -> JSON?
}

public extension Array where Element: JSONEncodable {
    func toJSONArray() -> [JSON]? {
        var jsonArray: [JSON] = []
        for json in self {
            if let json = json.convertToDict() {
                jsonArray.append(json)
            } else {
                return nil
            }
        }
        return jsonArray
    }
}

extension Dictionary {
    func convertToJson() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self,
                                                      options: JSONSerialization.WritingOptions(rawValue: 0))
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            return jsonString
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
