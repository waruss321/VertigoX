//
//  ListSection.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
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

public enum SeporatorStyle {
    case none
    case line
}

public protocol SectionTemplate: NSObject {
    init(items: [ItemTemplate])
    
    var items: [ItemTemplate] { get set }
    var numberOfItems: Int { get }
    var topPadding: CGFloat { get}
    var bottomPadding: CGFloat { get }
    
    var seporatorColor: UIColor { get }
    var seporatorStyle: SeporatorStyle { get }
    
    var cornerRadius: CGFloat { get }
    var shadowOpacity: Float { get }
    var margin: CGFloat { get } //Left and right spacing
}

public extension SectionTemplate {
    init(items: [ItemTemplate]){
        self.init()
        self.items = items
    }

    var numberOfItems: Int {
        return items.count
    }
}

//MARK: - Base Section

open class BaseSectionController: ListSectionController, SectionTemplate {
    
    //MARK: - Template
    
    open var items: [ItemTemplate] = []
    open var topPadding: CGFloat { return .zero }
    open var bottomPadding: CGFloat { return .zero }
    
    open var seporatorColor: UIColor { return UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0) }
    open var seporatorStyle: SeporatorStyle { return .none }
    
    open var cornerRadius: CGFloat { return 4 }
    open var shadowOpacity: Float { return 0.3 }
    open var margin: CGFloat { return .zero }
    
    open func bindItemSignals(){ }
    
    //MARK: - Init
        
    public override init() {
        super.init()
        inset = UIEdgeInsets(top: topPadding, bottom: bottomPadding)
    }
    
    //MARK: - ListSectionController

    override open func numberOfItems() -> Int {
        return numberOfItems
    }
    
    override open func sizeForItem(at index: Int) -> CGSize {
        guard let contextWidth = collectionContext?.insetContainerSize.width, let verticalItem = items[safe: index] as? VerticalItem else { return .zero }
        return CGSize(width: contextWidth - margin, height: verticalItem.cellHeight)
    }

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let item = items[safe: index] else { return UICollectionViewCell() }
        
        let cell = IGItemFactory.cellFor(item, atIndex: index, controller: self, itemPosition: itemPosition(index: index))
        
        return cell
    }
}

//ROUND

public enum ItemCellPosition {
    case lastItem
    case middleItem
    case firstItem
    case onlyItem
}

public extension BaseSectionController {
    
    func itemPosition(index: Int) -> ItemCellPosition {
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
