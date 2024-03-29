//
//  HomeInteractorTest.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
@testable import NimbleSurvey
class HomeInteractorTest: XCTestCase {
    var authInteractor: AuthInteractor?
    var authMockOutput: MockAuthInteractorOutput?
    var interactor: HomeInteractor?
    var mockOutput: MockHomeInteractorOutput?
    
    override func setUp() {
        interactor = HomeInteractor()
        mockOutput = MockHomeInteractorOutput()
        interactor?.output = mockOutput
        
        authInteractor = AuthInteractor()
        authMockOutput = MockAuthInteractorOutput()
        authInteractor?.output = authMockOutput
        
        super.setUp()
    }
    
    override func tearDown() {
        interactor = nil
        mockOutput = nil
        authInteractor = nil
        authMockOutput = nil
        super.tearDown()
    }
    
    func testFetchDataAfterLaunchingSuccess() {
        // Given
        let asyncExpectation = expectation(description: "AuthenticationCompletion")
        authMockOutput?.asyncExpectation = asyncExpectation
        // When
        authInteractor?.authentication()
        waitForExpectations(timeout: 3) { (error) in
            // Then
            XCTAssertTrue(self.authMockOutput!.isSuccess)
            XCTAssertNil(self.authMockOutput?.error)
            XCTAssertNotNil(Configuration.accessToken)
            if let _ = self.authMockOutput?.isSuccess {
                self.testFetchingDataForHomeModule()
            }
        }
    }
    
    func testFetchingDataForHomeModule() {
        // Given
        let fetchAsyncExpectation = expectation(description: "HomeFetchDataCompletion")
        mockOutput?.asyncExpectation = fetchAsyncExpectation
        // When
        interactor?.fetchNextPage()
        XCTAssertTrue(self.mockOutput!.isFetching)
        waitForExpectations(timeout: 3) { (error) in
            // Then
            XCTAssertEqual(self.mockOutput!.items.count, 5)
            XCTAssertNil(self.mockOutput?.state)
            
            let result = self.mockOutput?.items.first
            XCTAssertNotNil(result?.title)
            XCTAssertNotNil(result?.description)
            XCTAssertNotNil(result?.coverImageUrl)
        }
    }
}
