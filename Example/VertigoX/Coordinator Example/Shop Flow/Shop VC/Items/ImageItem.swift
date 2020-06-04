//
//  ImageItem.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 04/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

struct ImageItem: HorizontalItem {

    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    var cellType: AnyClass {
       return ImageCell.self
    }
    
    var size: CGSize {
        return .square(100)
    }
}

final class ImageCell: HorizontalCell {
    
    private let label = UILabel(alignment: .center)
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        label.fillSuperview(padding: .square(5))
    }
    
    override func styleView() {
        label.backgroundColor = .red
    }
    
    override public func bindViewModel() {
        guard let item = item as? ImageItem else { return }
        contentView.backgroundColor = .cyan
        label.text = item.title
    }
}
