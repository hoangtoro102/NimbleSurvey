//
//  ImageCache.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/7/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import UIKit

class ImageCache {

    static let cache: URLCache = {
        let diskPath = "nimble"
        
        if #available(iOS 13.0, *) {
            return URLCache(
                memoryCapacity: ImageCache.memoryCapacity,
                diskCapacity: ImageCache.diskCapacity,
                directory: URL(fileURLWithPath: diskPath, isDirectory: true)
            )
        }
        else {
            #if !targetEnvironment(macCatalyst)
            return URLCache(
                memoryCapacity: ImageCache.memoryCapacity,
                diskCapacity: ImageCache.diskCapacity,
                diskPath: diskPath
            )
            #else
            fatalError()
            #endif
        }
    }()

    static let memoryCapacity: Int = 50.megabytes
    static let diskCapacity: Int = 100.megabytes

}

private extension Int {
    var megabytes: Int { return self * 1024 * 1024 }
}
