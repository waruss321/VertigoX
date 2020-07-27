//
//  HorizontalItem.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 15/04/2020.
//

import UIKit

public protocol HorizontalItem: Item {
    var size: CGSize { get }
}

open class HorizontalCell: UICollectionViewCell, ViewTemplate {
    
    //MARK: - Public
    
    public var item: HorizontalItem? {
        didSet {
            bindViewModel()
        }
    }
    
    //MARK: - Configure
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.fillSuperview() //This needs to happen otherwise the cell will not adjust to auto size
        run(frame: frame)
    }

    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    open func configureView(){}
    open func setConstraints(frame: CGRect){}
    open func styleView(){}

    open func bindViewModel() {}
    open func bind(){}
}
