//
//  TestHItem.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 18/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

public struct TestHItem: HorizontalItem {
    
    let text: String
    
    var didTapOptions = VoidSignal()
    
    init(text: String) {
        self.text = text
    }

    public var size: CGSize {
        return .size(w: 180, h: 180)
    }
    
    public var cellType: AnyClass {
        return TestHCell.self
    }
}

private final class TestHCell: HorizontalCell {
    
    private let spaceView = UIView()
    private let label = UILabel(alignment: .center)
    private let options = UIButton(text: "options")
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubviews(spaceView, label, options)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        spaceView.fillSuperview()
        spaceView.setSize(.size(w: 180, h: 180))
        label.fill(spaceView)
        options.pinSuperviewTopTrailing()
    }
    
    override public func bindViewModel() {
        guard let item = item as? TestHItem else { return }
        spaceView.backgroundColor = .random()
        label.text = item.text
        
        options.onTouchUpInside.newSubscribe(with: self) { _ in
            item.didTapOptions.fire()
        }
    }
}
