//
//  ListSection.swift
//  VertigoX
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

//MARK: - Base Section

open class SectionController: ListSectionController, Section {
    
    //MARK: - Template
    
    open var items: [Item] = []
    open var topPadding: CGFloat { return .zero }
    open var bottomPadding: CGFloat { return .zero }
    
    open var showSeporator: Bool { return false }
    open var seporatorColor: UIColor { return UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0) }
    
    open var cornerRadius: CGFloat { return 4 }
    open var shadowOpacity: Float { return 0.3 }
    
    open var margin: CGFloat { return .zero }
    open var estimatedCellHeight: CGFloat { return 100 }
    
    open func bindSignalsForItem(_ item: Item){ }
    
    //MARK: - Init
        
    public override init() {
        super.init()
        inset = UIEdgeInsets(top: topPadding, bottom: bottomPadding)
    }
    
    //MARK: - ListSectionController

    override open func numberOfItems() -> Int {
        return numberOfItems
    }
    
    private var sectionWidth: CGFloat {
        return (collectionContext?.containerSize.width ?? 1) - margin
    }
    
    override open func sizeForItem(at index: Int) -> CGSize {
        return CGSize(w: sectionWidth, h: estimatedCellHeight)
    }

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let itemPosition = position(index: index)

        if let item = items[safe: index] as? VerticalItem,
           let cell = self.collectionContext?.dequeueReusableCell(of: item.cellType, for: self, at: index) as? VerticalCell {
            
            cell.styleSectionCell(item: item, controller: self, position: itemPosition)
            cell.item = item
            cell.cellWidth = sectionWidth

            return cell
        }
        
        //TODO: Can add horizontal item support here
        
        return UICollectionViewCell()
    }
    
    //MARK: -
    
    override open func didUpdate(to object: Any) {
        for item in items {
            bindSignalsForItem(item)
        }
    }
}

//ROUND CORNERS

public enum ItemCellPosition {
    case lastItem
    case middleItem
    case firstItem
    case onlyItem
}

public extension SectionController {
    
    func position(index: Int) -> ItemCellPosition {
        if isFirstItem(index: index) {
            return .firstItem
        } else if isLastItem(index: index){
            return .lastItem
        } else if isMiddleItem(index: index){
            return .middleItem
        } else {
            return .onlyItem
        }
    }
    
    func isFirstItem(index: Int) -> Bool {
        return index == .zero && numberOfItems() != 1
    }
    
    func isMiddleItem(index: Int) -> Bool {
        return !isFirstItem(index: index) && !isLastItem(index: index) && numberOfItems() != 1
    }
    
    func isLastItem(index: Int) -> Bool {
        return index == numberOfItems() - 1 && numberOfItems() != 1
    }
    
    func isOnlyItem(index: Int) -> Bool {
        return numberOfItems() == 1 && index == 0
    }
}