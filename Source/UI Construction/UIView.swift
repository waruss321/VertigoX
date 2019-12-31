//
//  UIView.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIView {
    convenience init(color: UIColor = .clear, alpha: CGFloat = 1.0, cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.alpha = alpha
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}
