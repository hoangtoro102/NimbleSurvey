//
//  DetailWireframe.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/7/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class DetailWireframe {
    var rootWireframe: RootWireframe?
    
    func presentDetailInterface(survey: Survey) {
        let viewController = rootWireframe?.viewControllerFromStoryboardWithIdentifier(String(describing: DetailViewController.self)) as! DetailViewController
        viewController.survey = survey
        rootWireframe?.pushViewController(viewController)
    }
}
