//
//  CollectionViewCell.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 04/06/2020.
//


public class HCollectionViewItem: VerticalItem {

    public let items: [HorizontalItem]
    public let itemSpacing: CGFloat
    public let padding: UIEdgeInsets
    public let paging: Bool
    public let bounce: Bool
    
    public init(items: [HorizontalItem], itemSpacing: CGFloat = .zero, padding: UIEdgeInsets = .zero, paging: Bool = false, bounce: Bool = false) {
        self.items = items
        self.itemSpacing = itemSpacing
        self.padding = padding
        self.paging = paging
        self.bounce = bounce
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return CollectionViewCell.self
    }
    
    public var estimatedHeight: CGFloat {
        let heights = items.compactMap({ $0.size.height })
        return heights.max() ?? 100
    }
    
    public var xScrolled: CGFloat = 0
    
    public var didSelectAtIndex: ((Int) -> Void)?
    public var didChangePage: ((Int) -> Void)?
}

final class CollectionViewCell: VerticalCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.reloadData()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    //MARK: - Bind

    override public func bindViewModel() {
        guard let item = item as? HCollectionViewItem else { return }
        
        collectionView.contentInset = item.padding
        collectionView.isPagingEnabled = item.paging
        collectionView.alwaysBounceHorizontal = item.bounce
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
            self.collectionView.setContentOffset(.init(x: item.xScrolled, y: 0), animated: false)
            self.collectionView.reloadData()
        }
        
        collectionView.setHeight(item.estimatedHeight)
    }
    
    //MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let item = item as? HCollectionViewItem else { return 0 }
        return item.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewItem = item as? HCollectionViewItem, let item = viewItem.items[safe: indexPath.row] else { return UICollectionViewCell() }

        
        collectionView.register(item.cellType.self, forCellWithReuseIdentifier: String(describing: item.cellType.self))
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: item.cellType.self), for: indexPath) as? HorizontalCell {
            
            cell.item = item
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewItem = item as? HCollectionViewItem, let item = viewItem.items[safe: indexPath.row] else { return .zero}
        
        return item.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let item = item as? HCollectionViewItem else { return .zero }
        return item.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let item = item as? HCollectionViewItem else { return .zero }
        return item.itemSpacing
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let item = item as? HCollectionViewItem else { return }
        item.xScrolled = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let item = item as? HCollectionViewItem, item.paging  else { return }
        
        let x = collectionView.contentOffset.x
        let w = collectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        item.didChangePage?(currentPage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = item as? HCollectionViewItem else { return }
        item.didSelectAtIndex?(indexPath.row)
    }
}
