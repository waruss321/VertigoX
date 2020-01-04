//
//  AppDelegate.swift
//  RussTools
//
//  Created by Russell Warwick on 19/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var applicationCoordinator: Coordinator = makeCoordinator()
    
    var rootController: UINavigationController {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController()
        self.window?.makeKeyAndVisible()
        return self.window!.rootViewController as! UINavigationController
    }
    
    //MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start(with: nil)
        return true
    }

    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: RouterImp(rootController: rootController), coordinatorFactory: CoordinatorFactoryImp())
    }
}
