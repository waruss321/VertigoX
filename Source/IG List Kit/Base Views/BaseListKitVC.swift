//
//  BaseListKitVC.swift
//  RussTools
//
//  Created by Russell Warwick on 23/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

open class BaseListKitVC: ViewController, ListAdapterDataSource {
    
    //MARK: - Properties
    
    //Make sure to add collection view to parent view controller
    public let collectionView = UICollectionView(background: .clear, layout: UICollectionViewFlowLayout())
    
    public var automaticSize: Bool {
        return true
    }
        
    public lazy var adapter: ListAdapter = { return ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    
    //MARK: - Dependencies
    
    private let viewModel: ListVMTemplate

    //MARK: - Init

    public init(viewModel: ListVMTemplate) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Layout
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        if automaticSize {
            collectionView.collectionViewLayout = UICollectionViewFlowLayout(estimatedItemSize: UICollectionViewFlowLayout.automaticSize)
        }
        adapter.dataSource = self
    }
    
     override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.adapter.performUpdates(animated: true)
    }
    
    //MARK: - ListAdapterDataSource
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.sections
    }
       
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = IGSectionControllerFactory.controller(forObject: object)
        bindSectionController(sectionController)
        return sectionController
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    open func bindSectionController(_ sectionController: ListSectionController) { }
}
