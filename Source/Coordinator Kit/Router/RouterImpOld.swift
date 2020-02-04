//
//  RouterImpOld.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 04/02/2020.
//

import Foundation
/*
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
         return UIApplication.topViewController()
     }
          
     //MARK: - Sheets
     
     public func presentSheet(_ module: BaseSheetModule?, completion: (() -> Void)?){
         if let controller = module?.toSheetPresent() {
        
             module?.sheetDidDismiss.cancelAllSubscriptions()
             module?.sheetDidDismiss.subscribe(with: self, callback: { _ in
                 completion?()
             })
             
             topModule?.toPresent()?.presentPan(controller)
         }
     }
     
     public func pushSheet(_ module: BaseSheetModule?, completion: (() -> Void)?){
         if let controller = module?.toSheetPresent() {
         
              module?.sheetDidDismiss.cancelAllSubscriptions()
              module?.sheetDidDismiss.subscribe(with: self, callback: { _ in
                  completion?()
              })
             
              topModule?.toPresent()?.pushPan(controller)
          }
     }
     
     //MARK: - Present/show

     public func present(_ module: Presentable?, animated: Bool) {
         guard let controller = module?.toPresent() else { return }
         controller.modalPresentationStyle = .fullScreen
         topModule?.toPresent()?.present(controller, animated: animated, completion: nil)
     }
     
     public func present(_ module: Presentable?, style: UIModalPresentationStyle) {
         guard let controller = module?.toPresent() else { return }
         controller.modalPresentationStyle = style
         topModule?.toPresent()?.present(controller, animated: true, completion: nil)
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
     
     public func showModule(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
         guard let controller = module?.toPresent(), (controller is UINavigationController == false)
                 else { assertionFailure("Deprecated push UINavigationController."); return }
         
         if let completion = completion {
             completions[controller] = completion
         }
         
         controller.modalPresentationStyle = .fullScreen
         
         topModule?.toPresent()?.show(controller, sender: self)
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
 }

 extension RouterImp: UINavigationControllerDelegate {
     
     private func runCompletion(for controller: UIViewController) {
         guard let completion = completions[controller] else { return }
         completion()
         print(runCompletion)
         completions.removeValue(forKey: controller)
     }
     
     public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            
         guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else { return }
            
         runCompletion(for: poppedViewController)
     }
 }

 extension UIApplication {
     class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
         if let nav = base as? UINavigationController {
             return topViewController(base: nav.visibleViewController)
         }
         if let tab = base as? UITabBarController {
             if let selected = tab.selectedViewController {
                 return topViewController(base: selected)
             }
         }
         if let presented = base?.presentedViewController {
             return topViewController(base: presented)
         }
         return base
     }
 }

 */
