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
    
    let group = DispatchGroup()
    var stockResponse: StockResponse?
    var stockInfoResponse: StockInformationResponse?
    var forexResponse: ForexResponse?
    
    init(service: APIProcotol = AlamoFireAPI()) {
        self.service = service
    }

    func attachView(_ view: NewConsultView) {
        self.consultView = view
    }
    
    func fetchConvercyConvertableValue(stockCode: String, convertCurrency: String, quantity: Double) {
        fetchStockValue(stockCode: stockCode)
        fetchStockInformation(stockCode: stockCode)
        
        group.notify(queue: .main, execute: { [weak self] in
            if let stockCurrency = self?.stockInfoResponse?.results.first?.currency_name  {
                self?.fetchCurrencyValues(stockCurrency: stockCurrency)
                
                self?.group.notify(queue: .main, execute: { [weak self] in
                    guard let forex = self?.forexResponse else {
                        self?.consultView?.showError()
                        return
                    }
                    
                    let currencyValue = self?.getCurrencyValue(from: convertCurrency, forex: forex)
                    
                    if let viewData = self?.createViewData(convertCurrency: convertCurrency, currencyValue: currencyValue, quantity: quantity) {
                        self?.consultView?.showResultScreen(result: viewData)
                    } else {
                        self?.consultView?.showError()
                    }
                })
            }
        })
        
    }
    
    func createViewData(convertCurrency: String, currencyValue: Double?, quantity: Double) -> ConvertResultViewData {
        guard let stockValue = stockResponse?.c, let stockInfo = stockInfoResponse?.results.first, let currencyValue = currencyValue else {
            fatalError()
        }
        
        let result = stockValue * currencyValue
        
        let convertResult = ConvertResultViewData(stockTag: stockInfo.ticker,
                                                  stockName: stockInfo.name,
                                                  stockOriginalPrice: stockValue,
                                                  stockConvertPrice: result,
                                                  stockTotalPrice: result * quantity,
                                                  originalCurrency: stockInfo.currency_name,
                                                  convertCurrency: convertCurrency,
                                                  quantity: quantity,
                                                  marketCap: "",
                                                  changePercent: "0.5",
                                                  lastTradeTime: "")
        
        
        return convertResult
        
    }

    func fetchStockValue(stockCode: String) {
        group.enter()
        let parameters = APIParameter(endpoint: .stockValue(stockCode), method: .get)
        
        service.makeRequest(parameters: parameters) { [weak self] (reponse: Result<StockResponse>) in
            switch reponse {
            case.success(let stock):
                self?.stockResponse = stock
            case.failure:
                self?.consultView?.showError()
            }
            self?.group.leave()
        }
    }
    
    func fetchStockInformation(stockCode: String)  {
        group.enter()
        let parameters = APIParameter(endpoint: .stockInfo(stockCode), method: .get)
        
        service.makeRequest(parameters: parameters) { [weak self] (reponse: Result<StockInformationResponse>) in
            switch reponse {
            case.success(let stockInfo):
                self?.stockInfoResponse = stockInfo
            case.failure:
                self?.consultView?.showError()
            }
            self?.group.leave()
        }
    }
    
    func fetchCurrencyValues(stockCurrency: String) {
        group.enter()
        let parameters = APIParameter(endpoint: .forex(stockCurrency), method: .get)
        self.service.makeRequest(parameters: parameters) { [weak self] (reponse: Result<ForexResponse>) in
            switch reponse {
            case .success(let forex):
                self?.forexResponse = forex
            case.failure:
                print("Failed to get currency values")
            }
            self?.group.leave()
        }
    }
    
    func getCurrencyValue(from symbol: String, forex: ForexResponse) -> Double? {
        guard let currencyValue = forex.quote[symbol] else {
            return nil
        }
        
        return currencyValue
    }
}

struct ConvertResultViewData {
    let stockTag: String
    let stockName: String
    let stockOriginalPrice: Double
    let stockConvertPrice: Double
    let stockTotalPrice: Double
    let originalCurrency: String
    let convertCurrency: String
    let quantity: Double
    let marketCap: String
    let changePercent: String
    let lastTradeTime: String
}
