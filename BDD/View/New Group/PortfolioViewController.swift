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
    }
    
    func formatValueTwoDecimalPoints(value: Double) -> String {
        return String(format: "%.2f", value)
    }

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
