//
//  HorizontalSection.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 18/04/2020.
//-

import IGListKit

open class HorizontalSectionController: SectionController, Section {
    
    //MARK: - Template
    
    open var items: [Item] = []
    open var leftPadding: CGFloat { return .zero }
    open var rightPadding: CGFloat { return .zero }
    
    open var itemSpacing: CGFloat { return .zero }
    open var height: CGFloat { return 100 }
    
    open var margin: CGFloat { return .zero }
    
    open func bindSignalsForItem(_ item: Item) {}
    
    //MARK: - Init
        
    public init(items: [HorizontalItem]) {
        super.init()
        self.items = items
    }
    
    //MARK: -
    
    private var sectionWidth: CGFloat {
        return (collectionContext?.containerSize.width ?? 375) - margin
    }
        
    //MARK: - ListSectionController
    
    override open func numberOfItems() -> Int {
        return 1
    }

    override open func sizeForItem(at index: Int) -> CGSize {
        return .size(w: sectionWidth, h: height)
    }
    
    lazy var loader = HorizontalLoaderItem(height: height, items: items as? [HorizontalItem] ?? [], itemSpacing: itemSpacing, padding: .padding(left: leftPadding, right: rightPadding))

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if let cell = self.collectionContext?.dequeueReusableCell(of: HorizontalLoaderCell.self, for: self, at: index) as? VerticalCell {

            cell.item = loader
            
            loader.didSelectAtIndex = { [weak self] index in
                self?.didSelectItem(at: index)
            }
            
            return cell
        }
  
        return UICollectionViewCell()
    }
    
    //MARK: -
    
    override open func didUpdate(to object: Any) {
        for item in items {
            bindSignalsForItem(item)
        }
    }
}
