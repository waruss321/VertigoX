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
        //let nav = UINavigationController()
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
    
    private func router(_ navController: UINavigationController) -> Router {
        navController.modalPresentationStyle = .fullScreen
        return RouterImp(rootController: navController)
    }
}
