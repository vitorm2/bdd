//
//  ViewController.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all

import UIKit

class NewConsultViewController: UIViewController {

    @IBOutlet weak var stockField: UITextField! {
        didSet { stockField?.addDoneToolbar() }
    }
    @IBOutlet weak var quantityField: UITextField! {
        didSet { quantityField?.addDoneToolbar() }
    }
    
    @IBOutlet weak var researchButton: UIButton!
    
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectedCurrenciesCollection: UICollectionView!
    var presenter: NewConsultPresenter?
    weak var delegate: NewConsultViewControllerDelegate?
    
    var mySelectedCurrency: CurrencyCellViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter = NewConsultPresenter()
        self.presenter?.attachView(self)
        //Set textinput layout
        setTextFieldsLayout()
        //NavigationController
        self.navigationItem.title = "Consult"
        //CollectionView
        self.selectedCurrenciesCollection.delegate = self
        self.selectedCurrenciesCollection.dataSource = self
        
        stockField.delegate = self
        quantityField.delegate = self
    }
    @IBAction func researchButtonAction(_ sender: Any) {
        progressIndicator.isHidden = false
        
        self.presenter?.getConvertStockCurrency(stockCode: stockField.text ?? "AAPL", convertCurrency: mySelectedCurrency?.currency ?? "BRL", quantity: Double(quantityField.text!)!)
    }
    
    
    func setTextFieldsLayout() {
        stockField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        stockField.layer.borderWidth = 1
        stockField.layer.cornerRadius = 8
        stockField.attributedPlaceholder = NSAttributedString(string: "Ex. AAPL", attributes:
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.8392156863, green: 0.8509803922, blue: 0.8941176471, alpha: 0.3))])
        
        
        quantityField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        quantityField.layer.borderWidth = 1
        quantityField.layer.cornerRadius = 8
    }
    
    func setButtonLayout(){
        researchButton.layer.cornerRadius = 8.0
        researchButton.layer.masksToBounds = false
        
        guard let quantity = quantityField.text else { return }
        
        guard let stock = stockField.text else { return }
        
        // VERIFICA SE DEVE PINTAR O BOTAO
        if !quantity.isEmpty && !stock.isEmpty && mySelectedCurrency != nil {
            
            
            let colorTop =  UIColor(red: 0.31, green: 0.83, blue: 0.7, alpha: 1).cgColor
            let colorBottom = UIColor(red: 0.4, green: 0.91, blue: 0.63, alpha: 1).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
            gradientLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = researchButton.bounds
            gradientLayer.cornerRadius = 8.0
            
            if researchButton.layer.sublayers?.count == 1 {
                researchButton.layer.insertSublayer(gradientLayer, at:0)
            }
        } else {
            if researchButton.layer.sublayers?.count == 2 {
                researchButton.layer.sublayers?.remove(at: 0)// Tira o gradiente
            }
            researchButton.layer.backgroundColor = UIColor(red: 0.74, green: 0.74, blue: 0.78, alpha: 0.32).cgColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setButtonLayout()
    }
}


extension NewConsultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let _ = mySelectedCurrency { // Cria a section moeda selecionada
                return 1
            } else { return 0 }
        case 1:
            return 1
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell",
                                                                for: indexPath) as?  CurrencyCell else { fatalError() }
            
            if let seletectCurrency = mySelectedCurrency {
                cell.currencyLabel.text = seletectCurrency.currency
                
                // *** FAZER METODO PARA PEGAR A IMAGEM CERTA
                
                cell.layer.cornerRadius = 8.0
                cell.layer.masksToBounds = false
                
                let colorTop =  UIColor(red: 0.53, green: 0.46, blue: 0.98, alpha: 1).cgColor
                let colorBottom = UIColor(red: 0.67, green: 0.48, blue: 1, alpha: 1).cgColor
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [colorTop, colorBottom]
                gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
                gradientLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
                gradientLayer.locations = [0.0, 1.0]
                gradientLayer.frame = cell.bounds
                gradientLayer.cornerRadius = 8.0
                cell.layer.insertSublayer(gradientLayer, at:0)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCurrencyCell",
                                                                for: indexPath) as? EmptyCurrencyCollectionViewCell
                else {
                    fatalError()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Vai para tela selecao de moedas
        self.delegate?.startSelectCurrencyController(self)
    }
}

extension UITextField {
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any,
        action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Ok", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

extension NewConsultViewController: NewConsultView {
    
    func showResultScreen(result: ConvertResultViewData){
        progressIndicator.isHidden = true
        // vai pra tela de resultados
        self.delegate?.startResultController(self, result: result)
    }
}


extension NewConsultViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setButtonLayout()
    }
}



