//
//  AppDependencies.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/4/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    let mainWireframe = MainWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        mainWireframe.presentMainInterfaceFromWindow(window)
        mainWireframe.presenter?.prepareAuth()
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireframe()
        
        // MARK: Main Module
        let mainPresenter = MainPresenter()
                
        mainWireframe.presenter = mainPresenter
        mainWireframe.rootWireframe = rootWireframe
        
        mainPresenter.wireframe = mainWireframe
        
        // MARK: Auth Module
        let authInteractor = AuthInteractor()
        
        authInteractor.output = mainPresenter
        
        mainPresenter.authInteractor = authInteractor
        
        // MARK: Home Module
        let homeWireframe = HomeWireframe()
        let homePresenter = HomePresenter()
        let homeInteractor = HomeInteractor()
        
        homeInteractor.output = homePresenter
        
        homePresenter.interactor = homeInteractor
        homePresenter.wireframe = homeWireframe
        
        homeWireframe.rootWireframe = rootWireframe
        homeWireframe.presenter = homePresenter
        mainWireframe.homeWireframe = homeWireframe
        
        // MARK: Detail Module
        let detailWireframe = DetailWireframe()
        
        detailWireframe.rootWireframe = rootWireframe
        homeWireframe.detailWireframe = detailWireframe
    }
}

