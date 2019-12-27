//
//  Router.swift
//  VertigoX
//
//  Created by Russell Warwick on 05/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Signals

public protocol Router: Presentable {
    
    //MARK: -

    var onBack: Signal<Presentable?> { get } //We should probably stop using this and try to fade out as we add new features or revisit
    var topModule: Presentable? { get } //We probably shouldn't use this. Have been using to reload data on a previous page.
    
    //MARK: - Present/show & dismiss
    
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, style: UIModalPresentationStyle)
    func presentWithNavigation(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool, onModule presentingModule: Presentable?, completion:  (() -> Void)?)

    func dismissModule(animated: Bool, completion: (() -> Void)?)

    //MARK: - Push & pop
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, onModule presentingModule: Presentable?, completion: (() -> Void)?)
    
    //Not sure what this is doing in here
    func pushViewController(_ vc: UIViewController, hideNavBar: Bool)
    
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool, completion: (() -> Void)?)
    
    //MARK: - Set root of Navigation Controller

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    //MARK: - Bottom Sheet
    
    func presentSheet(_ module: Presentable?, animated: Bool)
    func dismissSheet()
}

public extension Router {
    
    //MARK: - Present/show
    
    func present(_ module: Presentable?, animated: Bool = true){
        self.present(module, animated: animated)
    }
    
    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil){
        self.dismissModule(animated: animated, completion: completion)
    }
    
    //MARK: - Push & pop

    func push(_ module: Presentable?, animated: Bool = true, completion: (() -> Void)? = nil){
        self.push(module, animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool = true, hideBottomBar: Bool = true, completion: (() -> Void)? = nil){
        self.push(module, animated: animated, hideBottomBar: hideBottomBar, completion: completion)
    }

    func push(_ module: Presentable?, onModule presentingModule: Presentable?, completion: (() -> Void)? = nil){
        self.push(module, onModule: presentingModule, completion: completion)
    }
    
    func popModule(animated: Bool = true){
        self.popModule(animated: animated)
    }
    
    func popToRootModule(animated: Bool = true, completion: (() -> Void)? = nil){
        self.popToRootModule(animated: animated, completion: completion)
    }
    
    //MARK: - Bottom sheet
    
    func presentSheet(_ module: Presentable?, animated: Bool = false){
        self.presentSheet(module, animated: animated)
    }
}
