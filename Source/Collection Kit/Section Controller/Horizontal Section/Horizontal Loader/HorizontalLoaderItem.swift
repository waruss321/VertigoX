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
        let heights = items.compactMap({ $0.size.height })
        return heights.max() ?? 100
    }
        
    
}

internal final class HorizontalLoaderCell: VerticalCell {
    
    //MARK: - UI
    
    private let collectionView = UICollectionView(background: .random())
    
    //MARK: -

//    lazy var loaderSection: HorizontalLoaderSection = HorizontalLoaderSection(items: [], itemSpacing: item.itemSpacing, padding: item.padding)
    
    weak var collectionController = CollectionController(autoSize: false, animated: false, direction: .horizontal)

    
        
    private var heightConstraint: NSLayoutConstraint? = nil
        
    //MARK: - Configure
    
    let test = UILabel(text: "This is a horizontal cell")
    
    override func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        print("HorizontalLoaderItem setConstraints")
        contentView.addSubviews(collectionView)
        collectionView.fillSuperview()

    }
    
    override func configureView() {
        
    }
    
    override func styleView() {
        contentView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionController?.target = collectionView
        collectionController?.delegate = self
        collectionController?.refresh()
    }
    
    private var items: [HorizontalItem] = []
    
    
        
    override func bindViewModel() {
        print("HorizontalLoaderItem bind view model")
        guard let item = item as? HorizontalLoaderItem else { return }
        
//        loaderSection = HorizontalLoaderSection(items: item.items, itemSpacing: item.itemSpacing, padding: item.padding)
//
//        collectionController.canBounce = item.canBounce
//        collectionController.pagingEnabled = item.pagingEnabled
//
//
//        loaderSection?.didSelectAtIndex = { index in
//            item.didSelectAtIndex?(index)
//        }
//
//        collectionController.reload()
//        collectionView.scrollRectToVisible(.zero, animated: false)
//

        heightConstraint = collectionView.setHeight(item.estimatedHeight, priority: .almost)
        contentView.backgroundColor = item.loaderBackgroundColor
    }
}

extension HorizontalLoaderCell: CollectionControllerDelegate {
    
    var sections: [Section] {
        return [HorizontalLoaderSection(items: [ImageItem2(title: "start"), ImageItem2(title: "lol"), ImageItem2(title: "lol"), ImageItem2(title: "lol"), ImageItem2(title: "lol"), ImageItem2(title: "lol"), ImageItem2(title: "lol"), ImageItem2(title: "end")], itemSpacing: 10, padding: .zero)].compactMap({ $0 })
    }
    
    func didChangePage(_ index: Int) {
        guard let item = item as? HorizontalLoaderItem else { return }
        item.didChangePage?(index)
    }

}

//MARK: - HorizontalLoaderSection

internal class HorizontalLoaderSection: SectionController, Section {
    
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













struct ImageItem2: HorizontalItem {

    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    var cellType: AnyClass {
       return ImageCell2.self
    }
    
    var size: CGSize {
        return .square(100)
    }
}

final class ImageCell2: HorizontalCell {
    
    private let label = UILabel(alignment: .center)
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        label.fillSuperview(padding: .square(5))
    }
    
    override func styleView() {
        label.backgroundColor = .red
    }
    
    override public func bindViewModel() {
        guard let item = item as? ImageItem2 else { return }
        contentView.backgroundColor = .cyan
        label.text = item.title
    }

}














































































