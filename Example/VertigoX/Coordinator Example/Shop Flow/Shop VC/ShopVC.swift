//
//  ShopVC.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

protocol ShopModule: BaseModule {
    var addItem: VoidSignal { get }
    var logout: VoidSignal { get }
}

class ShopVC: ViewController, ShopModule {
    
    //MARK: - Signals
    
    var addItem = VoidSignal()
    var logout = VoidSignal()
    
    //MARK: - Properties
    
    private let testLabel = UILabel(text: "Welcome to the shop", font: UIFont.boldSystemFont(ofSize: 18), alignment: .center)
    private let addButton = UIButton(text: "Add Item")
    private let logoutButton = UIButton(text: "Logout")
    
    //MARK: - Main View
    
    override func styleView() {
        view.backgroundColor = .cyan
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(testLabel, addButton, logoutButton)
        testLabel.pin(top: view.topSafe, leading: view.leading, trailing: view.trailing,
                      padding: UIEdgeInsets(30))
        
        addButton.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing,
                        padding: UIEdgeInsets(left: 40, bottom: 100, right: 40),
                        size: CGSize(h: 60))
        
        logoutButton.pin(top: view.topSafe, leading: view.leading, padding: UIEdgeInsets(top: 30, left: 30))
    }
    
    //MARK: - Bind
    
    override func bindSignals() {
        addButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.addItem.fire(())
        }
        
        logoutButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.logout.fire(())
        }
    }
}
