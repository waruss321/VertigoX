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
    
    private var layout: UICollectionViewFlowLayout {
        return (autoSize)
        ? UICollectionViewFlowLayout(estimatedItemSize: UICollectionViewFlowLayout.automaticSize)
        : UICollectionViewFlowLayout()
    }
    
    public weak var delegate: CollectionControllerDelegate? = nil {
        didSet {
            refresh()
        }
    }
    
    //MARK: - Dependencies
    
    private let updater: ListAdapterUpdater
    private let viewController: UIViewController
    private let autoSize: Bool
    private let animated: Bool
    
    //MARK: - Init
     
    public init(updater: ListAdapterUpdater = ListAdapterUpdater(), viewController: UIViewController, autoSize: Bool = true, animated: Bool = true) {
        self.updater = updater
        self.viewController = viewController
        self.autoSize = autoSize
        self.animated = animated
    }
    
    //MARK: - Public
    
    public var target: UICollectionView? = nil {
        didSet {
            self.adapter.collectionView = target
            self.adapter.dataSource = self
            self.adapter.scrollViewDelegate = self
            self.adapter.collectionView?.collectionViewLayout = (autoSize)
                ? UICollectionViewFlowLayout(estimatedItemSize: UICollectionViewFlowLayout.automaticSize)
                : UICollectionViewFlowLayout()
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
