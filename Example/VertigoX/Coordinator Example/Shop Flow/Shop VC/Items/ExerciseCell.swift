//
//  ExerciseCell.swift
//  WorkoutApp
//
//  Created by Russell Warwick on 07/02/2020.
//  Copyright © 2020 Russell Warwick. All rights reserved.
//

import VertigoX

struct ExerciseItem: VerticalItem {

    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return ExerciseCell.self
    }
    
    var estimatedHeight: CGFloat {
        return 100
    }    
}

final class ExerciseCell: VerticalCell {
    
    private let label = UILabel(alignment: .center, backgroundColor: .random())
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = .black
        label.fillSuperview(padding: .square(5))
    }
    
    override func styleView() {
        //label.backgroundColor = .blue
    }
    


}







///



struct HTestItem: VerticalItem {

   public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    //MARK: - VerticalItem

    public var cellType: AnyClass {
       return HTestCell.self
    }
    
    var estimatedHeight: CGFloat {
        return 100
    }

}

final class HTestCell: VerticalCell {
    
//    //MARK: - UI
//
//    private let label = UILabel(alignment: .center, backgroundColor: .random())
//
//    //MARK: -
//
////    lazy var loaderSection: HorizontalLoaderSection = HorizontalLoaderSection(items: [], itemSpacing: item.itemSpacing, padding: item.padding)
//
//
//    private var heightConstraint: NSLayoutConstraint? = nil
//
//    //MARK: - Configure
//
//    let test = UILabel(text: "This is a horizontal cell")
//
//    override public func setConstraints(frame: CGRect) {
//        super.setConstraints(frame: frame)
//        print("HorizontalLoaderItem setConstraints")
//        contentView.addSubviews(label)
//        label.fillSuperview(padding: .square(10))
//
//    }
    
    private let label = UILabel(alignment: .center, backgroundColor: .random())
    
    override public func setConstraints(frame: CGRect) {
        super.setConstraints(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = .red
        label.fillSuperview(padding: .square(20))
    }
    
    override func styleView() {
        //label.backgroundColor = .blue
    }
    
        
   
}


