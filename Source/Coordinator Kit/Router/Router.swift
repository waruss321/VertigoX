//
//  Router.swift
//  VertigoX
//
//  Created by Russell Warwick on 05/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Signals
import PanModal

public protocol Router: Presentable {
    
    //MARK: -

    var currentController: UIViewController? { get }
    
    //MARK: - Set Module To Root Of Navigation Controller

    func setRootModule(_ module: Presentable?)
    
    //MARK: - Present Sheets
    
    func presentSheet(_ module: BaseSheetModule?, completion: (() -> Void)?)
    
    //MARK: - Present Module & Dismiss
    
    func presentModule(_ module: Presentable?, animated: Bool)
    
    func dismissModule(animated: Bool)
    
    //MARK: - Show Module & Pop Navigation Stack
    
    func showModule(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
    
}

public extension Router {
    
    //MARK: - Present Module & Dismiss
    
    func presentModule(_ module: Presentable?, animated: Bool = true){
        self.presentModule(module, animated: animated)
    }
    
    func dismissModule(animated: Bool = true){
        self.dismissModule(animated: animated)
    }
    
    //MARK: - Show Module & Pop Navigation Stack
    
    func showModule(_ module: Presentable?, animated: Bool = true, completion: (() -> Void)? = nil){
        self.showModule(module, animated: animated, completion: completion)
    }

    func popModule(animated: Bool = true){
        self.popModule(animated: animated)
    }
    
    func popToRootModule(animated: Bool = true){
        self.popToRootModule(animated: animated)
    }
}
