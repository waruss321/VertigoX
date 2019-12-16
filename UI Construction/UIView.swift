//
//  UIView.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIView {
    convenience public init(color: UIColor = .clear, alpha: CGFloat = 1.0) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.alpha = alpha
    }
}
