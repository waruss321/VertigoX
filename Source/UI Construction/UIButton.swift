//
//  UIButtonConstructor.swift
//  VertigoX
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIButton {
    
    convenience init(font: UIFont = UIFont.systemFont(ofSize: 15), fontColor: UIColor = .black, highlightedColor: UIColor = .lightGray, text: String? = nil, backgroundColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(fontColor, for: .normal)
        self.setTitleColor(highlightedColor, for: .highlighted)
        self.backgroundColor = backgroundColor
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }

    convenience init(image: UIImage, backgroundColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}
