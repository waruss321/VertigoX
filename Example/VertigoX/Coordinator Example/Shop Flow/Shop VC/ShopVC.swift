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

class ShopVC: ViewController, ShopModule, CollectionControllerDelegate {
    
    var open = VoidSignal()

    //MARK: - Properties

    private let collectionView = UICollectionView(background: .clear)
    private let buttonTest = UIButton(text: "Refresh list", backgroundColor: .lightGray)
    
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
        collectionView.fillSuperview(padding: .padding(left: 30, right: 30), usingSafeArea: false)
    }
    
    override func styleView() {
        view.backgroundColor = .purple
    }

    //MARK: - Bind
    
    override func bindViewModel() {
        collectionController.viewModel = viewModel
    }
    
    override func bindSignals() {
        buttonTest.onTouchUpInside.subscribe(with: self) { _ in
            self.viewModel.test.toggle()
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
                self?.open.fire(())
            }
        }
    }
    
    func didScroll(_ scrollView: UIScrollView) {
        print("scroll")
    }
}

