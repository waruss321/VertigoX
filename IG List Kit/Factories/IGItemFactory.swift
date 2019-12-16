//
//  IGListItemFactory.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

class IGItemFactory {
    static func cellFor(_ item: ItemTemplate, atIndex index: Int, controller: BaseSectionController, itemPosition: ItemCellPosition) -> UICollectionViewCell {
       
        //Controller decides on rounded corners and shadows
        
        if let collectionContext = controller.collectionContext,
            let item = item as? VerticalItem,
            let cell = collectionContext.dequeueReusableCell(of: item.cellType, for: controller, at: index) as? BaseVerticalItemCell {
            
            cell.configure(withItem: item, controller: controller, itemPosition: itemPosition)
            return cell
        }
        
        assertionFailure("BaseItem of type: \(item.self) has not been mapped")

        return UICollectionViewCell()
    }
}
