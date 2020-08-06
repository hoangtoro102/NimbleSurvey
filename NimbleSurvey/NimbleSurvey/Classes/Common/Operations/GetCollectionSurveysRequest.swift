//
//  GetCollectionSurveysRequest.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class GetCollectionSurveysRequest: SurveyPagedRequest {

    static func cursor(with page: Int = 1, perPage: Int = 10) -> SurveyPagedRequest.Cursor {
        return Cursor(page: page, perPage: perPage, parameters: nil)
    }

    convenience init(for page: Int = 1, perPage: Int = 10) {
        let cursor = GetCollectionSurveysRequest.cursor(with: page, perPage: perPage)
        self.init(with: cursor)
    }

    // MARK: - Prepare the request

    override var endpoint: String {
        return "/surveys.json"
    }

    // MARK: - Process the response

    override func processResponseData(_ data: Data?) {
        if let surveys = surveysFromResponseData(data) {
            self.items = surveys
            completeOperation()
        }
        super.processResponseData(data)
    }

    func surveysFromResponseData(_ data: Data?) -> [Survey]? {
        guard let data = data else { return nil }

        do {
            return try JSONDecoder().decode([Survey].self, from: data)
        } catch {
            self.error = error
            return nil
        }
    }

}
