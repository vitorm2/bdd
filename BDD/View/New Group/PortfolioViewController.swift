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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Portfolio"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PortfolioTableViewCell else {
            let cell = UITableViewCell.init()
            return cell
        }
        cell.logoImageView.image = UIImage.init(named: "apple")
        cell.graphImageView.image = UIImage.init(named: "line")
        cell.dailyLabel.text = "+ 1.0%"
        cell.convertedStockPriceLabel.text = "400.0"
        cell.stockPriceLabel.text = "100.0"
        cell.stockCurrencyFlagImageView.image = UIImage.init(named: "dolar")
        cell.requestedCurrencyFlagImageView.image = UIImage.init(named: "real")
        return cell
    }
}
