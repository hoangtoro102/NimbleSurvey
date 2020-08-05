//
//  AuthManager.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
protocol AuthManagerDelegate {
    func didReceiveAccessToken(_ accessToken: String)
    func authenticationFailed(error: Error)
}
class AuthManager {
    enum AuthError: Error {
        case isAuthenticating
        case missingAccessToken

        var localizedDescription: String {
            switch self {
            case .isAuthenticating:
                return "The process is already authenticating."
            case .missingAccessToken:
                return "Unable to get access token from response."
            }
        }
    }

    private(set) var error: Error?
    private(set) var isAuthenticating = false
    private lazy var operationQueue = OperationQueue(with: "com.authmanager")
    
    var delegate: AuthManagerDelegate?

    func authenticate() {
        if isAuthenticating {
            authDidComplete(with: nil, error: AuthError.isAuthenticating)
            return
        }

        isAuthenticating = true

        let request = AuthenRequest()
        request.completionBlock = {
            if let error = request.error {
                self.isAuthenticating = false
                self.authDidComplete(with: nil, error: error)
                return
            }

            guard let authResponse = request.authResponse, let accessToken = authResponse.accessToken else {
                self.isAuthenticating = false
                self.authDidComplete(with: nil, error: AuthError.missingAccessToken)
                return
            }

            self.isAuthenticating = false
            self.authDidComplete(with: accessToken, error: nil)
        }

        operationQueue.addOperationWithDependencies(request)
    }

    // MARK: - Private

    private func authDidComplete(with accessToken: String?, error: Error?) {
        self.error = error

        if let error = error {
            delegate?.authenticationFailed(error: error)
        } else {
            if let accessToken = accessToken {
                delegate?.didReceiveAccessToken(accessToken)
            } else {
                delegate?.authenticationFailed(error: AuthError.missingAccessToken)
            }
        }
    }
}
