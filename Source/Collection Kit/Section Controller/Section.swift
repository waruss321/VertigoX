//
//  Section.swift
//  VertigoX
//
//  Created by Russell Warwick on 25/01/2020.
//

import UIKit

public protocol Section: NSObject {
    init(items: [Item])
    
    var items: [Item] { get set }
    var numberOfItems: Int { get }
    var topPadding: CGFloat { get}
    var bottomPadding: CGFloat { get }
    
    var showSeporator: Bool { get }
    var seporatorColor: UIColor { get }
    
    var cornerRadius: CGFloat { get }
    var shadowOpacity: Float { get }
    
    var margin: CGFloat { get } //Section margin that will be minused from the collectionView width
    var estimatedCellHeight: CGFloat { get } //Cell's height for the section. The more acurate the better performance
    
}

public extension Section {
    init(items: [Item]){
        self.init()
        self.items = items
    }

    var numberOfItems: Int {
        return items.count
    }
}
