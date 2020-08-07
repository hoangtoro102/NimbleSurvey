//
//  HomePresenter.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
class HomePresenter {
    var wireframe: HomeWireframe?
    var viewInterface: HomeViewInterface?
    var interactor: HomeInteractorInput?
}
extension HomePresenter: HomeModuleInterface {
    func dataSourceReset() {
        interactor?.dataSourceReset()
    }
    
    func fetchNextPage() {
        interactor?.fetchNextPage()
    }
    
    func showSurveyDetail(_ survey: Survey) {
        wireframe?.presentDetailInterface(survey)
    }
}
extension HomePresenter: HomeInteractorOutput {
    func willStartFetching() {
        viewInterface?.showSpinner()
    }
    
    func finishFetchingWithData(_ surveys: [Survey]) {
        viewInterface?.hideSpinner()
        viewInterface?.updateWithResult(surveys)
    }
    
    func errorWhileFetching(_ state: EmptyViewState) {
        viewInterface?.hideSpinner()
        viewInterface?.showErrorState(state)
    }
}
