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
    
    //MARK: - Signals
    
    var itemAdded = VoidSignal()
    
    //MARK: - Propreties
    
    private let testLabel = UILabel(text: "Please add a item", alignment: .center)
    private let animatableButton = UIButton(text: "Change my height ??!", backgroundColor: .green)
    private let loginButton = UIButton(text: "Save")
    
    //MARK: - Main View
    
    override func styleView() {
        view.backgroundColor = .yellow
    }
    
    private var animatableButtonHeightConstraint: NSLayoutConstraint? = nil
    
    override func setConstraints(frame: CGRect) {
        view.addSubviews(testLabel, animatableButton, loginButton)
        testLabel.pin(top: view.topSafe, leading: view.leading, trailing: view.trailing,
                      padding: UIEdgeInsets(30))
        
        animatableButton.pin(top: testLabel.bottom, leading: testLabel.leading, trailing: testLabel.trailing, padding: UIEdgeInsets(top: 10))
        animatableButtonHeightConstraint = animatableButton.height(100)
        
        loginButton.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing,
                        padding: UIEdgeInsets(left: 40, bottom: 100, right: 40),
                        size: CGSize(h: 60))
    }
    
    //MARK: - Bind
    
    override func bindSignals() {
        loginButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.itemAdded.fire(())
        }
        
        animatableButton.onTouchUpInside.subscribe(with: self) { [weak self, weak animatableButtonHeightConstraint] in
            animatableButtonHeightConstraint?.constant = (animatableButtonHeightConstraint?.constant == 100) ? 400 : 100
            UIViewPropertyAnimator(duration: 1, dampingRatio: 0.3) {
                self?.view.layoutIfNeeded()
            }.startAnimation()
        }
    }
}
