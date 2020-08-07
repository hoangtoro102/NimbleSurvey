//
//  HomeWireframe.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class HomeWireframe {
    var rootWireframe: RootWireframe?
    var detailWireframe: DetailWireframe?
    var presenter: HomePresenter?
    var homeViewController: HomeViewController?
    
    func presentHomeInterface() {
        let viewController = rootWireframe?.viewControllerFromStoryboardWithIdentifier(String(describing: HomeViewController.self)) as! HomeViewController
        viewController.eventHandler = presenter
        presenter?.viewInterface = viewController
        rootWireframe?.pushViewController(viewController)
    }
    
    func presentDetailInterface(_ survey: Survey) {
        detailWireframe?.presentDetailInterface(survey: survey)
    }
}
