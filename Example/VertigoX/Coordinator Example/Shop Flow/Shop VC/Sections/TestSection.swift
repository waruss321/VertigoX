//
//  TestSection.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 26/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

final class TestSection: SectionController {
    
    //MARK: - Signals
    
    public var selectedItem = Signal<String>()
    
    //MARK: - Settings
    
    override var margin: CGFloat {
        return 20
    }
    
    override var topPadding: CGFloat {
        return 25
    }
    
    override var estimatedCellHeight: CGFloat {
        return 100
    }
    
    override var shadowOpacity: Float {
        return 0
    }
    
    override var cornerRadiusOption: CornerOptions {
        return .bottom
    }
    
    override var showSeporator: Bool {
        return false
    }
    
    override var cornerRadius: CGFloat {
        return 30
    }
    
    //MARK: - Item
    
    override func didSelectItem(at index: Int) {
        guard let item = items[safe: index] as? ShopItemModel else { return }
        selectedItem.fire(item.title)
    }
    
    override func bindSignalsForItem(_ item: Item){
        if let item = item as? ShopItemModel {
            item.selectedItem.cancelAllSubscriptions()
            item.selectedItem.subscribe(with: self) { value in
                print(value)
            }
        }
    }
}
