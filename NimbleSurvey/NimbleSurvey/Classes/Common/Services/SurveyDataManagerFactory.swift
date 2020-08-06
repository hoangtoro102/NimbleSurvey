//
//  SurveyDataManagerFactory.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

enum SurveyDataManagerFactory: PagedDataManagerFactory {
    case search(query: String)
    case collection

    var dataManager: PagedDataManager {
        return PagedDataManager(with: self)
    }

    func initialCursor() -> SurveyPagedRequest.Cursor {
        let perPage = 5
        return GetCollectionSurveysRequest.cursor(with: 0, perPage: perPage)
    }

    func request(with cursor: SurveyPagedRequest.Cursor) -> SurveyPagedRequest {
        return GetCollectionSurveysRequest(for: cursor.page, perPage: cursor.perPage)
    }
}
