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
    open var pagingEnabled: Bool = false
    open var canBounce: Bool = true
 
    open var didSelectItem: ((Item) -> Void)?
    open var didChangePage: ((Int) -> Void)?
    
    private var topSpacing: CGFloat = .zero
    
    //MARK: - Init
        
    public init(items: [HorizontalItem]) {
        super.init()
        self.items = items
    }
    
    public init(items: [HorizontalItem], itemSpacing: CGFloat = .zero, padding: UIEdgeInsets = .zero, margin: CGFloat = .zero, topSpacing: CGFloat = .zero) {
        super.init()
        self.items = items
        self.leftPadding = padding.left
        self.rightPadding = padding.right
        self.margin = margin
        self.pagingEnabled = false
        self.canBounce = true
        self.itemSpacing = itemSpacing
        self.backgroundColor = .clear
        self.topSpacing = topSpacing
    }
    
    public init(items: [HorizontalItem], itemSpacing: CGFloat = .zero, pagingEnabled: Bool = false, canBounce: Bool = true, padding: UIEdgeInsets = .zero, margin: CGFloat = .zero, topSpacing: CGFloat = .zero, backgroundColor: UIColor = .clear) {
        super.init()
        self.items = items
        self.leftPadding = padding.left
        self.rightPadding = padding.left
        self.margin = margin
        self.pagingEnabled = pagingEnabled
        self.canBounce = canBounce
        self.itemSpacing = itemSpacing
        self.backgroundColor = backgroundColor
        self.topSpacing = topSpacing
    }
    
    //MARK: -
    
    private var sectionWidth: CGFloat {
        return (collectionContext?.containerSize.width ?? 375) - margin
    }
        
    //MARK: - ListSectionController
    
    override open func numberOfItems() -> Int {
        //Only needs 2 because we only need to use the SpaceItem at the top and for other HorizontalLoaderItem
        return 1
    }
    
    private var maxItemHeight: CGFloat {
        guard let hItems = self.items as? [HorizontalItem] else { return 100 }
        let heights = hItems.compactMap({ $0.size.height })
        return heights.max() ?? 100
    }

    override open func sizeForItem(at index: Int) -> CGSize {
        return .size(w: sectionWidth, h: maxItemHeight)
    }
    
    private lazy var loaderItem = HorizontalLoaderItem(items: items as? [HorizontalItem] ?? [], itemSpacing: itemSpacing, pagingEnabled: pagingEnabled, canBounce: canBounce, padding: .padding(left: leftPadding, right: rightPadding), loaderBackgroundColor: backgroundColor)
    
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if let cell = self.collectionContext?.dequeueReusableCell(of: loaderItem.cellType.self, for: self, at: index) as? VerticalCell {

            cell.item = loaderItem
            
            loaderItem.didSelectAtIndex = { [weak self] index in
                guard let item = self?.items[safe: index] else { return }
                self?.didSelectItem?(item)
            }
            
            loaderItem.didChangePage = { [weak self] index in
                self?.didChangePage?(index)
            }
            
            return cell
        }
  
        return UICollectionViewCell()
    }
}
