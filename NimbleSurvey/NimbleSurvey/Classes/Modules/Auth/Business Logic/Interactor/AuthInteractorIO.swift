//
//  AuthInteractorIO.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
protocol AuthInteractorInput {
    func authentication()
}
protocol AuthInteractorOutput {
    func authSuccess()
    func authFailed()
}
