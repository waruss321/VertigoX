//
//  Collection.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

public extension Collection {
    // Return element if within the bounds, else rerturn nil
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
