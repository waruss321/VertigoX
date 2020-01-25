//
//  BaseListKitVC.swift
//  VertigoX
//
//  Created by Russell Warwick on 23/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public protocol CollectionControllerDelegate {
    func bindSectionController(_ controller: SectionController)
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
    
    public var delegate: CollectionControllerDelegate? = nil
    
    //MARK: - Dependencies
    
    private let updater: ListAdapterUpdater
    private let viewController: UIViewController
    private let autoSize: Bool
    private let animated: Bool
    
    //MARK: - Init
     
    public init(updater: ListAdapterUpdater, viewController: UIViewController, autoSize: Bool = true, animated: Bool = true) {
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
            self.adapter.collectionView?.collectionViewLayout = (autoSize)
                ? UICollectionViewFlowLayout(estimatedItemSize: UICollectionViewFlowLayout.automaticSize)
                : UICollectionViewFlowLayout()
        }
    }
    
   public var sections: [Section] = [] {
        didSet {
            guard let _ = target else { fatalError("Make sure your adapters collectionView has been set") }
            self.adapter.performUpdates(animated: animated)
        }
    }
}

extension CollectionController: ListAdapterDataSource {
    
    //MARK: - ListAdapterDataSource
        
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sections
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
