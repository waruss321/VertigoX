//
//  HeaderCell.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 04/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

struct HeaderItem: VerticalItem {

    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return HeaderCell.self
    }
    
    var estimatedHeight: CGFloat {
        return 80
    }
}

final class HeaderCell: VerticalCell {
    
    private let label = UILabel(alignment: .center)
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        label.fillSuperview()
    }
    
    override func styleView() {
        label.backgroundColor = .purple
    }
    
    override public func bindViewModel() {
        guard let item = item as? HeaderItem else { return }
        contentView.backgroundColor = .purple
        label.text = item.title
    }

}
