//
//  NewConsultPresenter.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

class NewConsultPresenter {
    weak var consultView: NewConsultView?
    var currencyList: [Currency] = []
    var stock: Stock?
    //Connect to service (API connectors)
    
    func attachView(_ view: NewConsultView) {
        self.consultView = view
    }
    func getStock(stockCode: String) {
        //consults stock service for stock with same code
    }
    func convertStockCurrency(stockCode: String, currencies: [Currency], quantity: Double){
        print(stockCode)
        if self.stock != nil {
            //convert stock value for each coin in currency array, and it's value multiplied by quantity
        }
        //update view with results
        self.consultView?.update()     
    }
}
