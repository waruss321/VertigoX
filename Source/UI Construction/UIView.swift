//
//  UIView.swift
//  VertigoX
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIView {
    
    convenience init(backgroundColor: UIColor = .clear, alpha: CGFloat = 1.0, cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}

//Safe Areas Heights

public var deviceTopSafeHeight: CGFloat {
    guard let height = UIApplication.shared.keyWindow?.safeAreaInsets.top else { return 0 }
    return height
}

public var deviceBottomSafeHeight: CGFloat {
    guard let height = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else { return 0 }
    return height
}
