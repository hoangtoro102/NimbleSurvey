//
//  PagedDataManager.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

protocol PagedDataManagerFactory {
    func initialCursor() -> SurveyPagedRequest.Cursor
    func request(with cursor: SurveyPagedRequest.Cursor) -> SurveyPagedRequest
}

protocol PagedDataManagerDelegate: AnyObject {
    func dataManagerWillStartFetching(_ dataManager: PagedDataManager)
    func dataManager(_ dataManager: PagedDataManager, didFetch items: [Survey])
    func dataManager(_ dataManager: PagedDataManager, fetchDidFailWithError error: Error)
}

class PagedDataManager {

    enum DataManagerError: Error {
        case dataManagerIsFetching
        case wrongItemsType(Any)

        var localizedDescription: String {
            switch self {
            case .dataManagerIsFetching:
                return "The data source is already fetching."
            case .wrongItemsType(let returnedItems):
                return "The request return the wrong item type. Expecting \([Survey].self), got \(returnedItems.self)."
            }
        }
    }

    private(set) var items = [Survey]()
    private(set) var error: Error?
    private let factory: PagedDataManagerFactory
    private var cursor: SurveyPagedRequest.Cursor
    private(set) var isFetching = false
    private var canFetchMore = true
    private lazy var operationQueue = OperationQueue(with: "com.unsplash.pagedDataManager")

    weak var delegate: PagedDataManagerDelegate?

    init(with factory: PagedDataManagerFactory) {
        self.factory = factory
        self.cursor = factory.initialCursor()
    }

    func reset() {
        operationQueue.cancelAllOperations()
        items.removeAll()
        isFetching = false
        canFetchMore = true
        cursor = factory.initialCursor()
        error = nil
    }

    func fetchNextPage() {
        if isFetching {
            fetchDidComplete(withItems: nil, error: DataManagerError.dataManagerIsFetching)
            return
        }

        if canFetchMore == false {
            fetchDidComplete(withItems: [], error: nil)
            return
        }

        delegate?.dataManagerWillStartFetching(self)

        isFetching = true

        let request = factory.request(with: cursor)
        request.completionBlock = {
            if let error = request.error {
                self.isFetching = false
                self.fetchDidComplete(withItems: nil, error: error)
                return
            }

            guard let items = request.items as? [Survey] else {
                self.isFetching = false
                self.fetchDidComplete(withItems: nil, error: DataManagerError.wrongItemsType(request.items))
                return
            }

            if items.count < self.cursor.perPage {
                self.canFetchMore = false
            } else {
                self.cursor = request.nextCursor()
            }

            self.items.append(contentsOf: items)

            self.isFetching = false
            self.fetchDidComplete(withItems: items, error: nil)
        }

        operationQueue.addOperationWithDependencies(request)
    }

    func cancelFetch() {
        operationQueue.cancelAllOperations()
        isFetching = false
    }

    func item(at index: Int) -> Survey? {
        guard index < items.count else {
            return nil
        }

        return items[index]
    }

    // MARK: - Private

    private func fetchDidComplete(withItems items: [Survey]?, error: Error?) {
        self.error = error

        if let error = error {
            delegate?.dataManager(self, fetchDidFailWithError: error)
        } else {
            let items = items ?? []
            delegate?.dataManager(self, didFetch: items)
        }
    }

}
