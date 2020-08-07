//
//  HomeModuleInterface.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
protocol HomeModuleInterface {
    func dataSourceReset()
    func fetchNextPage()
    
    func showSurveyDetail(_ survey: Survey)
}
