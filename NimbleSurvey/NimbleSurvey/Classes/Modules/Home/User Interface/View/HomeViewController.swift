//
//  HomeViewController.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
import UPCarouselFlowLayout
class HomeViewController: UIViewController {
    var eventHandler: HomeModuleInterface?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepIndicatorContainerView: UIView!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    var stepIndicatorView: StepIndicatorView!
    
    var surveys = [Survey]() {
        didSet {
            DispatchQueue.main.async {
                self.setupStepIndicatorView()
            }
        }
    }
    
    let layout = UPCarouselFlowLayout()
    
    var isFetching = false
    var currentStep = -1

    private var spinner: UIActivityIndicatorView!

    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupSpinner()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 52/255.0, alpha: 1.0)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        if surveys.count == 0 {
            refresh()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { (_) in
            self.layout.invalidateLayout()
        })
    }

    // MARK: - Setup
    private func setupSpinner() {
        spinner = {
               if #available(iOS 13.0, *) {
                   let spinner = UIActivityIndicatorView(style: .medium)
                   spinner.translatesAutoresizingMaskIntoConstraints = false
                   spinner.hidesWhenStopped = true
                   return spinner
               } else {
                   let spinner = UIActivityIndicatorView(style: .gray)
                   spinner.translatesAutoresizingMaskIntoConstraints = false
                   spinner.hidesWhenStopped = true
                   return spinner
               }
           }()
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }

    private func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.sideItemScale = 1.0
        layout.spacingMode = .fixed(spacing: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 42)
        collectionView.collectionViewLayout = layout
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: SurveyCell.reuseIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: SurveyCell.reuseIdentifier)
        collectionView.register(PagingView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingView.reuseIdentifier)
        collectionView.backgroundColor = .white
    }
    
    private func setupStepIndicatorView() {
        if stepIndicatorView != nil {
            stepIndicatorView.removeFromSuperview()
        }
        
        stepIndicatorView = StepIndicatorView()
        stepIndicatorView.direction = .topToBottom
        stepIndicatorView.backgroundColor = .clear
        stepIndicatorView.circleRadius = 5
        stepIndicatorView.circleStrokeWidth = 5
        stepIndicatorView.circleColor = .lightGray
        stepIndicatorView.circleTintColor = .blue
        stepIndicatorView.lineColor = .clear
        stepIndicatorView.lineTintColor = .clear
        
        self.view.addSubview(stepIndicatorView)
        
        stepIndicatorView.frame = CGRect(x: 0, y: 0, width: 24, height: 400)
        stepIndicatorView.center = stepIndicatorContainerView.center
        stepIndicatorView.numberOfSteps = self.surveys.count
        stepIndicatorView.currentStep = currentStep
    }

    private func showEmptyView(with state: EmptyViewState) {
        emptyView.state = state

        guard emptyView.superview == nil else { return }

        spinner.stopAnimating()

        view.addSubview(emptyView)

        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func hideEmptyView() {
        emptyView.removeFromSuperview()
    }

    // MARK: - Actions
    @IBAction func touchedBtnRefresh(_ sender: Any) {
        self.surveys = []
        hideEmptyView()
        resetDataSource()
    }

    private func scrollToTop() {
        let contentOffset = CGPoint(x: 0, y: -collectionView.safeAreaInsets.top)
        collectionView.setContentOffset(contentOffset, animated: false)
    }

    // MARK: - Data

    @objc func refresh() {
        guard surveys.isEmpty else { return }

        if surveys.count == 0 {
           resetDataSource()
        }
    }
    
    private func resetDataSource() {
        if isFetching == false {
            eventHandler?.dataSourceReset()
            reloadData()
            fetchNextItems()
        }
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func fetchNextItems() {
        eventHandler?.fetchNextPage()
    }

    private func fetchNextItemsIfNeeded() {
        if surveys.count == 0 {
            fetchNextItems()
        }
    }
}
extension HomeViewController: HomeViewInterface {
    func showSpinner() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func showNoResults() {
        DispatchQueue.main.async {
            self.showEmptyView(with: .noResults)
        }
    }
    
    func updateWithResult(_ newSurveys: [Survey]) {
        isFetching = false
        let currentSurveysCount = self.surveys.count
        if self.surveys.isEmpty {
            currentStep = 0
        }
        self.surveys.append(contentsOf: newSurveys)
        let newSurveysCount = newSurveys.count
        let startIndex = self.surveys.count - newSurveysCount
        let endIndex = startIndex + newSurveysCount
        var newIndexPaths = [IndexPath]()
        for index in startIndex..<endIndex {
            newIndexPaths.append(IndexPath(item: index, section: 0))
        }
        let needInsert = newSurveysCount < currentSurveysCount
        DispatchQueue.main.async { [unowned self] in
            self.spinner.stopAnimating()
            self.hideEmptyView()
            
            if needInsert {
                self.collectionView.insertItems(at: newIndexPaths)
            } else {
                self.reloadData()
            }
        }
    }
    
    func showErrorState(_ state: EmptyViewState) {
        isFetching = false
        DispatchQueue.main.async {
            self.showEmptyView(with: state)
        }
    }
}
