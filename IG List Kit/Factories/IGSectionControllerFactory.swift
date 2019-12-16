//
//  IGSectionControllerFactory.swift
//  RussTools
//
//  Created by Russell Warwick on 22/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

class IGSectionControllerFactory {
    static func controller(forObject object: Any) -> ListSectionController {
        if let section = object as? BaseSectionController {
            return section
        }
        return BaseSectionController()
    }
}
