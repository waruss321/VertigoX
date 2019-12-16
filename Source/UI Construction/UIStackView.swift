//
//  UIStackViewConstructor.swift
//  Pitchero Club
//
//  Created by Russell Warwick on 11/09/2019.
//  Copyright © 2019 Pitchero. All rights reserved.
//

import UIKit

public extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = .zero) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
