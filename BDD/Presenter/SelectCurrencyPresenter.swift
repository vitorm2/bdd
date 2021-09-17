//
//  SelectCurrencyPresenter.swift
//  BDD
//
//  Created by Vitor Demenighi on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all

import Foundation

class SelectCurrencyPresenter {
    weak var consultView: NewConsultView?
    var currencies: [CurrencyCellViewData] = []
    
    func attachView(_ view: NewConsultView) {
        self.consultView = view
    }
    
    init() {
        createCurrenciesList()
    }

    func createCurrenciesList() {
        currencies.append(CurrencyCellViewData(currency: "EUR", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "USD", currencyTag: "USD - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "JPY", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "GBP", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "CNY", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "CAD", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "BRL", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "AUD", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "CHF", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "KRW", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "INR", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "RUB", currencyTag: "EUR - $", selected: false))
        currencies.append(CurrencyCellViewData(currency: "ZAR", currencyTag: "EUR - $", selected: false))
    }
    
    func getCUrrenciesList() -> [CurrencyCellViewData] {
        return currencies
    }
}

struct CurrencyCellViewData {
    var currency: String
    var currencyTag: String
    var selected: Bool
}

