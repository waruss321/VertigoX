//
//  RouterImp.swift
//  VertigoX
//
//  Created by Russell Warwick on 05/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Signals
import FittedSheets

public final class RouterImp: NSObject, Router {
    
    //MARK: - Signals
    
    public let onBack = Signal<Presentable?>()
    
    //MARK: -
        
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]

    //MARK: - Init
        
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
    
    public func toPresent() -> UIViewController? {
        return rootController
    }

    public var topModule: Presentable? {
        return self.rootController?.topViewController
    }
    
    //MARK: - Present/show

    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func presentWithNavigation(_ module: Presentable?){
        guard let controller = module?.toPresent() else { return }
        let nav = UINavigationController(rootViewController: controller)
        rootController?.present(nav, animated: true, completion: nil)
    }
    
    public func present(_ module: Presentable?, style: UIModalPresentationStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = style
        rootController?.present(controller, animated: true, completion: nil)
    }

    public func present(_ module: Presentable?, animated: Bool, onModule presentingModule: Presentable?, completion: (() -> Void)?) {
        guard let controller = module?.toPresent(), let presentingModule = presentingModule?.toPresent() else { return }
        presentingModule.present(controller, animated: animated, completion: completion)
    }

    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        
        //Not sure what this is doing. Should investigate
        if let presented = topModule?.toPresent()?.presentedViewController {
            onBack.fire(nil)
            presented.dismiss(animated: animated, completion: completion)
        } else {
            onBack.fire(nil)
            rootController?.dismiss(animated: animated, completion: completion)
        }
    }
    

    //MARK: - Push & pop
    
    public func pushViewController(_ vc: UIViewController, hideNavBar: Bool) {
        rootController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    public func push(_ module: Presentable?, animated: Bool = true, completion: (() -> Void)? = nil) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    public func push(_ module: Presentable?, animated: Bool = true, hideBottomBar: Bool, completion: (() -> Void)? = nil) {
        guard let controller = module?.toPresent(), (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
    
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }

    public func push(_ module: Presentable?, onModule presentingModule: Presentable?, completion: (() -> Void)?){
        
        guard let module = module, let controller = presentingModule?.toPresent(), (controller is UINavigationController == false) else { assertionFailure("Deprecated push UINavigationController."); return }
        guard let moduleToPresent = module.toPresent() else { return }

        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.show(moduleToPresent, sender: presentingModule)
    }
    
    public func popModule(animated: Bool)  {
        if let topViewController = rootController?.topViewController, let controller = rootController?.popViewController(animated: animated) {
            onBack.fire(topViewController)
            runCompletion(for: controller)
        } else if let controller = rootController?.viewControllers[safe: 0] {
            onBack.fire(controller)
            runCompletion(for: controller)
        } else {
            onBack.fire(nil)
        }
    }

    public func popToRootModule(animated: Bool, completion: (() -> Void)?) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
            completion?()
        }
    }
    
    
    //MARK: - Set root of Navigation Controller
    
    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    public func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    
    //MARK: - Bottom Sheet
    
    public var currentSheetVC: SheetViewController?

    public func presentSheet(_ module: Presentable?, animated: Bool){
        if let vc = module?.toPresent() {
            let sheetVC = SheetViewController(controller: vc)
            sheetVC.topCornersRadius = 15
            sheetVC.adjustForBottomSafeArea = false
            sheetVC.extendBackgroundBehindHandle = false
            self.currentSheetVC = sheetVC
            rootController?.present(sheetVC, animated: animated, completion: nil)
        }
    }
    
    public func dismissSheet(){
        if let sheetViewController = topModule?.toPresent()?.presentedViewController as? SheetViewController {
            sheetViewController.dismiss(animated: true)
        } else {
            rootController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension RouterImp: UINavigationControllerDelegate {
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
           
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else { return }
           
        runCompletion(for: poppedViewController)
    }
}
