//
//  ShopItem.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 25/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

class ShopItemModel: VerticalItem {
    
    let title: String
    
    init(title: String){
        self.title = title
    }
    
    var cellType: AnyClass {
        return ShopItemCell.self
    }
}

class ShopItemCell: VerticalItemCell {
    
    //MARK: - Properties
    
    private let itemLabel = UILabel()
    
    //MARK: - Configure
    
    override func setConstraints(frame: CGRect) {
        view.addSubview(itemLabel)
        itemLabel.fillSuperview(padding: UIEdgeInsets(leading: 10))
        itemLabel.height(35, relation: .greaterThan)
        layoutIfNeeded()
        layoutIfNeeded()
    }
    
    override func styleView() {
        view.backgroundColor = .white
    }
    
    //MARK: - Bind
    
    override func bindViewModel() {
        guard let item = item as? ShopItemModel else { return }
        itemLabel.text = item.title
    }
    
}
