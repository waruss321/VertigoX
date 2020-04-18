//
//  Section.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 17/04/2020.
//

import Foundation

public protocol Section: NSObject {
    var items: [Item] { get set }
}
