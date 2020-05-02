//
//  TestHItem2.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 02/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

public struct TestHItem2: HorizontalItem {
    
    let text: String
    
    var didTapOptions = VoidSignal()
    
    init(text: String) {
        self.text = text
    }

    public var size: CGSize {
        return .size(w: 30, h: 120)
    }
    
    public var cellType: AnyClass {
        return TestHCell2.self
    }
}

private final class TestHCell2: HorizontalCell {
    
    private let spaceView = UIView()
    private let label = UILabel(alignment: .center)
    private let options = UIButton(text: "options")
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubviews(spaceView, label, options)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        spaceView.fillSuperview()
        
        label.fill(spaceView)
        options.pinSuperviewTopTrailing()
    }
    
    override public func bindViewModel() {
        guard let item = item as? TestHItem2 else { return }
        spaceView.backgroundColor = .random()
        label.text = item.text
        
        spaceView.setSize(item.size)
        
        options.onTouchUpInside.newSubscribe(with: self) { _ in
            item.didTapOptions.fire()
        }
    }
}
