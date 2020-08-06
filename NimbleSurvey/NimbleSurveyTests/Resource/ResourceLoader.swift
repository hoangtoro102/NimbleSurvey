//
//  ResourceLoader.swift
//  NimbleSurveyTests
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
@testable import NimbleSurvey

class ResourceLoader {
    
    enum SurveyResource: String {
        case fetchResource
    }
    
    static func loadSurveys(resource: SurveyResource) throws -> [Survey] {
        return try loadResource(resource: resource)
    }
    
    static func loadResource<T: Decodable>(resource: SurveyResource) throws -> T {
        
        let bundle = Bundle(for: ResourceLoader.self)
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let fetchNews = try decoder.decode(T.self, from: data)
        
        return fetchNews
    }
}
