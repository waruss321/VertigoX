//
//  RouterImp.swift
//  VertigoX
//
//  Created by Russell Warwick on 05/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Signals
import PanModal

public final class RouterImp: NSObject, Router {

    //MARK: - Dependencies

    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    //MARK: - Init
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
    
    //MARK: - Presentable
    
    public func toPresent() -> UIViewController? {
        return rootController
    }

    //MARK: -

    public var currentController: UIViewController? {
        return UIApplication.topViewController()?.toPresent()
    }

    //MARK: - Set Module To Root Of Navigation Controller

    public func setRootModule(_ module: Presentable?) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: true)
    }
    
    //MARK: - Present Sheets
    
    public func presentSheet(_ module: BaseSheetModule?, completion: (() -> Void)?) {
        if let controller = module?.toSheetPresent() {

            module?.sheetDidDismiss.cancelAllSubscriptions()
            module?.sheetDidDismiss.subscribe(with: self, callback: { _ in
                completion?()
            })

            currentController?.presentPan(controller)
        }
    }
    
    //MARK: - Present Module & Dismiss
    
    public func presentModule(_ module: Presentable?, animated: Bool){
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        currentController?.present(controller, animated: animated, completion: nil)
    }
    
    public func dismissModule(animated: Bool){
        currentController?.dismiss(animated: animated, completion: nil)
    }
    
    //MARK: - Show Module & Pop Navigation Stack
    
    public func showModule(_ module: Presentable?, animated: Bool, completion: (() -> Void)?){
        
        guard let controller = module?.toPresent() else { return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.modalPresentationStyle = .fullScreen
        
        currentController?.show(controller, sender: self)
    }

    public func popModule(animated: Bool)  {
        
        if let poppedViewController = rootController?.popViewController(animated: animated) {
            runCompletion(for: poppedViewController)
        }
        
        //TODO: - Come back to this and when i figure out wtf it's doing, document it properly!!
//        if let topViewController = rootController?.topViewController, let controller = rootController?.popViewController(animated: animated) {
//            onBack.fire(topViewController)
//            runCompletion(for: controller)
//        } else if let controller = rootController?.viewControllers[safe: 0] {
//            onBack.fire(controller)
//            runCompletion(for: controller)
//        } else {
//            onBack.fire(nil)
//        }
    }
    
    public func popToRootModule(animated: Bool){
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
}

extension RouterImp: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else { return }

        runCompletion(for: poppedViewController)
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
