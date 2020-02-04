//
//  PushTestCoordinator.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 04/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

protocol PushTestModuleFactory {
    func makeShopModule() -> ShopModule
}

class PushTestCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    let finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
    
    private let moduleFactory: ShopModuleFactory & LoginModuleFactory & AddItemModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: -
    
    init(router: Router, factory: ShopModuleFactory & LoginModuleFactory & AddItemModuleFactory, coordinatorFactory: CoordinatorFactory) {
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

        router.showModule(module)
        
    }
    
    //MARK: - Show Modules
    
    private func showShop(){
        
        let module = moduleFactory.makeShopModule()
        
        module.open.subscribe(with: self) { _ in
            self.runItemDetailsFlow()
     
        }
        
        router.setRootModule(module)
    }
    
    private func runItemDetailsFlow(){
        
        let coordinator = coordinatorFactory.makeItemDetailsCoordinator(router: router)
        
        coordinator.finishFlow.subscribe(with: self) { [weak coordinator] _ in
            self.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        
        coordinator.start()

    }
}

