//
//  Extensions.swift
//  NimbleSurvey
//
//  Created by HoangNguyen on 8/11/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import UIKit
extension UIView {
    func dropShadow(scale: Bool = true, color: UIColor = UIColor.black, isOnlyBottom: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = isOnlyBottom ? CGSize(width: 0.0, height: 2.0) : CGSize.zero
        layer.shadowRadius = isOnlyBottom ? 1.5 : 4
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
