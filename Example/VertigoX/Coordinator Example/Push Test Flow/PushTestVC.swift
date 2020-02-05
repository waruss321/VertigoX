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
    
    //MARK: - PushTestModule
    
    var addItemSig = VoidSignal()
    var push = VoidSignal()
    var popToLast = VoidSignal()
    var popToRoot = VoidSignal()

    //MARK: -
    
    private let addItemButton = UIButton(text: "Add Item")
    private let button = UIButton(text: "Push to next VC")
    private let popButton = UIButton(text: "Go back")
    private let popRootButton = UIButton(text: "Pop to root")
    
    override func configureView() {
        navigationController?.navigationBar.isHidden = true
    }

    override func setConstraints(frame: CGRect) {
        view.stack(addItemButton, button, popButton, popRootButton, distribution: .fillEqually)
                
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


