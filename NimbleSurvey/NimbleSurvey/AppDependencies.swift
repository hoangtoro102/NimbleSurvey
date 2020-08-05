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
        mainPresenter.authInteractor = authInteractor
        
        // MARK: Home Module
        
        // MARK: Detail Module
    }
}

