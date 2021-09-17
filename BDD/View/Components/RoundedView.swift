//
//  RoundedView.swift
//  BDD
//
//  Created by Fabricio Pujol on 04/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundedView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
