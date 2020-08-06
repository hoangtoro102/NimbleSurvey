//
//  HomeInteractor.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class HomeInteractor: NSObject {
    var output: HomeInteractorOutput?

    private let editorialDataManager = SurveyDataManagerFactory.collection.dataManager

    var dataManager: PagedDataManager {
        didSet {
            oldValue.cancelFetch()
            dataManager.delegate = self
        }
    }

    // MARK: - Lifetime

    override init() {
        self.dataManager = editorialDataManager
        super.init()
        dataManager.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeInteractor: HomeInteractorInput {
    func dataSourceReset() {
        dataManager.reset()
    }
    
    func fetchNextPage() {
        dataManager.fetchNextPage()
    }
}
extension HomeInteractor: PagedDataManagerDelegate {
    func dataManagerWillStartFetching(_ dataManager: PagedDataManager) {
        if dataManager.items.count == 0 {
            output?.willStartFetching()
        }
    }
    
    func dataManager(_ dataManager: PagedDataManager, didFetch items: [Survey]) {
        output?.finishFetchingWithData(items)
    }
    
    func dataManager(_ dataManager: PagedDataManager, fetchDidFailWithError error: Error) {
        let state: EmptyViewState = (error as NSError).isNoInternetConnectionError() ? .noInternetConnection : .serverError

        output?.errorWhileFetching(state)
    }
}
