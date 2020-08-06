//
//  AuthInteractorTest.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
@testable import NimbleSurvey
class AuthInteractorTest: XCTestCase {
    var interactor: AuthInteractor?
    var mockOutput: MockAuthInteractorOutput?
    
    override func setUp() {
        interactor = AuthInteractor()
        mockOutput = MockAuthInteractorOutput()
        interactor?.output = mockOutput
        super.setUp()
    }
    
    override func tearDown() {
        interactor = nil
        mockOutput = nil
        super.tearDown()
    }
    
    func testAuthenticationSuccess() {
        // Given
        let asyncExpectation = expectation(description: "AuthenticationCompletion")
        mockOutput?.asyncExpectation = asyncExpectation
        // When
        interactor?.authentication()
        waitForExpectations(timeout: 3) { (error) in
            // Then
            XCTAssertTrue(self.mockOutput!.isSuccess)
            XCTAssertNil(self.mockOutput?.error)
        }
    }
}
