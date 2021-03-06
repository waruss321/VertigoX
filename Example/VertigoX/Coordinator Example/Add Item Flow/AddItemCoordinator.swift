//
//  AddItemCoordinator.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 13/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

protocol AddItemModuleFactory {
    func makeAddItemModule() -> AddItemModule
    func makeMoreInfo() -> MoreInfoModule
}

class AddItemCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    let finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
    
    private let moduleFactory: AddItemModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: -
    
    init(router: Router, factory: AddItemModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.moduleFactory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start(with option: DeepLinkType?) {
        showAddItem(setRoot: true)
    }
    
    //MARK: - Show Modules
    
    private func showAddItem(setRoot: Bool = false){
        let module = moduleFactory.makeAddItemModule()
        
        module.dismiss.subscribe(with: self) { [weak finishFlow] in
            finishFlow?.fire(.normal)
        }
        
        module.push.subscribe(with: self) { [weak self] _ in
            self?.showMoreInfo()
        }
        
        router.setRootModule(module)
    }
    
    private func showMoreInfo(){
        let module = moduleFactory.makeMoreInfo()
        
        
        module.dismiss.subscribe(with: self) { [weak finishFlow]_ in
            finishFlow?.fire(.normal)
        }
        
        router.showModule(module) {
            print("Popped by self")
        }
    }
}
