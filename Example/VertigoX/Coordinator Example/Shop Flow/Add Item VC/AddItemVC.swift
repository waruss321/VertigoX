//
//  AddItemVC.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

protocol AddItemModule: BaseModule {
    var itemAdded: VoidSignal { get }
}

class AddItemVC: ViewController, AddItemModule {
    
    var itemAdded = VoidSignal()
    
    let testLabel = UILabel(text: "Please add a item", alignment: .center)
    let loginButton = UIButton(text: "Save")
    
    
    override func styleView() {
        view.backgroundColor = .yellow
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(testLabel, loginButton)
        testLabel.pin(top: view.topSafe, leading: view.leading, trailing: view.trailing,
                      padding: UIEdgeInsets(30))
        
        loginButton.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing,
                        padding: UIEdgeInsets(left: 40, bottom: 100, right: 40),
                        size: CGSize(h: 60))
    }
    
    override func bindSignals() {
        loginButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.itemAdded.fire(())
        }
    }
}
