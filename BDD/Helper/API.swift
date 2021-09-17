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

enum Endpoint {
    case stockValue(String)
    case stockInfo(String)
    case forex(String)

    var path: String {
        switch self {
        case  .stockValue(let symbol):
            return finnhubBaseURL  + "/quote?symbol=" + symbol + token
        case .stockInfo(let symbol):
            return polygonBaseURL + "v3/reference/tickers?ticker=\(symbol)&active=true&sort=ticker&order=asc&limit=1" + apiKey
        case .forex(let currency):
            return finnhubBaseURL  + "/forex/rates?base=" + currency + token
        }
    }
    
    private var polygonBaseURL: String {
        return "https://api.polygon.io/"
    }

    private var finnhubBaseURL: String {
        return "https://finnhub.io/api/v1"
    }

    private var token: String {
        return "&token=sandbox_c51uh9aad3i9nnbv2et0"
    }

    private var apiKey: String {
        return "&apiKey=tgCj9L4t_tvp9pvDmLNWvtawNQmR5FTy"
    }
}

struct APIParameter {
    let endpoint: Endpoint
    let method: HTTPMethod
}

enum Result<T> {
    case success(T)
    case failure(Error?)
}

class AlamoFireAPI: APIProcotol {
    func makeRequest<T: Decodable>(parameters: APIParameter, completion: @escaping (Result<T>) -> Void) {
        AF.request(parameters.endpoint.path, method: parameters.method).response { response in
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
