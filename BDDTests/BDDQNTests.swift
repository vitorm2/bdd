//
//  BDDQNTests.swift
//  BDDTests
//
//  Created by Leonardo Reis on 04/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
//

import Quick
import Nimble
@testable import BDD

class ApiOfContentsSpec: QuickSpec {
    var mockAPI: MockAPI!
    var delegateSpy: NewConsultViewControllerDelegateSpy!
    var viewDelegateSpy: NewConsultViewDelegateSpy!
    
    override func spec() {
        
        let app = make()
        
        // GIVEN
        describe("O usuário insere o simbolo da ação quer pesquisar") {
            app.stockField.text = "AAPL"
            
            describe("seleciona a moeda que deseja converter") {
                
                app.mySelectedCurrency?.currency = "BRL"
                
                describe("informa a quantidade de ações que possui") {
                    
                    app.quantityField.text = "2"
                    
                    // WHEN
                    context("clica no botão pesquisar e a busca é efetuada com sucesso") {
                        mockAPI.expectedResult = .success
                        app.researchButtonAction(UIButton())
                        
                        // THEN
                        it ("o aplicativo informa o resultado da conversão de acordo com a quantidade") {
                            expect(self.delegateSpy.result?.stockTotalPrice).toEventually(beCloseTo(1554.3344, within: 0.1), timeout: 1)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper
    
    func make() -> NewConsultViewController {
        mockAPI = MockAPI()
        delegateSpy = NewConsultViewControllerDelegateSpy()
        viewDelegateSpy = NewConsultViewDelegateSpy()
        
        let presenter = NewConsultPresenter(service: mockAPI)
        let bundle = Bundle(for: NewConsultViewController.self)
        let sb = UIStoryboard(name: "NewConsult", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        
        guard let sut = initialVC as? NewConsultViewController else {
            return NewConsultViewController()
        }
        
        sut.delegate = delegateSpy
        presenter.attachView(viewDelegateSpy)
        sut.presenter = presenter
        sut.loadViewIfNeeded()
        
        return sut
    }
}

class NewConsultViewDelegateSpy: UIView, NewConsultView {
    var showResultScreenCalled = false
    var showErrorCalled = false
    
    func showResultScreen(result: ConvertResultViewData) {
        showResultScreenCalled = true
    }
    
    func showError() {
        showErrorCalled = true
    }
}

class NewConsultViewControllerDelegateSpy: NewConsultViewControllerDelegate {
    var result: ConvertResultViewData?
    
    func startSelectCurrencyController(_ controller: NewConsultViewController) {
        return
    }
    
    func startResultController(_ controller: NewConsultViewController, result: ConvertResultViewData) {
        self.result = result
    }
}
