//
//  ResultController.swift
//  BDD
//
//  Created by Vitor Demenighi on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all

import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var stockTagLabel: UILabel!
    @IBOutlet weak var stockNameLabell: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockPriceTopLabel: UILabel!
    
    @IBOutlet weak var convertCurrencyLabel: UILabel!
    
    @IBOutlet weak var originalFlag: UIImageView!
    @IBOutlet weak var quantityOriginalCurrency: UILabel!
    @IBOutlet weak var resultOriginalCurrency: UILabel!
    
    @IBOutlet weak var convertFlag: UIImageView!
    @IBOutlet weak var quantityConverCurrenct: UILabel!
    @IBOutlet weak var resultConvertCurrency: UILabel!
    
    @IBOutlet weak var changePercentLabel: UILabel!
    @IBOutlet weak var marketCap: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    
    var result: ConvertResultViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        if let result = result {
            stockTagLabel.text = result.stockTag
            stockNameLabell.text = result.stockName
            stockPriceLabel.text = String(result.stockOriginalPrice)
            stockPriceTopLabel.text = String(result.stockOriginalPrice)
            convertCurrencyLabel.text = formatValueTwoDecimalPoints(value: result.stockConvertPrice)
            
            convertFlag.image = UIImage(named: result.convertCurrency)
            quantityConverCurrenct.text = "Quantity: " + String(Int(result.quantity))
            resultConvertCurrency.text = formatValueTwoDecimalPoints(value: result.stockConvertPrice * result.quantity)
            
            originalFlag.image = UIImage(named: result.originalCurrency)
            quantityOriginalCurrency.text = "Quantity: " + String(Int(result.quantity))
            resultOriginalCurrency.text = formatValueTwoDecimalPoints(value: result.stockOriginalPrice * result.quantity)
            
            if Double(result.changePercent)! > 0 {
                changePercentLabel.text = "+ " + formatValueTwoDecimalPoints(value: Double(result.changePercent)!) + " %"
                
                changePercentLabel.textColor = UIColor(red: 0.31, green: 0.83, blue: 0.7, alpha: 1)
            } else {
                changePercentLabel.text = formatValueTwoDecimalPoints(value: Double(result.changePercent)!) + " %"
                changePercentLabel.textColor = UIColor(red: 1, green: 0.48, blue: 0.48, alpha: 1)
            }
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMMM"
            
            if let date = dateFormatterGet.date(from: result.lastTradeTime) {
                dateLabel.text = dateFormatterPrint.string(from: date).uppercased()
            }
            
            companyLogo.image = UIImage.init(named: result.stockTag)
            
            marketCap.text = result.marketCap.prefix(3) + " BI"
        }
    }
  
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func formatValueTwoDecimalPoints(value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    @IBAction func saveToPortfolioAction(_ sender: UIButton) {
        let defaults = UserDefaults()
        
        defaults.removeObject(forKey: "stock")
        
        defaults.set(result?.stockTag, forKey: "stock")
        defaults.set(result?.quantity, forKey: "quantity")
        defaults.set(result?.convertCurrency, forKey: "currency")
        
        sender.isSelected = true
    }
    
    

}
