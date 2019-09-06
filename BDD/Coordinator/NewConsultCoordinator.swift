//
//  NewConsultCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all
import Foundation

import UIKit

class NewConsultCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    private var presenter: UINavigationController
    private var selectCurrencyCoordinator: SelectCurrencyCoordinator?
    private var resultCoordinator: ResultCoordinator?
    private var newConsultViewController: NewConsultViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }
    func start() {
        if let mainVC = UIStoryboard(name: "NewConsult", bundle: nil).instantiateViewController(withIdentifier: "NewConsult")
            as? NewConsultViewController {
            
            mainVC.delegate = self
//            mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            mainVC.tabBarItem = UITabBarItem.init(title: " ", image: UIImage.init(named: "consult-off"), tag: 0)
            mainVC.tabBarItem.imageInsets.top = -25
            mainVC.tabBarItem.selectedImage = UIImage.init(named: "consult")
//            mainVC.tabBarItem.image = UIImage.init(named: "consult")
            presenter.setViewControllers([mainVC], animated: true)
        }
    }
    
    func back(selectedCurrency: CurrencyCellViewData){
        if let mainVC =  presenter.viewControllers.first as? NewConsultViewController{
            
            
            
            mainVC.mySelectedCurrency = selectedCurrency // Adiciona a moeda selecionada na variavel da tela anterior
            mainVC.selectedCurrenciesCollection.reloadData() // Atualiza a collectionView
            presenter.popViewController(animated: true)
            
            
        }
    }
}

extension NewConsultCoordinator: NewConsultViewControllerDelegate {
    
    func startSelectCurrencyController(_ controller: NewConsultViewController) {
        
        let selectCurrencyCoordinator = SelectCurrencyCoordinator(presenter: presenter)
        self.selectCurrencyCoordinator = selectCurrencyCoordinator
        selectCurrencyCoordinator.start()
    }
    
    
    func startResultController(_ controller: NewConsultViewController, result: ConvertResultViewData) {
        
        let resultCoordinator = ResultCoordinator(presenter: presenter)
        self.resultCoordinator = resultCoordinator
        resultCoordinator.startResult(result: result) // Passa result pra resultCortinator
    }
    
    
    
}

protocol NewConsultViewControllerDelegate: class {
    func startSelectCurrencyController(_ controller: NewConsultViewController)
    func startResultController(_ controller: NewConsultViewController, result: ConvertResultViewData)
}
