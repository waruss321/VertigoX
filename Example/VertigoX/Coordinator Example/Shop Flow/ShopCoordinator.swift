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
    
    //MARK: - Run Flows
    
    private func runAddItemCoordinator(){
        let (coordinator, module) = coordinatorFactory.makeAddItemCoordinator()
        
        coordinator.finishFlow.subscribe(with: self) { [weak self, weak coordinator] _ in
            self?.removeDependency(coordinator)
            self?.router.dismissModule()
        }
        
        addDependency(coordinator)
        
        coordinator.start()

        router.present(module)
        
    }
    
    //MARK: - Show Modules
    
    private func showShop(){
        
        let module = moduleFactory.makeShopModule()
        
//        module.addItem.subscribe(with: self) { [weak self] in
//            self?.runAddItemCoordinator()
//        }
//
//        module.logout.subscribe(with: self) { [weak finishFlow] _ in
//            finishFlow?.fire(.normal)
//        }
//
        router.setRootModule(module)
    }
}
