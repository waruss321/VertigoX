//
//  AppDelegateCoordinator.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

enum RussDeepLinks: DeepLinkType {
    case thisIsATest
    
    var memberId: String {
        switch self {
            case .thisIsATest: return "TestId"
        }
    }
}

final class ApplicationCoordinator: BaseCoordinator {
    
    //MARK: - Dependencies

    private let coordinatorFactory: CoordinatorFactory
    
    //MARK: - Init
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }
    
    //MARK: - Start
    
    override func start(with option: DeepLinkType?) {
        runLoginCoordinator(option: option)
    }
    
    //MARK: - Run Flows
    
    private func runLoginCoordinator(option: DeepLinkType?){
    
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        
        coordinator.finishFlow.subscribe(with: self) { [weak self, weak coordinator] _ in
            self?.runShopCoordinator(option: nil)
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
                
        coordinator.start(with: option)
    }

    private func runShopCoordinator(option: DeepLinkType?){
        
        let coordinator = coordinatorFactory.makeShopCoordinator(router: router)
        
        coordinator.finishFlow.subscribe(with: self) { [weak self, weak coordinator] _ in
            self?.start()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        
        coordinator.start(with: option)

    }
}
