//
//  MainViewController.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/5/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
class MainViewController: UIViewController {
    @IBOutlet weak var imgLoading: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupSpinningView()
    }
    
    func setupSpinningView() {
        let advTimeGif = UIImage.gifImageWithName("spinner")
        self.imgLoading.image = advTimeGif
    }
}
extension MainViewController: MainViewInterface {
    func showError() {
        
    }
}
