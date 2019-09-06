//
//  PortfolioViewController.swift
//  BDD
//
//  Created by Willian Antunes on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var results: [ConvertResultViewData] = []
    
    let presenter: NewConsultPresenter = NewConsultPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Portfolio"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults()
        
        guard let stock = defaults.object(forKey: "stock") as? String else {
            return
        }
        
        guard let currency = defaults.object(forKey: "currency") as? String else {
            return
        }
        
        guard let quantity = defaults.object(forKey: "quantity") as? Double else {
            return
        }
        
        self.getConvertStockCurrency(stockCode: stock, convertCurrency: currency, quantity: quantity)
    }
    
    func getConvertStockCurrency(stockCode: String, convertCurrency: String, quantity: Double) {
        API<[Stock?]>.stock(params: stockCode).request { [weak self] result in
            
            guard let self = self,
                case .success(let stocks) = result else { return }
            
            guard let stockName = stocks[0]?.name else { return }
            guard let stockPrice = stocks[0]?.price else { return }
            guard let stockOriginalCurrency = stocks[0]?.currency else { return }
            guard let marketCap = stocks[0]?.marketCap else { return }
            guard let changePercent = stocks[0]?.changePct else { return }
            guard let lastTradeTime = stocks[0]?.lastTradeTime else { return }
            
            API<[String: String]>.forex(params: stockOriginalCurrency).request { [weak self] result in
                guard let self = self,
                    case .success(let currency) = result else { return }
                
                guard let convertCurrencyValue = currency[convertCurrency] else { return }
                
                // Conversao
                let result = Double(stockPrice)! * Double(convertCurrencyValue)!
                
                let convertResult = ConvertResultViewData(stockTag: stockCode, stockName: stockName, stockOriginalPrice: Double(stockPrice)!,
                                                          stockConvertPrice: result, originalCurrency: stockOriginalCurrency, convertCurrency: convertCurrency, quantity: quantity, marketCap:
                    marketCap, changePercent: changePercent, lastTradeTime: lastTradeTime)
                
                self.results.append(convertResult)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func formatValueTwoDecimalPoints(value: Double) -> String {
        return String(format: "%.2f", value)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PortfolioTableViewCell else {
            let cell = UITableViewCell.init()
            return cell
        }
        cell.graphImageView.image = UIImage.init(named: "line")
        cell.logoImageView.image = UIImage.init(named: results[indexPath.row].stockTag)
        cell.stockCompanyLabel.text = results[indexPath.row].stockName
        cell.stockCodeLabel.text = results[indexPath.row].stockTag
        cell.stockQuantityLabel.text = "Quantity: " + results[indexPath.row].quantity.description
        
        cell.dailyLabel.text = results[indexPath.row].changePercent
        
        if let percentage = Double(results[indexPath.row].changePercent) {
        
            if percentage > 0.0 {
                cell.dailyLabel.textColor = UIColor.green
            } else {
                cell.dailyLabel.textColor = UIColor.red
            }
            
        }
        cell.convertedStockPriceLabel.text = formatValueTwoDecimalPoints(value: results[indexPath.row].stockConvertPrice)
        cell.stockPriceLabel.text = formatValueTwoDecimalPoints(value: results[indexPath.row].stockOriginalPrice)
        
        cell.stockCurrencyFlagImageView.image = UIImage.init(named: results[indexPath.row].originalCurrency)
        cell.requestedCurrencyFlagImageView.image = UIImage.init(named: results[indexPath.row].convertCurrency)
        return cell
    }
}
