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
    
    private lazy var collectionController: CollectionController = {
        return CollectionController(viewController: self)
    }()
    
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
        
    }
//    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(collectionView, buttonTest)
        collectionView.pin(top: view.topSafe, leading: view.leadingAnchor, bottom: buttonTest.top, trailing: view.trailing)
        buttonTest.pinTrailing(view.trailing, padding: 50, relation: .equal)
        buttonTest.pinBottom(view.bottom, padding: 0)
        buttonTest.setSize(.size(w: 100, h: 200))
        //collectionView.scroll
    }
    
    override func styleView() {
        view.backgroundColor = .purple
    }

    //MARK: - Bind

    override func bindSignals() {
        buttonTest.onTouchUpInside.subscribe(with: self) { _ in
            self.viewModel.test.toggle()
            self.collectionController.refresh()
        }
    }
    
    private func scrollToIndex(){
        //This only works properly if automatic size = false, or
        //If you're using a fixed height cell and height is same within VerticalSectionController
        self.collectionController.target?.scrollToItem(at: IndexPath(item: 4, section: 1), at: .top, animated: true)
    }
}


extension ShopVC: CollectionControllerDelegate {
    
    //MARK: - CollectionControllerDelegate
    
    var sections: [Section] {
        return viewModel.sections
    }
    
    func bindSectionController(_ controller: SectionController) {
     
    }
    
    func didScroll(_ scrollView: UIScrollView) {
        //print("Did Scroll")
    }
}
