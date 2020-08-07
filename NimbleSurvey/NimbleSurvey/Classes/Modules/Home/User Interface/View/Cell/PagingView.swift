//
//  PagingView.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/7/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit

class PagingView: UICollectionReusableView {

    // MARK: - Properties

    static var height: CGFloat = 44
    static var reuseIdentifier = "PagingView"

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    var isLoading = false {
        didSet {
            if isLoading {
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
            }
        }
    }

    // MARK: - Lifetime

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSpinner()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupSpinner()
    }

    // MARK: - Setup

    private func setupSpinner() {
        addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
