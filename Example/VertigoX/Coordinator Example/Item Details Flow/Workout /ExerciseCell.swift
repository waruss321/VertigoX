//
//  ExerciseCell.swift
//  WorkoutApp
//
//  Created by Russell Warwick on 07/02/2020.
//  Copyright © 2020 Russell Warwick. All rights reserved.
//

import VertigoX

struct ExerciseModel: VerticalItem {

    public let test: String
    
    public init(test: String) {
        self.test = test
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return ExerciseCell.self
    }
    
    public var cellHeight: CGFloat {
        return 120
    }
}

final class ExerciseCell: VerticalCell {
    
    private let spaceView = UIView(backgroundColor: .red)
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(spaceView)
        
        spaceView.pin(top: contentView.top, leading: contentView.leading, bottom: contentView.bottom, trailing: contentView.trailing)

        ///spaceView.fillSuperview()
    }
    
    override public func bindViewModel() {
        guard let item = item as? ExerciseModel else { return }
        contentView.backgroundColor = .random()
        
    }

}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: CGFloat(1.0))
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
