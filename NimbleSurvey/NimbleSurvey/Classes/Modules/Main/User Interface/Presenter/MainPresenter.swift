//
//  MainPresenter.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class MainPresenter {
    var wireframe: MainWireframe?
    var viewInterface: MainViewInterface?
    var authInteractor: AuthInteractorInput?
    
    func prepareAuth() {
        authInteractor?.authentication()
    }
}
extension MainPresenter: AuthInteractorOutput {
    func authSuccess() {
        wireframe?.presentHomeInterface()
    }
    
    func authFailed() {
        viewInterface?.showError()
    }
}
