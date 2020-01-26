//
//  SpaceItem.swift
//  VertigoX
//
//  Created by Russell Warwick on 01/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public struct SpaceModel: VerticalItem {

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

public final class SpaceCell: VerticalItemCell {
    
    private let spaceView = UIView()
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(spaceView)
        spaceView.fillSuperview(size: CGSize(h: 1))
    }
    
    override public func bindViewModel() {
        guard let item = item as? SpaceModel else { return }
        spaceView.height(item.height)
    }

}
