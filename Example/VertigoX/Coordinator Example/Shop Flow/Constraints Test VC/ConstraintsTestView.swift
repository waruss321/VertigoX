//
//  ConstraintsTestView.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 01/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

final class ConstraintsTestView: View {
    
    let big = UIButton(backgroundColor: .red)
    let testLabel = UILabel(backgroundColor: .purple)
    let button = UIButton(text: "Push me")
    
    override func setConstraints(frame: CGRect) {
        addSubviews(big, button)
        
        big.center(self)
        
        big.setSize(.square(90))
        
        button.pinSuperviewBottomLeadingTrailing()
        
    }
    
    
}
