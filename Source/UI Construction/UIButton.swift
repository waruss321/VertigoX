//
//  UIButtonConstructor.swift
//  Pitchero Club
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Pitchero. All rights reserved.
//

import UIKit

public extension UIButton {
    
    convenience init(font: UIFont = UIFont.systemFont(ofSize: 15), color: UIColor = .black, highlightedColor: UIColor = .lightGray, text: String? = nil, backgroundColor: UIColor = .clear) {
        self.init()
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(highlightedColor, for: .highlighted)
        self.backgroundColor = backgroundColor
    }

    convenience init(image: UIImage) {
        self.init()
        self.setImage(image, for: .normal)
    }
}
