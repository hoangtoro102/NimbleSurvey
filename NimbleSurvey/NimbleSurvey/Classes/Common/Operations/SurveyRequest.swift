//
//  SurveyRequest.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

class SurveyRequest: NetworkRequest {

    enum RequestError: Error {
        case invalidJSONResponse

        var localizedDescription: String {
            switch self {
            case .invalidJSONResponse:
                return "Invalid JSON response."
            }
        }
    }

    private(set) var jsonResponse: Any?

    // MARK: - Prepare the request

    override func prepareURLComponents() -> URLComponents? {
        guard let apiURL = URL(string: "https://nimble-survey-api.herokuapp.com/") else {
            return nil
        }

        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint
        return urlComponents
    }

    // MARK: - Process the response

    override func processResponseData(_ data: Data?) {
        if let error = error {
            completeWithError(error)
            return
        }

        guard let data = data else { return }

        do {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
            processJSONResponse()
        } catch {
            completeWithError(RequestError.invalidJSONResponse)
        }
    }

    func processJSONResponse() {
        if let error = error {
            completeWithError(error)
        } else {
            completeOperation()
        }
    }
}
