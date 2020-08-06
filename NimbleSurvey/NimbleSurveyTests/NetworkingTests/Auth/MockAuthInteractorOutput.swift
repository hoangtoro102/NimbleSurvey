//
//  MockAuthInteractorOutput.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import XCTest
@testable import NimbleSurvey
class MockAuthInteractorOutput: AuthInteractorOutput {
    var isSuccess = false
    var error: Error?
    var asyncExpectation: XCTestExpectation?
    
    func authSuccess(_ accessToken: String) {
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate (SpyOutput) was not setup correctly. Missing XCTExpectation reference")
            return
        }
        isSuccess = !accessToken.isEmpty
        expectation.fulfill()
    }
    
    func authFailed(error: Error) {
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate (SpyOutput) was not setup correctly. Missing XCTExpectation reference")
            return
        }
        self.error = error
        expectation.fulfill()
    }
}
