//
//  HorizontalSection.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 18/04/2020.
//-

import IGListKit

open class HorizontalSection: SectionController, Section {
    
    //MARK: - Template
    
    open var backgroundColor: UIColor = .clear
    open var items: [Item] = []
    open var leftPadding: CGFloat = .zero
    open var rightPadding: CGFloat = .zero
    
    open var margin: CGFloat = .zero
    
    open var itemSpacing: CGFloat = .zero
    open var height: CGFloat = 100
 
    open var didSelectItem: ((Item) -> Void)?
    
    //MARK: - Init
        
    public init(items: [HorizontalItem]) {
        super.init()
        self.items = items
    }
    
    public init(items: [HorizontalItem], height: CGFloat = 100, padding: CGFloat = .zero, margin: CGFloat = .zero, itemSpacing: CGFloat = .zero, backgroundColor: UIColor) {
        super.init()
        self.items = items
        self.leftPadding = padding
        self.rightPadding = padding
        self.height = height
        self.margin = margin
        self.itemSpacing = itemSpacing
        self.backgroundColor = backgroundColor
    }
    
    //MARK: -
    
    private var sectionWidth: CGFloat {
        return (collectionContext?.containerSize.width ?? 375) - margin
    }
        
    //MARK: - ListSectionController
    
    override open func numberOfItems() -> Int {
        //Only needs 1 because we only need to use the HorizontalLoaderItem
        return 1
    }

    override open func sizeForItem(at index: Int) -> CGSize {
        return .size(w: sectionWidth, h: height)
    }
    
    lazy var loaderItem = HorizontalLoaderItem(height: height, items: items as? [HorizontalItem] ?? [], itemSpacing: itemSpacing, padding: .padding(left: leftPadding, right: rightPadding), loaderBackgroundColor: backgroundColor)

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if let cell = self.collectionContext?.dequeueReusableCell(of: HorizontalLoaderCell.self, for: self, at: index) as? VerticalCell {

            cell.item = loaderItem
            
            loaderItem.didSelectAtIndex = { [weak self] index in
                guard let item = self?.items[safe: index] else { return }
                self?.didSelectItem?(item)
            }
            
            return cell
        }
  
        return UICollectionViewCell()
    }
}
