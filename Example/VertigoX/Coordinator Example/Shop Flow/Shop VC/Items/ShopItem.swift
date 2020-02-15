//
//  ShopItem.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 25/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

struct ShopItemModel: VerticalItem {
    
    //MARK: - Signals
    
    var selectedItem = Signal<String>()
    
    //MARK: - Dependencies
    
    let title: String
    
    //MARK: - Init
    
    init(title: String){
        self.title = title
    }
    
    var cellType: AnyClass {
        return ShopItemCell.self
    }
}

class ShopItemCell: VerticalCell {
    
    //MARK: - Properties
    
    private let itemLabel = UILabel(fontColor: .white)
    private let button = UIButton(text: "++")
    
    //MARK: - Configure
    
    override func setConstraints(frame: CGRect) {
        contentView.addSubviews(itemLabel, button)
        itemLabel.fillSuperview(padding: .padding(left: 10))
        itemLabel.height(55, relation: .greaterThan)
        button.pin(bottom: contentView.bottom, trailing: contentView.trailing,
                   size: .square(30))
        layoutIfNeeded()
    }
    
    override func styleView() {
        backgroundColor = .blue
        contentView.backgroundColor = .black
    }
    
    //MARK: - Bind
    
    private var shopItem: ShopItemModel? {
        return item as? ShopItemModel
    }

    override func bindViewModel() {
        guard let item = shopItem else { return }
        itemLabel.text = item.title
        
        button.onTouchUpInside.cancelAllSubscriptions()
        button.onTouchUpInside.subscribe(with: self) { _ in
            item.selectedItem.fire("Hello from cell")
        }
    }
}
