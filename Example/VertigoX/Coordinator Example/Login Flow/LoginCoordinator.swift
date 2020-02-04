//
//  LoginCoordinator.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX
import Signals
import PanModal

protocol LoginModuleFactory {
    func makeLoginModule() -> LoginModule
}

class LoginCoordinator: BaseCoordinator, CoordinatorOutput {
    
    //MARK: - Signals
    
    let finishFlow = Signal<CoordinatorOutputResult>()
    
    //MARK: - Dependencies
    
    private let moduleFactory: LoginModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: -
    
    init(router: Router, factory: LoginModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.moduleFactory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start(with option: DeepLinkType?) {
        if let deepLinks = option as? RussDeepLinks {
            switch deepLinks {
                case .thisIsATest: print(deepLinks.memberId)
            }
        }
        
        showLoginModule()
    }
    
    //MARK: - Show Modules
    
    private func showLoginModule(){
    
        let module = moduleFactory.makeLoginModule()
        
        module.loggedIn.subscribe(with: self) { [weak finishFlow] _ in
            finishFlow?.fire(.normal)
        }
        
        router.setRootModule(module)
    }
}
