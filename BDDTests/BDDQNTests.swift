//
//  BDDQNTests.swift
//  BDDTests
//
//  Created by Leonardo Reis on 04/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
//

import Quick
import Nimble

class ApiOfContentsSpec: QuickSpec {
    
    let stockSelected: String = "AAPL"
    let currencySelected: [String] = ["USD"]
    
    var stock: Stock?
    var currency: Currency?
    
    var response: Response?
    var responseCurrency: ResponseCurrency?
    
    override func spec() {
        // Scenario 0: Regular investidor want's to consult the stock market
        // GIVEN
        describe("The investidor knows his stock's code and what currency he wants to consult") {
            // WHEN
            context("He provides the correct data to the application") {
                context("Testing inputs") {
                    it ("Test if you are receiving stock input data") {
                        expect(self.stockSelected).toNot(beEmpty())
                    }
                    it ("Test if String is the input action data") {
                        expect(self.stockSelected).to(beAnInstanceOf(String.self))
                    }
                    it ("Test whether data coming from stock input is comma-free, space-free and minimally guaranteed to have only one code") {
                        let pattern: String = #"[^A-z\d\.\-][\\\^\s]?"#
                        let valid = self.stockSelected.range(of: pattern, options: .regularExpression) != nil
                        expect(valid).to(beFalse())
                    }
                    it ("Test if a string array is the names of selected currencies") {
                        expect(self.currencySelected).to(beAKindOf([String].self))
                    }
                    it ("Test if you are receiving the names of the selected currencies") {
                        expect(self.currencySelected).toNot(beEmpty())
                    }
                    it ("Test if receiving selected currency names are not empty strings") {
                        for currency in self.currencySelected {
                            expect(currency).toNot(beEmpty())
                        }
                    }
                }
                context("Return data from JSON") {
                    if let url = Bundle.main.url(forResource: "response", withExtension: "json") {
                        let data = try? Data(contentsOf: url)
                        if let data = data {
                            response = try? JSONDecoder().decode(Response.self, from: data)
                        }
                        stock = response?.data?[0]
                    }

                    if let url = Bundle.main.url(forResource: "responseCurrency", withExtension: "json") {
                        let data = try? Data(contentsOf: url)
                        if let data = data {
                            responseCurrency = try? JSONDecoder().decode(ResponseCurrency.self, from: data)
                        }
                        currency = responseCurrency?.data
                    }

                    it("The application should present the stock's info and it's value converted to the selected currency AND There should be an option for favoriting that stock") {
                        expect(self.stock).to(beAnInstanceOf(Stock.self))
                        expect(self.currency).to(beAnInstanceOf(Currency.self))
                    }
                }
                context("Return data from API") {
//                    let result = convertStockPrice(stockPrice: stock?.price, stockCurrency: stock?.currency, currencySelectedPrice: currency[currencySelected])
                    
                    // THEN
                    it("The application should present the stock's info and it's value converted to the selected currency AND There should be an option for favoriting that stock") {
                    }
                }
            }
        }
    }
}

func getConvertStockCurrency(stockCode: String, convertCurrency: String, quantity: Double) {
    API<[Stock?]>.stock(params: stockCode).request { [weak self] result in
        
        guard let self = self,
            case .success(let stocks) = result else { return }
        
        guard let stockPrice = stocks[0]?.price else { return }
        guard let stockOriginalCurrency = stocks[0]?.currency else { return }
        
        API<[String: String]>.forex(params: stockOriginalCurrency).request { [weak self] result in
            guard let self = self,
                case .success(let currency) = result else { return }
            
            guard let convertCurrencyValue = currency[convertCurrency] else { return }
            
            // Conversao
            let result = Double(stockPrice)! * Double(convertCurrencyValue)! * quantity
            
            let convertResult = ConvertResultViewData(stockOriginalPrice: Double(stockPrice)!,
                                                      stockConvertPrice: result, originalCurrency: stockOriginalCurrency, convertCurrency: convertCurrency, quantity: quantity)
            
            self.consultView?.showResultScreen(result: convertResult)
        }
    }
}
