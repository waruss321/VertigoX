//
//  WorkoutViewVC.swift
//  WorkoutApp
//
//  Created by Russell Warwick on 28/01/2020.
//  Copyright © 2020 Russell Warwick. All rights reserved.
//

import VertigoX

protocol WorkoutViewModule: BaseSheetModule {
    
}
 
final class WorkoutViewVC: ViewController, WorkoutViewModule, CollectionControllerDelegate {

    //MARK: - Signals

    var sheetDidDismiss = VoidSignal()
    
    //MARK: - Properties
    
    private let collectionView = UICollectionView(background: .clear)
    
    private lazy var collectionController: CollectionController = {
        return CollectionController(viewController: self)
    }()
    
    //MARK: - Dependencies
    
    private let viewModel: WorkoutViewVMProtocol
    
    //MARK: Init
    
    init(viewModel: WorkoutViewVMProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Configure
    
    override func configureView() {
        collectionController.delegate = self
    }
    
    override func styleView() {
        view.backgroundColor = .clear
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(collectionView)
        //collectionView.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing, size: .size(h: 390))
        collectionView.pin(top: view.top, leading: view.leading, bottom: view.bottom, trailing: view.trailing)
        collectionController.target = collectionView
    }

    //MARK: - Bind
    
    override func bindViewModel() {
        collectionController.viewModel = viewModel
    }
    
    //MARK: - CollectionControllerDelegate
    
    func bindSectionController(_ controller: SectionController) {
        
    }
    
    //MARK: - PanModalPresentable
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var panScrollable: UIScrollView? {
        return collectionView
    }

    var topOffset: CGFloat {
        return 0
    }
    

    var shouldRoundTopCorners: Bool {
        return false
    }

    var showDragIndicator: Bool {
        return false
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var allowsExtendedPanScrolling: Bool {
        return true
    }
    
    
}

