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
        return 50
    }
    
    override var topPadding: CGFloat {
        return 40
    }
    
    override var estimatedCellHeight: CGFloat {
        return 55
    }
    
    override var showSeporator: Bool {
        return true
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
