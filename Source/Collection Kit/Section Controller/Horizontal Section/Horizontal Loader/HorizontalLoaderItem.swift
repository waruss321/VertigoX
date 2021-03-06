//
//  HorizontalLoaderItem.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 18/04/2020.
//

import IGListKit

public struct HorizontalLoaderItem: VerticalItem {
    
    public let items: [HorizontalItem]
    public let itemSpacing: CGFloat
    public let padding: UIEdgeInsets
    public let loaderBackgroundColor: UIColor
    public let pagingEnabled: Bool
    public let canBounce: Bool
    
    public var didSelectAtIndex: ((Int) -> Void)?
    public var didChangePage: ((Int) -> Void)?
    
    public init(items: [HorizontalItem], itemSpacing: CGFloat = .zero, pagingEnabled: Bool = false, canBounce: Bool = true, padding: UIEdgeInsets = .zero, loaderBackgroundColor: UIColor = .clear) {
        self.items = items
        self.itemSpacing = itemSpacing
        self.pagingEnabled = pagingEnabled
        self.canBounce = canBounce
        self.padding = padding
        self.loaderBackgroundColor = loaderBackgroundColor
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return HorizontalLoaderCell.self
    }
    
    public var estimatedHeight: CGFloat {
        return maxItemHeight
    }
    
    private var maxItemHeight: CGFloat {
        guard let hItems = self.items as? [HorizontalItem] else { return 100 }
        let heights = hItems.compactMap({ $0.size.height })
        return heights.max() ?? 100
    }
}

internal final class HorizontalLoaderCell: VerticalCell {
    
    //MARK: - UI
    
    private let collectionView = UICollectionView(background: .clear)
    
    //MARK: -

    private lazy var collectionController: CollectionController = {
        return CollectionController(viewController: UIViewController(), autoSize: false, direction: .horizontal)
    }()

    private var loader: HorizontalLoaderSection?
    
    private var heightConstraint: NSLayoutConstraint? = nil
        
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
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func bindViewModel() {
        guard let item = item as? HorizontalLoaderItem else { return }
        
        collectionController.canBounce = item.canBounce
        collectionController.pagingEnabled = item.pagingEnabled
        
        if heightConstraint == nil {
            heightConstraint = contentView.setHeight(item.estimatedHeight, priority: .almost)
        } else {
            heightConstraint?.constant = item.estimatedHeight
            self.layoutIfNeeded()
        }
        
        contentView.backgroundColor = item.loaderBackgroundColor
        
        loader = HorizontalLoaderSection(items: item.items, itemSpacing: item.itemSpacing,
                                             padding: item.padding)
        loader?.didSelectAtIndex = { index in
            item.didSelectAtIndex?(index)
        }

        collectionController.refresh()
    }
}

extension HorizontalLoaderCell: CollectionControllerDelegate {
    var sections: [Section] {
        return [loader].compactMap({ $0 })
    }
    
    func didChangePage(_ index: Int) {
        guard let item = item as? HorizontalLoaderItem else { return }
        item.didChangePage?(index)
    }
}

//MARK: - HorizontalLoaderSection

private class HorizontalLoaderSection: SectionController, Section {
    
    //MARK: - Template
    
    var didSelectAtIndex: ((Int) -> Void)?
    
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
    }
    
    //MARK: - Did Select
    
    override func didSelectItem(at index: Int) {
        didSelectAtIndex?(index)
    }
}
