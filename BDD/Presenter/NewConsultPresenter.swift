//
//  NewConsultPresenter.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all

import Foundation

class NewConsultPresenter {
    weak var consultView: NewConsultView?
    
    let service: APIProcotol
    
    init(service: APIProcotol = AlamoFireAPI()) {
        self.service = service
    }

    func attachView(_ view: NewConsultView) {
        self.consultView = view
    }

    func getCurrencyValue(stockCode: String, convertCurrency: String, quantity: Double) {
        let parameters = APIParameter(endpoint: .stockValue, parameter: stockCode, method: .get)
        
        service.makeRequest(parameters: parameters) { (reponse: Result<StockResponse>) in
            switch reponse {
            case.success(let stock):
                
                let parameters2 = APIParameter(endpoint: .forex, parameter: "USD", method: .get)
                self.service.makeRequest(parameters: parameters2) { (reponse: Result<ForexResponse>) in
                    
                
                    switch reponse {
                    case .success(let forex):
                        guard let convertCurrencyValue = forex.quote[convertCurrency] else { return }
                        
                        // Conversao
                        let result = stock.c * convertCurrencyValue * quantity
                        
                        let convertResult = ConvertResultViewData(stockTag: stockCode, stockName: "VMO", stockOriginalPrice: stock.c,
                                                                  stockConvertPrice: result, originalCurrency: "USD", convertCurrency: convertCurrency, quantity: quantity, marketCap:
                                                                    "", changePercent: "0.5", lastTradeTime: "")
                        
                        self.consultView?.showResultScreen(result: convertResult)
                    case.failure:
                        print("ERROR")
                    }
                }
            case.failure:
                print("ERROR")
            }
        }
    }
}

struct ConvertResultViewData {
    let stockTag: String
    let stockName: String
    let stockOriginalPrice: Double
    let stockConvertPrice: Double
    let originalCurrency: String
    let convertCurrency: String
    let quantity: Double
    let marketCap: String
    let changePercent: String
    let lastTradeTime: String
}
