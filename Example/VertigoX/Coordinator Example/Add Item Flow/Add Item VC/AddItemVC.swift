//
//  AddItemVC.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

protocol AddItemModule: BaseModule {
    var dismiss: VoidSignal { get }
    var push: VoidSignal { get }
}

class AddItemVC: ViewController, AddItemModule {
    
    //MARK: - Signals
    
    var dismiss = VoidSignal()
    var push = VoidSignal()
    
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
                      padding: .square(30))
        
        animatableButton.pin(top: testLabel.bottom, leading: testLabel.leading, trailing: testLabel.trailing, padding: .padding(top: 10))
        animatableButtonHeightConstraint = animatableButton.setHeight(100)
        
        loginButton.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing,
                        padding: .padding(left: 40, bottom: 100, right: 40),
                        size: .size(h: 60))
    }
    
    //MARK: - Bind
    
    override func bindSignals() {
        loginButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.dismiss.fire(())
        }

        animatableButton.onTouchUpInside.subscribe(with: self) { [weak self, weak animatableButtonHeightConstraint] in
            animatableButtonHeightConstraint?.constant = (animatableButtonHeightConstraint?.constant == 100) ? 400 : 100
            UIViewPropertyAnimator(duration: 1, dampingRatio: 0.3) {
                self?.view.layoutIfNeeded()
            }.startAnimation()
            self?.push.fire(())
        }
    }
}

protocol MoreInfoModule: BaseModule {
    var dismiss: VoidSignal { get }
}

class MoreInfoVC: ViewController, MoreInfoModule {
    
    var dismiss = VoidSignal()
    
    override func styleView() {
        view.backgroundColor = .cyan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss.fire(())
    }
}
