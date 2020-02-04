//
//  PushTestVC.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 04/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

protocol PushTestModule: BaseModule {
    var addItemSig: VoidSignal { get }
    var push: VoidSignal { get }
    var popToLast: VoidSignal { get }
    var popToRoot: VoidSignal { get }
}

class PushTestVC: ViewController, PushTestModule {
    
    var addItemSig = VoidSignal()
    var push = VoidSignal()
    var popToLast = VoidSignal()
    var popToRoot = VoidSignal()

    let vertStack = UIStackView(axis: .vertical)
    
    let addItemButton = UIButton(text: "Add Item")
    let button = UIButton(text: "Push to next VC")
    let popButton = UIButton(text: "Go back")
    let popRootButton = UIButton(text: "Pop to root")

    override func setConstraints(frame: CGRect) {
        view.addSubviews(vertStack)
        vertStack.fillSuperview()
        
        vertStack.addArrangedSubviews(addItemButton, button, popButton, popRootButton)
        
        addItemButton.addTarget(self, action: #selector(addItemAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(pushNext), for: .touchUpInside)
        popButton.addTarget(self, action: #selector(popToLastAct), for: .touchUpInside)
        popRootButton.addTarget(self, action: #selector(popToRootAct), for: .touchUpInside)
    }
    
    @objc func pushNext(){
        push.fire(())
    }
    
    @objc func popToLastAct(){
        popToLast.fire(())
    }
    
    @objc func popToRootAct(){
        popToRoot.fire(())
    }
    
    @objc func addItemAction(){
        addItemSig.fire(())
    }
}


