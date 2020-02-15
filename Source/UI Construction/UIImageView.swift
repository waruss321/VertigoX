//
//  UIImageViewConstructor.swift
//  VertigoX
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
    
    convenience init(image: UIImage? = nil, mode: UIView.ContentMode = .scaleAspectFit, color: UIColor = .black, backgroundColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.image = image
        self.contentMode = mode
        self.tintColor = color
        self.backgroundColor = backgroundColor
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}
