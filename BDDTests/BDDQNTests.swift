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
    override func spec() {
        // Scenario 1: Regular investidor want's to consult the stock market
        // GIVEN
        describe("The investidor knows his stock's code and what currency he wants to consult") {
            let stockCode: String = "AAPL"
            let currencyCode: [String] = [""]
            // WHEN
            context("He provides the correct data to the application") {
                context("Return data from JSON") {
                    // THEN
                    it ("Testar se está recebendo os dados do input de ações") {
                        expect(stockCode).toNot(beEmpty())
                    }
                    it ("Testar se é String os dados do input de ações") {
                        expect(stockCode).to(beAnInstanceOf(String.self))
                    }
                    it ("Testar se os dados vindos do input de ações estão sem virgula, sem espaço e garantindo minimamente que só tem um codigo") {
                        let pattern: String = #"[^A-z\d\.\-][\\\^\s]?"#
                        let valid = stockCode.range(of: pattern, options: .regularExpression) != nil
                        expect(valid).to(beFalse())
                    }
                    it ("Testar se é um array de string os nomes das moedas selecionadas") {
                        expect(currencyCode).to(beAKindOf([String].self))
                    }
                    it ("Testar se está recebendo os nomes das moedas selecionadas") {
                        expect(currencyCode).toNot(beEmpty())
                    }
                    it ("Testar se está recebendo os nomes das moedas selecionadas") {
                        // fazer for nessa bagaça
                        expect(currencyCode).toNot(beEmpty())
                    }
                    it("The application should present the stock's info and it's value converted to the selected currency AND There should be an option for favoriting that stock") {
                    }
                }
                context("Return data from API") {}
            }
        }
    }
}
