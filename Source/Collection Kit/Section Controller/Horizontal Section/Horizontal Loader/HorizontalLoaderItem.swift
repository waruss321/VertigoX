//
//  HorizontalLoaderItem.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 18/04/2020.
//

import IGListKit

struct HorizontalLoaderItem: VerticalItem {
    
    public let height: CGFloat
    public let items: [HorizontalItem]
    public let itemSpacing: CGFloat
    public let padding: UIEdgeInsets
    
    var didSelectAtIndex: ((Int) -> Void)?
    var didBindSignalsForItem: ((Item) -> Void)?
    
    public init(height: CGFloat, items: [HorizontalItem], itemSpacing: CGFloat, padding: UIEdgeInsets) {
        self.height = height
        self.items = items
        self.itemSpacing = itemSpacing
        self.padding = padding
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return HorizontalLoaderCell.self
    }
    
    public var estimatedHeight: CGFloat {
        return height
    }
}

internal final class HorizontalLoaderCell: VerticalCell {
    
    //MARK: - UI
    
    private let collectionView = UICollectionView(background: .clear)
    
    //MARK: -

    private lazy var collectionController: CollectionController = {
        return CollectionController(viewController: UIViewController(), direction: .horizontal)
    }()

    private var loader: HorizontalLoaderSection?
        
    //MARK: - Configure
    
    override func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubviews(collectionView)
        collectionView.fillSuperview()
    }
    
    override func configureView() {
        collectionController.target = collectionView
        collectionController.delegate = self
    }
    
    override func styleView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func bindViewModel() {
        guard let item = item as? HorizontalLoaderItem else { return }
        collectionView.setHeight(item.height)
        
        loader = HorizontalLoaderSection(items: item.items, itemSpacing: item.itemSpacing,
                                             padding: item.padding)
        loader?.didSelectAtIndex = { index in
            item.didSelectAtIndex?(index)
        }
            
        loader?.didBindSignalsForItem = { cellItem in
            //print("item.didBindSignalsForItem?(cellItem)")
            item.didBindSignalsForItem?(cellItem)
        }
        
        collectionController.refresh()
    }
}

extension HorizontalLoaderCell: CollectionControllerDelegate {
    
    func bindSectionController(_ controller: SectionController) {

    }
    
    var sections: [Section] {
        return [loader].compactMap({ $0 })
    }
}





//MARK: - HorizontalLoaderSection

private class HorizontalLoaderSection: SectionController, Section {
    
    //MARK: - Template
    
    var didSelectAtIndex: ((Int) -> Void)?
    var didBindSignalsForItem: ((Item) -> Void)?
    
    open var items: [Item] = []
    
    //MARK: - Init
        
    public init(items: [HorizontalItem], itemSpacing: CGFloat, padding: UIEdgeInsets) {
        super.init()
        self.items = items
        self.minimumLineSpacing = itemSpacing
        self.minimumInteritemSpacing = itemSpacing
        self.inset = padding
    }
    
    //MARK: - ListSectionController
    
    override open func numberOfItems() -> Int {
        return items.count
    }

    override open func sizeForItem(at index: Int) -> CGSize {
        
        guard let item = items[safe: index] as? HorizontalItem else {
            fatalError("Items should only be HorizontalItem's")
        }
        
        return item.size
    }

    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let item = items[safe: index] as? HorizontalItem,
            let cell = self.collectionContext?.dequeueReusableCell(of: item.cellType, for: self, at: index) as? HorizontalCell else {
            fatalError("Items should only be HorizontalItem's")
        }
        
        cell.item = item
        return cell
    }
    
    //MARK: -
    
    override open func didUpdate(to object: Any) {
        for item in items {
            self.didBindSignalsForItem?(item)
        }
    }
    
    //MARK: - Did Select
    
    override func didSelectItem(at index: Int) {
        didSelectAtIndex?(index)
    }
}
