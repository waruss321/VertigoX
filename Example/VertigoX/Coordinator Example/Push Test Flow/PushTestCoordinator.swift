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
    func makePushTestModule() -> PushTestModule
}

class PushTestCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    let finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
    
    private let moduleFactory: PushTestModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: -
    
    init(router: Router, factory: PushTestModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.moduleFactory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start(with option: DeepLinkType?) {
        showMain()
    }
    
    private func showMain(){
        let module = moduleFactory.makePushTestModule()
           
        module.push.subscribe(with: self) { _ in
            self.showNext()
        }
           
        router.setRootModule(module)
    }
    
    private func showNext(){
        let module = moduleFactory.makePushTestModule()
           
        module.push.subscribe(with: self) { _ in
            self.showNext()
        }
        
        module.popToLast.subscribe(with: self) { _ in
            self.router.popModule()
        }
        
        module.popToRoot.subscribe(with: self) { _ in
            self.router.popToRootModule()
        }
           
        router.showModule(module) {
            print("Popped")
        }
    }
}

