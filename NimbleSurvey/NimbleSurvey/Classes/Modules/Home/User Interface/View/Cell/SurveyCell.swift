//
//  SurveyCell.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/6/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
protocol SurveyCellDelegate {
    func chooseSurvey(_ survey: Survey)
}
class SurveyCell: UICollectionViewCell {
    static var reuseIdentifier = "SurveyCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var btnTakeSurvey: UIButton!
    
    var survey: Survey?
    var delegate: SurveyCellDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        bindData()
    }
    
    private func setupLayout() {
        btnTakeSurvey.layer.cornerRadius = 8
        btnTakeSurvey.layer.borderWidth = 0.1
        btnTakeSurvey.layer.borderColor = UIColor.clear.cgColor
        btnTakeSurvey.clipsToBounds = true
        
        let shadowColor = UIColor(white: 0, alpha: 0.8)
        lbTitle.dropShadow(color: shadowColor)
        lbDes.dropShadow(color: shadowColor)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbTitle.text = ""
        lbDes.text = ""
        imageView.image = nil
    }
    
    // MARK: - Setup
    func configure(with survey: Survey) {
        self.survey = survey
    }
    
    private func bindData() {
        if let survey = self.survey {
            lbTitle.text = survey.title
            lbDes.text = survey.description
            
            if let url = URL(string: "\(survey.coverImageUrl ?? "")l") {
                downloadImage(with: url)
            }
        }
    }

    private var imageDownloader = ImageDownloader()

    private func downloadImage(with url: URL) {
        imageDownloader.downloadPhoto(with: url, completion: { [weak self] (image, isCached) in
            guard let strongSelf = self, strongSelf.imageDownloader.isCancelled == false else { return }

            if isCached {
                strongSelf.imageView.image = image
            } else {
                UIView.transition(with: strongSelf, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    strongSelf.imageView.image = image
                }, completion: nil)
            }
        })
    }
    
    @IBAction func touchBtnTakeSurvey(_ sender: Any) {
        if let survey = self.survey {
            self.delegate?.chooseSurvey(survey)
        }
    }
}
