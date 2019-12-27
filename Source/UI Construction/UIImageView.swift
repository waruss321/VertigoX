//
//  UIImageViewConstructor.swift
//  VertigoX
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIImageView {
    convenience init(image: UIImage? = nil, mode: UIView.ContentMode = .scaleAspectFit, color: UIColor = .black, backgroundColor: UIColor = .clear) {
        self.init()
        self.image = image
        self.contentMode = mode
        self.tintColor = color
        self.backgroundColor = backgroundColor
    }
}
