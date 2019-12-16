//
//  ShowCoordinator.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX
import Signals

protocol ShopModuleFactory {
    func makeShopModule() -> ShopModule
    func makeAddItemModule() -> AddItemModule
}

class ShopCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    let finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
    
    private let moduleFactory: ShopModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: -
    
    init(router: Router, factory: ShopModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.moduleFactory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start(with option: DeepLinkType?) {
        showShop()
    }
    
    //MARK: - Show Modules
    
    private func showShop(){
        
        let module = moduleFactory.makeShopModule()
        
        module.addItem.subscribe(with: self) { [weak self] in
            self?.showAddItem()
        }
        
        module.logout.subscribe(with: self) { [weak finishFlow] _ in
            finishFlow?.fire(.normal)
        }
        
        router.setRootModule(module)
    }
    
    private func showAddItem(){
        let module = moduleFactory.makeAddItemModule()
        
        module.itemAdded.subscribe(with: self) { [weak router] in
            router?.popModule()
        }
        
        router.push(module)
    }
}
