//
//  API.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case loading
    case success(T)
    case failure(Error?)
}

enum API<T: Codable> {
    case stock(params: String)
    case forex(params: String)
}

extension API {
    private var url: String {
        return "https://api.worldtradingdata.com/api/v1" + path
    }
    private var path: String {
        switch self {
        case .stock(let params): return "/stock?symbol=" + params
        case .forex(let params): return "/forex?base=" + params
        }
    }
    private var params: JSON? {
        switch self {
        default: return nil
        }
    }
    private var method: HTTPMethod {
        switch self {
        case .stock, .forex: return .get
        }
    }
    private var headers: HTTPHeaders {
        var header: HTTPHeaders = []
        //        if let user = User.current, let token = user.sessionToken {
        //            header["X-Parse-Session-Token"] = token
        //        }
        return header
    }
    private var encoding: ParameterEncoding {
        switch self {
        default: return JSONEncoding.default
        }
    }
    @discardableResult
    func request(completion: @escaping ((Result<T>) -> Void)) -> DataRequest {
        var url = self.url
        var params = self.params
        switch self {
        case .stock, .forex:
            url += "&api_token=5BEVZxrLPEHdg65U6rTD83d8Or8cSxUgLKdix9cYiPZO8T3bE3vCeKF6szU8"
            url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            params = nil
        }
        //        print(params)
        return AF.request(url,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers)
            .validate(statusCode: 200...600)
            .responseJSON { response in
                DispatchQueue.main.async {
                    let statusCode = response.response?.statusCode ?? 0
                    switch response.result {
                    case .success(let json) where statusCode >= 200 && statusCode <= 299:
                        guard let result = json as? JSON else {
                            completion(.failure(response.error))
                            return
                        }
                        var objectData: Any = result
                        //print(result)
                        if let object = result["data"] as? JSON {
                            objectData = object
                        } else if let results = result["data"] as? [JSON] {
                            objectData = results
                        } else if let results = result["data"] as? [JSON] {
                            objectData = results
                        }
                        guard let obj = try? T.fromDictionary(objectData) else {
                            completion(.failure(nil))
                            return
                        }
                        completion(.success(obj))
                    case .success:
                        let error = NSError(domain: "error", code: statusCode, userInfo: nil)
                        completion(.failure(response.error ?? error))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
}
