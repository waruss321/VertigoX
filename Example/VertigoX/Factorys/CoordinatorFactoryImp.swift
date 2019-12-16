//
//  CoordinatorFactoryImp.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeLoginCoordinator(router: Router) -> Coordinator & CoordinatorOutput {
        return LoginCoordinator(router: router, factory: ModuleFactoryImp(), coordinatorFactory: CoordinatorFactoryImp())
    }
    
    func makeShopCoordinator(router: Router) -> Coordinator & CoordinatorOutput {
        return ShopCoordinator(router: router, factory: ModuleFactoryImp(), coordinatorFactory: CoordinatorFactoryImp())
    }
}
