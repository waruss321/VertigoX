//
//  AdapterViewModelTemplate.swift
//  RussTools
//
//  Created by Russell Warwick on 23/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import CoreGraphics

public protocol AdapterViewModelTemplate {
    var sections: [SectionTemplate] { get }
    var header: BaseSectionController? { get }
    var headerHeight: CGFloat { get }
    var footer: BaseSectionController? { get }
    var footerHeight: CGFloat { get }
}

public extension AdapterViewModelTemplate {
    
    var header: BaseSectionController? {
        return BaseSectionController(items: [SpaceModel(height: headerHeight)])
    }
    
    var headerHeight: CGFloat {
        return 0
    }
    
    var footer: BaseSectionController? {
        return BaseSectionController(items: [SpaceModel(height: footerHeight)])
    }
    
    var footerHeight: CGFloat {
        return 0
    }
}
