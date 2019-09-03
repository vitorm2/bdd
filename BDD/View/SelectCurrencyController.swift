//
//  SelectCurrency.swift
//  BDD
//
//  Created by Vitor Demenighi on 03/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

struct CurrencyViewData {
    var currency: String = "Dólar - US$"
    var selected: Bool = false
}

class SelectCurrencyController: UIViewController {
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    
    var arrayCurrency: [CurrencyViewData] =
        [CurrencyViewData(), CurrencyViewData(), CurrencyViewData(), CurrencyViewData()]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
    }
}


extension SelectCurrencyController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  !arrayCurrency[indexPath.row].selected {
            arrayCurrency[indexPath.row].selected = true
        } else {
            arrayCurrency[indexPath.row].selected = false
        }
        collectionView.reloadData()
    }
}

extension SelectCurrencyController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCurrency.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCollectionCell", for: indexPath)
            as? CurrencyCell
            guard let cell = myCell else { return myCell! }
            cell.currencyLabel.text = arrayCurrency[indexPath.row].currency
//
//
            if arrayCurrency[indexPath.row].selected {
                if cell.layer.sublayers?.count == 1 {
                    // Adiciona gradiente
                    let colorTop =  UIColor(red: 0.53, green: 0.46, blue: 0.98, alpha: 1).cgColor
                    let colorBottom = UIColor(red: 0.67, green: 0.48, blue: 1, alpha: 1).cgColor
                    let gradientLayer = CAGradientLayer()
                    gradientLayer.colors = [colorTop, colorBottom]
                    gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
                    gradientLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
                    gradientLayer.locations = [0.0, 1.0]
                    gradientLayer.frame = cell.bounds
                    gradientLayer.cornerRadius = 10
                    cell.layer.insertSublayer(gradientLayer, at:0)
                }
                cell.selectedImage.isHidden = false
                cell.layer.shadowOpacity = 0 // Tira sombra
            } else {
                if cell.layer.sublayers?.count == 2 {
                    cell.layer.sublayers?.remove(at: 0)// Tira o gradiente
                }
                cell.backgroundColor = UIColor(red: 0.07, green: 0.08, blue: 0.13, alpha: 1)
                cell.selectedImage.isHidden = true
                cell.layer.cornerRadius = 10.0
                cell.layer.masksToBounds = false
                cell.layer.shadowColor = UIColor(red: 0.63, green: 0.43, blue: 1, alpha: 0.6).cgColor
                cell.layer.shadowRadius = 5
                cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
                cell.layer.shadowOffset = .zero
                cell.layer.shadowOpacity = 0.6
            }
            return cell

    }
}

extension SelectCurrencyController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.28, height: collectionView.frame.height * 0.17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
