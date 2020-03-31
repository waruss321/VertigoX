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
    
    var estimatedHeight: CGFloat {
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
        guard let _ = item as? ExerciseModel else { return }
        contentView.backgroundColor = .random()
        
    }

}
