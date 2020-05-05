//
//  SectionController.swift
//  VertigoX
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

open class VerticalSection: SectionController, Section {
    
    //MARK: - Template
    
    open var items: [Item] = []
    open var margin: CGFloat = .zero
    
    open var showSeporator: Bool = false
    open var seporatorColor: UIColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0)
    
    open var cornerRadius: CGFloat = .zero
    open var shadowOpacity: Float = .zero
    open var cornerRadiusOption: CornerOptions = .none
    
    open var didSelectItem: ((Item) -> Void)?
        
    //MARK: - Init
        
    public init(items: [VerticalItem]) {
        super.init()
        self.items = items
    }
    
    public init(items: [VerticalItem], topPadding: CGFloat = .zero, bottomPadding: CGFloat = .zero, margin: CGFloat = .zero) {
        super.init()
        self.items = items
        self.margin = margin
        self.inset = .padding(top: topPadding, bottom: bottomPadding)
    }
    
    public init(items: [VerticalItem], topPadding: CGFloat = .zero, bottomPadding: CGFloat = .zero, margin: CGFloat = .zero, cornerStyle: CornerOptions = .none, cornerRadius: CGFloat = 0, shadowOpacity: Float = 0.3) {
        super.init()
        self.items = items
        self.margin = margin
        self.cornerRadiusOption = cornerStyle
        self.cornerRadius = cornerRadius
        self.shadowOpacity = shadowOpacity
        self.inset = .padding(top: topPadding, bottom: bottomPadding)
    }
        
    //MARK: - ListSectionController

    override open func numberOfItems() -> Int {
        return items.count
    }
    
    private var sectionWidth: CGFloat {
        return (collectionContext?.containerSize.width ?? 1) - margin
    }
    
    override open func sizeForItem(at index: Int) -> CGSize {

        var estimatedCellHeight: CGFloat = 100
        
        if let item = items[safe: index] as? VerticalItem {
            estimatedCellHeight = item.estimatedHeight
        }
        
        return .size(w: sectionWidth, h: estimatedCellHeight)
    }

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let itemPosition = position(index: index)

        if let item = items[safe: index] as? VerticalItem,
           let cell = self.collectionContext?.dequeueReusableCell(of: item.cellType, for: self, at: index) as? VerticalCell {
            
            cell.styleSectionCell(item: item, controller: self, position: itemPosition)
            cell.position = itemPosition
            cell.index = index
            cell.item = item //Binding
            cell.cellWidth = sectionWidth
            return cell
        }
                
        return UICollectionViewCell()
    }
    
    open override func didSelectItem(at index: Int) {
        guard let item = items[safe: index] else { return }
        self.didSelectItem?(item)
    }
    
    //MARK: -
    
    override open func didUpdate(to object: Any) { }
}

//ROUND CORNERS

public enum ItemCellPosition {
    case single
    case first
    case middle
    case last
}

public extension VerticalSection {
    
    func position(index: Int) -> ItemCellPosition {
        if isFirstItem(index: index) {
            return .first
        } else if isLastItem(index: index){
            return .last
        } else if isMiddleItem(index: index){
            return .middle
        } else {
            return .single
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

public enum CornerOptions {
    case none
    case topBottom
    case top
    case bottom
}
