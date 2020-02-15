//
//  UICollectionVIew.swift
//  VertigoX
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    convenience init(background: UIColor, contentInset: UIEdgeInsets = .zero, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), alwaysBounce: Bool = true) {
    
        self.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = background
        self.alwaysBounceVertical = alwaysBounce
        self.contentInset = contentInset
    }
}

public extension UICollectionViewFlowLayout {
    convenience init(estimatedItemSize: CGSize) {
        self.init()
        self.estimatedItemSize = estimatedItemSize
    }
}
