//
//  HomeViewInterface.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
protocol HomeViewInterface {
    func showSpinner()
    func hideSpinner()
    func showNoResults()
    func updateWithResult(_ newSurveys: [Survey])
    func showErrorState(_ state: EmptyViewState)
}
