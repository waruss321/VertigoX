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
    
    func makeAddItemCoordinator() -> (coordinator: Coordinator & CoordinatorOutput, toPresent: Presentable) {
        let nav = UINavigationController()
        let coordinator = AddItemCoordinator(router: router(nav), factory: ModuleFactoryImp(), coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, nav)
    }
    
    func makeItemDetailsCoordinator(router: Router) -> Coordinator & CoordinatorOutput {
        return ItemDetailsCoordinator(router: router, moduleFactory: ModuleFactoryImp(), coordinatorFactory: CoordinatorFactoryImp())
    }
    
    func makePushTestCoordinator(router: Router) -> Coordinator & CoordinatorOutput {
        return PushTestCoordinator(router: router, factory: ModuleFactoryImp(), coordinatorFactory: CoordinatorFactoryImp())
    }
    
    private func router(_ navController: UINavigationController) -> Router {
        navController.modalPresentationStyle = .fullScreen
        return RouterImp(rootController: navController)
    }
}
