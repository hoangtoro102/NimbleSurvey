//
//  ParserTest.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
@testable import NimbleSurvey
class ParserTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testParserMethodTotalCount() throws {
        //Given
        let total = 10
        
        //When
        let surveys = try ResourceLoader.loadSurveys(resource: .fetchResource)
        
        //Then
        XCTAssertEqual(surveys.count, total)
    }
    
    func testParserMethodFirstItemContent() throws {
        //Given
        let givenItem = Survey(title: "Scarlett Bangkok", des: "We'd love ot hear from you!", url: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_")

        //When
        let surveys = try ResourceLoader.loadSurveys(resource: .fetchResource)
        let result = surveys.first

        //Then
        XCTAssertEqual(result?.title, givenItem.title)
        XCTAssertEqual(result?.description, givenItem.description)
        XCTAssertEqual(result?.coverImageUrl, givenItem.coverImageUrl)
    }
}
