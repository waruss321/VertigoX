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
    private let buttonTest = UIButton(text: "Scroll to", backgroundColor: .lightGray)
    
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
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(collectionView, buttonTest)
        collectionView.pin(top: view.topSafe, leading: view.leadingAnchor, bottom: buttonTest.top, trailing: view.trailing)
        buttonTest.pin(leading: view.leading, bottom: view.bottomSafe, trailing: view.trailing,
                       size: CGSize(h: 40))
    }
    
    override func styleView() {
        view.backgroundColor = .white
    }

    //MARK: - Bind
    
    override func bindViewModel() {
        collectionController.sections = viewModel.sections
    }
    
    override func bindSignals() {
        buttonTest.onTouchUpInside.subscribe(with: self) { _ in
            self.collectionController.sections = self.viewModel.sections
        }
    }
    
    private func scrollToIndex(){
        //This only works properly if automatic size = false, or
        //If you're using a fixed height cell and height is same within SectionController
        self.collectionController.target?.scrollToItem(at: IndexPath(item: 4, section: 1), at: .top, animated: true)
    }
    
    //MARK: - CollectionControllerDelegate
    
    func bindSectionController(_ controller: SectionController) {
        if let controller = controller as? TestSection {
            controller.selectedItem.cancelAllSubscriptions()
            
            controller.selectedItem.subscribe(with: self) { [weak self] title in
                self?.buttonTest.setText(title)
            }
        }
    }
}
