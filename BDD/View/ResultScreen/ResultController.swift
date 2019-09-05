//
//  ResultController.swift
//  BDD
//
//  Created by Vitor Demenighi on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var result: ConvertResultViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let convertPrice = result?.stockConvertPrice {
            resultLabel.text = String(convertPrice)
        }
    }
  
}
