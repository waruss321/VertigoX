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
    
    private var contentView = ConstraintsTestView()
    
    //MARK: - Configure

    override func setView() -> UIView {
        return contentView
    }
    
    override func bindViewModel() {
        contentView.testLabel.text = "Hello"
        
    }
    
    override func bindSignals() {

    }
}
