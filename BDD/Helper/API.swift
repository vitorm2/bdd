//
//  API.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import Alamofire

protocol APIProcotol {
    func makeRequest<T: Decodable>(parameters: APIParameter, completion: @escaping (Result<T>) -> Void)
}

enum Endpoint: String {
    case stockValue = "/quote?symbol="
    case forex = "/forex/rates?base="
}

struct APIParameter {
    let endpoint: Endpoint
    let parameter: String
    let method: HTTPMethod
}

extension APIParameter {
    var url: String {
        return "https://finnhub.io/api/v1" + endpoint.rawValue + parameter + token
    }
    
    private var token: String {
        return "&token=sandbox_c5190giad3if5950sibg"
    }
}

enum Result<T> {
    case success(T)
    case failure(Error?)
}

class AlamoFireAPI: APIProcotol {
    func makeRequest<T: Decodable>(parameters: APIParameter, completion: @escaping (Result<T>) -> Void) {
        AF.request(parameters.url, method: parameters.method).response { response in
            switch response.result {
            case .success(let responseData):
                guard let data = responseData else {
                    completion(.failure(response.error))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(response.error))
                    return
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
