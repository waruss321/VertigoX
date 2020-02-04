//
//  CoordinatorFactory.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

protocol CoordinatorFactory {
    func makeLoginCoordinator(router: Router) -> Coordinator & CoordinatorOutput
    func makeShopCoordinator(router: Router) -> Coordinator & CoordinatorOutput
    func makeAddItemCoordinator() -> (coordinator: Coordinator & CoordinatorOutput, toPresent: Presentable)
    func makeItemDetailsCoordinator(router: Router) -> Coordinator & CoordinatorOutput
    func makePushTestCoordinator(router: Router) -> Coordinator & CoordinatorOutput
}

//If you want to push onto a new NavigationController then don't pass a router and create a new one with router(nav)
