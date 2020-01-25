//
//  ShopVC.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX
import IGListKit
import Signals

protocol ShopModule: BaseModule {

}

class ShopVC: ViewController, ShopModule, CollectionControllerDelegate {

    //MARK: - Properties

    private let collectionView = UICollectionView(background: .clear)
    
    private lazy var collectionController: CollectionController = {
       return CollectionController(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    private let viewModel: ShopVM
    
    init(viewModel: ShopVM) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Configure
    
    override func configureView() {
        collectionController.target = collectionView
        collectionController.delegate = self
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(collectionView)
        collectionView.fillSuperview()
    }
    
    override func styleView() {
        view.backgroundColor = .white
    }
    
    //MARK: - Bind
    
    override func bindViewModel() {
        collectionController.sections = viewModel.sections
    }
    
    //MARK: - CollectionControllerDelegate
    
    func bindSectionController(_ controller: SectionController) {
        
    }
}

class TestSection: SectionController {
    override var margin: CGFloat {
        return 50
    }
    
    override var topPadding: CGFloat {
        return 40
    }
    
    override var estimatedCellHeight: CGFloat {
        return 100
    }
}
