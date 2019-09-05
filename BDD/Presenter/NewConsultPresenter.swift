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
//    var currency: CurrencyViewData?
//    var stock: Stock?

    //Connect to service (API connectors)

    func attachView(_ view: NewConsultView) {
        self.consultView = view
    }

    func getConvertStockCurrency(stockCode: String, convertCurrency: String, quantity: Int) {
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
                let result = Double(stockPrice)! * Double(convertCurrencyValue)!

                let convertResult = ConvertResultViewData(stockOriginalPrice: Double(stockPrice)!,
                                    stockConvertPrice: result, originalCurrency: stockOriginalCurrency, convertCurrency: convertCurrency)

                self.consultView?.showResultScreen(result: convertResult)
            }
        }
    }
}

struct ConvertResultViewData {
    let stockOriginalPrice: Double
    let stockConvertPrice: Double
    let originalCurrency: String
    let convertCurrency: String
}
