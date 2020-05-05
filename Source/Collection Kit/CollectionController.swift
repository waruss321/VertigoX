//
//  BaseListKitVC.swift
//  VertigoX
//
//  Created by Russell Warwick on 23/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public protocol CollectionControllerDelegate: class {
    var sections: [Section] { get }
    func bindSectionController(_ controller: SectionController)
    func didScroll(_ scrollView: UIScrollView)
}

public extension CollectionControllerDelegate {
    func bindSectionController(_ controller: SectionController){}
    func didScroll(_ scrollView: UIScrollView) { }
}

public final class CollectionController: NSObject {

    //MARK: - Properties

    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: updater, viewController: viewController)
    }()
    
    public weak var delegate: CollectionControllerDelegate? = nil {
        didSet {
            refresh()
        }
    }
    
    private var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = (autoSize) ? UICollectionViewFlowLayout.automaticSize : .zero
        layout.scrollDirection = direction
        return layout
    }
    
    //MARK: - Dependencies
    
    private let updater: ListAdapterUpdater
    private let viewController: UIViewController
    private let autoSize: Bool
    private let animated: Bool
    private let direction: UICollectionView.ScrollDirection
    
    //MARK: - Init
     
    public init(updater: ListAdapterUpdater = ListAdapterUpdater(), viewController: UIViewController = UIViewController(), autoSize: Bool = true, animated: Bool = true, direction: UICollectionView.ScrollDirection = .vertical) {
        self.updater = updater
        self.viewController = viewController
        self.autoSize = autoSize
        self.animated = animated
        self.direction = direction
    }
    
    //MARK: - Public

    public var target: UICollectionView? = nil {
        didSet {
            self.adapter.collectionView = target
            self.adapter.dataSource = self
            self.adapter.scrollViewDelegate = self
            self.adapter.collectionView?.collectionViewLayout = layout
        }
    }
    
    public func refresh(){
        self.adapter.performUpdates(animated: animated)
    }
    
    public func reload(){
        self.adapter.reloadData(completion: nil)
    }
}

extension CollectionController: ListAdapterDataSource {
    
    //MARK: - ListAdapterDataSource
        
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return delegate?.sections ?? []
    }
       
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {

        guard let sectionController = object as? SectionController else {
            fatalError("All sections must inhert from SectionController")
        }
        
        delegate?.bindSectionController(sectionController)
        
        return sectionController
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

extension CollectionController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.didScroll(scrollView)
    }
}
