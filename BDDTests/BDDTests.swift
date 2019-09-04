//
//  BDDTests.swift
//  BDDTests
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Nimble
import Quick


final class GeneratingOrbits: QuickSpec {
    
    override func spec() {
        
        // Scenario 0: Regular investidor want's to consult the stock market
        
        // GIVEN
        describe("The investidor knows his stock's code and what currency he wants to consult") {
            let stockSelected = "APPL"
            let currencySelected = "KES"
            
            var response: Response?
            var stock: Stock?
            var currency: [String : String]?
            
            context("He provides the correct data to the application") {
                if let url = Bundle.main.url(forResource: "response", withExtension: "json") {
                    
                    do {
                        let data = try Data(contentsOf: url)
                        response = try? JSONDecoder().decode(Response.self, from: data)
                    } catch {
                        print("error:\(error)")
                    }
                }
                
                // STOCK LIDA DO JSON
                stock = response?.data?[0]
                
                
                if let url = Bundle.main.url(forResource: "responseCurrency", withExtension: "json") {
                    
                    do {
                        let data = try Data(contentsOf: url)
                        let currencyResponse = try? JSONDecoder().decode(Currency.self, from: data)
                        currency = currencyResponse?.data
                    } catch {
                        print("error:\(error)")
                    }
                }
               
                print("STOCK CURRENCY: ", stock?.currency)
                print("STOCK PRICE: ", stock?.price)

                if let currency = currency {
                    print("PRICE CURRENCY SELECTED", currency[currencySelected])
                }
                
                
                // chama metodo de conversao da moeda
                
                //let result = convertStockPrice(stockPrice: stock?.price, stockCurrency: stock?.currency, currencySelectedPrice: currency[currencySelected])
                
                // retorna o valor
                
                
                it("The application should present the stock's info and it's value converted to the selected currency") {
//                    expect(currency).to(equal(responseStock));
                    
                }
            }
        }

    }

}
