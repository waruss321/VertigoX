//
//  SectionController.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 18/04/2020.
//

import IGListKit

open class SectionController: ListSectionController {
    
    override open func numberOfItems() -> Int {
        return 1
    }

    override open func sizeForItem(at index: Int) -> CGSize {
        return .size(w: 1, h: 1)
    }

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    //MARK: -
    
    override open func didUpdate(to object: Any) { }
}

