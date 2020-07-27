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
    var open: VoidSignal { get }
}

class ShopVC: ViewController, ShopModule {
    
    var open = VoidSignal()

    //MARK: - Properties

    
    private let buttonTest = UIButton(text: "Refresh list", backgroundColor: .lightGray)
    
    private let collectionView = UICollectionView(background: .clear)
    
    private var collectionController = CollectionController(autoSize: false)
    
    //MARK: - Dependencies
    
    private let viewModel: ShopVM
    
    //MARK: - Init
    
    init(viewModel: ShopVM) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Configure
    
    override func configureView() {
        collectionController.target = collectionView
        collectionController.delegate = self
        collectionController.refresh()
        collectionController.reload()
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(collectionView, buttonTest)
        collectionView.pin(top: view.topSafe, leading: view.leadingAnchor, bottom: buttonTest.top, trailing: view.trailing)
        buttonTest.pinLeading(view.leadingAnchor, padding: 50)
        buttonTest.pinTrailing(view.trailing, padding: 50, relation: .equal)
        buttonTest.pinBottom(view.bottom, padding: 0)
        buttonTest.setSize(.size(w: 100, h: 100))
        //collectionView.scroll
    }
    
    override func styleView() {
        view.backgroundColor = .white
    }

    //MARK: - Bind

    override func bind() {
        buttonTest.onTouchUpInside.subscribe(with: self) { _ in
            self.collectionController.reload()
        }
    }
    
}


extension ShopVC: CollectionControllerDelegate {
    
    //MARK: - CollectionControllerDelegate
    
    var sections: [Section] {
        return viewModel.sections
    }
}
