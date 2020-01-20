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
    
}

