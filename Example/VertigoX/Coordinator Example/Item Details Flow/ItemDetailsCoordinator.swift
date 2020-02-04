//
//  TestSheetCoordinator.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 29/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Signals
import VertigoX

protocol ItemDetailsModuleFactory {
    func makeItemDetailsModule() -> ItemDetailsModule
    func makeEditItemDetailsModule() -> EditItemDetailsModule 
}

class ItemDetailsCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    var finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
        
    private let moduleFactory: ItemDetailsModuleFactory
    private var coordinatorFactory: CoordinatorFactory
    
    //MARK: - Init
    
    init(router: Router, moduleFactory: ItemDetailsModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }
    
    //MARK: - Start
    
    override func start(with option: DeepLinkType?) {
        showVC()
    }
    
    private func showVC(){
        let module = moduleFactory.makeItemDetailsModule()
        
        module.newPage.subscribe(with: self) { [weak self] _ in
            self?.showEditDetails(fromModule: module)
        }
        
        router.presentSheet(module) {
            self.finishFlow.fire(.normal)
        }
    }
    
    private func showEditDetails(fromModule: Presentable){
        
        let module = moduleFactory.makeEditItemDetailsModule()
        
        router.showModule(module)
    }
}
