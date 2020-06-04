//
//  LargeImages.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 04/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

struct LargeImageItem: HorizontalItem {

    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    var cellType: AnyClass {
       return LargeImageCell.self
    }
    
    var size: CGSize {
        return .square(180)
    }
}

final class LargeImageCell: HorizontalCell {
    
    private let label = UILabel(alignment: .center)
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        label.fillSuperview(padding: .square(9))
    }
    
    override func styleView() {
        label.backgroundColor = .yellow
    }
    
    override public func bindViewModel() {
        guard let item = item as? LargeImageItem else { return }
        contentView.backgroundColor = .black
        label.text = item.title
    }

}

