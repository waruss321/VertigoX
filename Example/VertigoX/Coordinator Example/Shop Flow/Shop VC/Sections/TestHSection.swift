//
//  TestHSection.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 18/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

class TestHSection: HorizontalSectionController {
    
    override var itemSpacing: CGFloat {
        return 90
    }
    
    override var height: CGFloat {
        return 200
    }
    
    override var margin: CGFloat {
        return 10
    }
    
    override var leftPadding: CGFloat {
        return 40
    }
    
    override var rightPadding: CGFloat {
        return 90
    }
    
    override func didSelectItem(at index: Int) {
        print(index)
    }
}
