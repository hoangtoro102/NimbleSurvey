//
//  AuthenRequest.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

class AuthenRequest: SurveyRequest {

    var authResponse: AuthResponse?
    
    // MARK: - Prepare the request
    
    override var method: NetworkRequest.Method {
        return .post
    }

    override var endpoint: String {
        return "/oauth/token"
    }

    override func prepareParameters() -> [String: Any]? {
        var parameters = super.prepareParameters() ?? [String: Any]()
        parameters["grant_type"] = "password"
        parameters["username"] = "carlos@nimbl3.com"
        parameters["password"] = "antikera"

        return parameters
    }

    // MARK: - Process the response

    override func processResponseData(_ data: Data?) {
        if let authResponse = authResponseFromResponseData(data) {
            self.authResponse = authResponse
            completeOperation()
        }
        super.processResponseData(data)
    }

    func authResponseFromResponseData(_ data: Data?) -> AuthResponse? {
        guard let data = data else { return nil }

        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            self.error = error
            return nil
        }
    }
}
