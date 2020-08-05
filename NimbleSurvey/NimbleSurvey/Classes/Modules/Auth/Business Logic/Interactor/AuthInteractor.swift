//
//  AuthInteractor.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class AuthInteractor {
    var output: AuthInteractorOutput?
    let manager = AuthManager()
}
extension AuthInteractor: AuthInteractorInput {
    func authentication() {
        manager.authenticate()
        manager.delegate = self
    }
}
extension AuthInteractor: AuthManagerDelegate {
    func didReceiveAccessToken(_ accessToken: String) {
        Configuration.accessToken = accessToken
        output?.authSuccess()
    }
    
    func authenticationFailed(error: Error) {
        output?.authFailed(error: error)
    }
}
