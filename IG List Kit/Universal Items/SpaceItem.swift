//
//  SpaceItem.swift
//  RussTools
//
//  Created by Russell Warwick on 01/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

open class SpaceModel: VerticalItem {

    let height: CGFloat
    let color: UIColor
    
    init(height: CGFloat, color: UIColor = .white) {
        self.height = height
        self.color = color
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return SpaceCell.self
    }
    
    public var cellHeight: CGFloat {
        return height
    }
}

open class SpaceCell: BaseVerticalItemCell {
    
    private let spaceView = UIView()
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(spaceView)
        spaceView.fillSuperview(size: CGSize(h: 1))
    }
    
    override public func bindViewModel() {
        guard let item = item as? SpaceModel else { return }
        spaceView.setHeight(item.height)
    }
}
