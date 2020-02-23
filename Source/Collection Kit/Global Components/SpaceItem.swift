//
//  SpaceItem.swift
//  VertigoX
//
//  Created by Russell Warwick on 01/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public struct SpaceModel: VerticalItem {

    public let height: CGFloat
    public let color: UIColor
    
    public init(height: CGFloat, color: UIColor = .white) {
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

public final class SpaceCell: VerticalCell {
    
    private let spaceView = UIView()
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(spaceView)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        spaceView.fillSuperview()
    }
    
    override public func bindViewModel() {
        guard let item = item as? SpaceModel else { return }
        spaceView.setHeight(item.height)
        spaceView.backgroundColor = item.color
    }

}
