//
//  BaseCoordinator.swift
//  VertigoX
//
//  Created by Russell Warwick on 21/06/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

/* DOCS
 • Use show to show a view controller
 • Use runFlow to start a new coordinator
 */

import UIKit

open class BaseCoordinator: Coordinator {
        
    public var childCoordinators: [Coordinator] = []
    
    public var router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    open func toPresent() -> UIViewController? {
        return router.toPresent()
    }
  
    open func start() {
        start(with: nil)
    }
    
    open func start(with option: DeepLinkType?) { }
  
    // add only unique object
    public func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    public func removeAllDependencies() {
        for childCoordinator in self.childCoordinators {
            childCoordinator.removeAllDependencies()
        }
        self.childCoordinators = []
    }
  
    public func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
