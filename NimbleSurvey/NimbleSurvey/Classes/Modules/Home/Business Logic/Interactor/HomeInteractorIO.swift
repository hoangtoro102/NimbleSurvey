//
//  HomeInteractorIO.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
protocol HomeInteractorInput {
    func dataSourceReset()
    func fetchNextPage()
}
protocol HomeInteractorOutput {
    func willStartFetching()
    func finishFetchingWithData(_ surveys: [Survey])
    func errorWhileFetching(_ state: EmptyViewState)
}
