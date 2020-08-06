//
//  MockHomeInteractorOutput.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import XCTest
@testable import NimbleSurvey
class MockHomeInteractorOutput: HomeInteractorOutput {
    var items = [Survey]()
    var isFetching = false
    var state: EmptyViewState?
    var asyncExpectation: XCTestExpectation?
    
    func willStartFetching() {
        isFetching = true
    }
    
    func finishFetchingWithData(_ surveys: [Survey]) {
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate (SpyOutput) was not setup correctly. Missing XCTExpectation reference")
            return
        }
        self.items = surveys
        expectation.fulfill()
    }
    
    func errorWhileFetching(_ state: EmptyViewState) {
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate (SpyOutput) was not setup correctly. Missing XCTExpectation reference")
            return
        }
        self.state = state
        expectation.fulfill()
    }
}
