//
//  DetailViewController.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/8/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    @IBOutlet weak var lbEmail: UILabel!
    
    var survey: Survey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbEmail.accessibilityIdentifier = "lbEmail"
        self.bindHtml()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func bindHtml() {
        guard let htmlStr = survey?.thankEmail else {
            return
        }
        
        guard let data = htmlStr.data(using: String.Encoding.unicode) else { return }
        let attrStr = try? NSAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        lbEmail.attributedText = attrStr
    }
}
