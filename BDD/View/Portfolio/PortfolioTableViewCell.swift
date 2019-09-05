//
//  PortfolioTableViewCell.swift
//  BDD
//
//  Created by Willian Antunes on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stockCodeLabel: UILabel!
    @IBOutlet weak var stockCompanyLabel: UILabel!
    @IBOutlet weak var stockQuantityLabel: UILabel!
    @IBOutlet weak var logoBackgroundView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var graphImageView: UIImageView!
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var stockCurrencyFlagImageView: UIImageView!
    @IBOutlet weak var requestedCurrencyFlagImageView: UIImageView!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var convertedStockPriceLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardBackgroundView.layer.cornerRadius = 6
        logoBackgroundView.layer.cornerRadius = logoBackgroundView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
