//
//  ViewController.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stockFiekd: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stockFiekd.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        stockFiekd.layer.borderWidth = 1
        stockFiekd.layer.cornerRadius = 8
        stockFiekd.attributedPlaceholder = NSAttributedString(string: "Ex. APPL", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        quantityField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        quantityField.layer.borderWidth = 1
        quantityField.layer.cornerRadius = 8
        quantityField.attributedPlaceholder = NSAttributedString(string: "1", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
