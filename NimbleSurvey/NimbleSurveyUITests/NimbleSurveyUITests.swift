//
//  NimbleSurveyUITests.swift
//  NimbleSurveyUITests
//
//  Created by HoangNguyen on 8/4/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest

class NimbleSurveyUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testAuthenticationExistance() {
        let app = XCUIApplication()
        let imageView = app.images.firstMatch
        XCTAssert(imageView.exists)
    }
    
    func testNavigationBarExistance() {
        let app = XCUIApplication()
        let navigationBar = app.navigationBars.firstMatch
        
        XCTAssertFalse(navigationBar.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: navigationBar, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(navigationBar.exists)
        XCTAssertTrue(navigationBar.staticTexts["SURVEYS"].exists)
        XCTAssertTrue(navigationBar.buttons["btnRefresh"].exists)
    }
    
    func testCollectionViewExistance() {
        let app = XCUIApplication()
        let collectionView = app.collectionViews.firstMatch
        
        XCTAssertFalse(collectionView.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: collectionView, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(collectionView.exists)
    }
    
    func testRefreshInteractions() {
        let app = XCUIApplication()
        let collectionView = app.collectionViews.firstMatch
        let navigationBar = app.navigationBars.firstMatch
        
        let btnTakeSurvey = collectionView.cells.element(boundBy: 0).buttons["btnTakeSurvey"]
        XCTAssertFalse(btnTakeSurvey.exists)
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: btnTakeSurvey, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
        
        let spinner = app.activityIndicators.element(boundBy: 0)
        XCTAssertFalse(spinner.exists)
        let btnRefresh = navigationBar.buttons["btnRefresh"]
        btnRefresh.tap()
        XCTAssertFalse(collectionView.cells.element(boundBy: 0).buttons["btnTakeSurvey"].exists)
        XCTAssertTrue(spinner.exists)
    }
    
    func testTakeSurveyInteractions() {
        let app = XCUIApplication()
        let collectionView = app.collectionViews.firstMatch
        let btnTakeSurvey = collectionView.cells.element(boundBy: 0).buttons["btnTakeSurvey"]
        
        XCTAssertFalse(btnTakeSurvey.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: btnTakeSurvey, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(btnTakeSurvey.exists)
        
        let lbEmail = app.staticTexts.element(matching: .any, identifier: "lbEmail")
        XCTAssertFalse(lbEmail.exists)
        btnTakeSurvey.tap()
        expectation(for: exists, evaluatedWith: lbEmail, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(lbEmail.exists)
        XCTAssertFalse(collectionView.exists)
        
        let navigationBar = app.navigationBars.firstMatch
        let backButton = navigationBar.buttons["SURVEYS"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        XCTAssertTrue(collectionView.exists)
    }
}
