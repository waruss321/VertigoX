//
//  NSObjectDiffable.swift
//  VertigoX
//
//  Created by Russell Warwick on 25/01/2020.
//

import IGListKit

extension NSObject: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
