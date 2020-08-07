//
//  HomeViewController+CollectionView.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyCell.reuseIdentifier, for: indexPath)
        let survey = surveys[indexPath.item]
        guard let surveyCell = cell as? SurveyCell else { return cell }

        surveyCell.configure(with: survey)
        surveyCell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PagingView.reuseIdentifier, for: indexPath)

        guard let pagingView = view as? PagingView else { return view }

        pagingView.isLoading = isFetching

        return pagingView
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let prefetchCount = 1
        if indexPath.item == surveys.count - prefetchCount {
            fetchNextItems()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrolling(_ scrollView: UIScrollView) {
        print("Gallery did end scrolling.")
        let centerPoint = view.center
        let collectionViewCenterPoint = self.view.convert(centerPoint, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: collectionViewCenterPoint) {
            // Update step indicator view
            currentStep = indexPath.row
            stepIndicatorView.currentStep = currentStep
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrolling(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidEndScrolling(scrollView)
        }
    }
}
extension HomeViewController: SurveyCellDelegate {
    func chooseSurvey(_ survey: Survey) {
        eventHandler?.showSurveyDetail(survey)
    }
}
