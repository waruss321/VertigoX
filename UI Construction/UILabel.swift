//
//  UILabelConstructor.swift
//  Pitchero Club
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Pitchero. All rights reserved.
//

import UIKit

public extension UILabel {
    convenience public init(text: String? = nil, font: UIFont = UIFont.systemFont(ofSize: 15), color: UIColor = .black, alignment: NSTextAlignment = .left, lines: Int = 1, backgroundColor: UIColor = .clear) {
        self.init()
        self.text = text
        self.textAlignment = alignment
        self.numberOfLines = lines
        self.font = font
        self.textColor = color
        self.backgroundColor = backgroundColor
    }
}
