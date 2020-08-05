//
//  MainWireframe.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
class MainWireframe: NSObject {
    var rootWireframe: RootWireframe?
//    var homeWireframe: HomeWireframe?
    var presenter: MainPresenter?
    var mainViewController: MainViewController?
    
    func presentMainInterfaceFromWindow(_ window: UIWindow) {
        let viewController = rootWireframe?.viewControllerFromStoryboardWithIdentifier(String(describing: MainViewController.self)) as! MainViewController
        presenter?.viewInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentHomeInterface() {
        
    }
}
