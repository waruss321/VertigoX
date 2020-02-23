//
//  TestVC.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 22/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

protocol ConstraintsTestModule: BaseModule {
    
}

final class ConstraintsTestVC: ViewController, ConstraintsTestModule {
    
    //MARK: - UI
    
    private var containerView = UIView(backgroundColor: .blue)
     
    private var label = UITextField(placeholder: "Type in me...", text: "000000")
    
    //MARK: - Configure
 
    override func styleView() {
        
    }
    
    override func setConstraints(frame: CGRect) {
        view.addSubview(containerView)
        containerView.addSubview(label)
        
        containerView.pinSuperviewBottomLeadingTrailing(size: .height(100))
        label.pinSuperviewTopLeadingTrailing(size: .height(50))
        
        
//        containerView.leadingToSuperview(view.leadingAnchor, offset: 3, relation: .equalOrGreater, priority: .required, isActive: true, usingSafeArea: false)
//        containerView.topToBottom(of: <#T##Constrainable#>)
//        containerView.trailingToSuperview(view.trailingAnchor, offset: 3, relation: .equalOrGreater, priority: .defaultHigh, isActive: true, usingSafeArea: false)
        //containerView.centerXToSuperview(priority: .defaultLow)
        //label.edgesToSuperview()
        label.becomeFirstResponder()
    }
    
}
