//
//  SpaceSection.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 05/05/2020.
//

import Foundation

open class SpaceSection: VerticalSection {
    
    //MARK: - Init
    
    public init(height: CGFloat, color: UIColor = .clear) {
        super.init(items: [SpaceItem(height: height, color: color)])
    }
}
