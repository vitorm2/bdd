//
//  MockAPI.swift
//  BDDTests
//
//  Created by Vitor Demenighi on 16/09/21.
//  Copyright © 2021 LeonardoBSR. All rights reserved.
//

import Foundation
@testable import BDD

enum NetworkError: Error {
    case generic
}

enum ExpectedResultType {
    case success
    case failure
}

class MockAPI: APIProcotol {
    
    var expectedResult: ExpectedResultType = .failure
    
    func makeRequest<T>(parameters: APIParameter, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        var fileName = ""
        switch parameters.endpoint {
        case  .forex:
            fileName = "forexResponse"
        case .stockValue:
            fileName = "stockValueResponse"
        case .stockInfo:
            fileName = "stockInfoResponse"
        }
        
        handleResult(fileName: fileName, completion: completion)
    }
    
    
    private func handleResult<T>(fileName: String, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        switch expectedResult {
        case .success:
            guard let dataAsAny = loadJSON(fileName: fileName) else {
                completion(.failure(NetworkError.generic))
                return
            }
            guard let data = try? JSONSerialization.data(withJSONObject: dataAsAny, options: .prettyPrinted) else {
                completion(.failure(NetworkError.generic))
                return
            }
            
            guard let decode = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(NetworkError.generic))
                return
            }
            
            completion(.success(decode))
        case .failure:
            completion(.failure(NetworkError.generic))
        }
    }
    
    
    private func loadJSON(fileName: String) -> Any? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return nil
            }
            return  try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        }
        
        return nil
    }
    
    
}
