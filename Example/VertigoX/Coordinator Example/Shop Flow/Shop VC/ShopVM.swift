//
//  ShopVM.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 25/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

protocol ShopVMType: CollectionViewModel {
    var test: Bool { get set }
}

class ShopVM: ShopVMType {
    
    //MARK: - ShopVMType
        
    var sections: [Section] {
        if test {
            return [techSection]
        } else {
            return [fruitSection, techSection]
        }
        
    }
    
    var test: Bool = false

    //MARK: - Sections
    
    private var fruitSection: TestHSection {
        return TestHSection(items: [TestHItem(text: "1"), TestHItem(text: "2"), TestHItem(text: "3"), TestHItem(text: "4"), TestHItem(text: "5")])
    }
    
    private var techSection: TestSection {
        return TestSection(items: [ShopItemModel(title: "0 Android"), ShopItemModel(title: "1 CPU"), ShopItemModel(title: "2 iPhone"), ShopItemModel(title: "3 Laptop"), ShopItemModel(title: "4 Xbox"), ShopItemModel(title: "5 Apples"), ShopItemModel(title: "6 Bananas"), ShopItemModel(title: "7 Carrots"), ShopItemModel(title: "8 Leeks"), ShopItemModel(title: "9 Melons"), ShopItemModel(title: "10 Pears"), ShopItemModel(title: "11 Apples"), ShopItemModel(title: "12 Bananas"), ShopItemModel(title: "13 Carrots"), ShopItemModel(title: "14 Leeks"), ShopItemModel(title: "15 Melons"), ShopItemModel(title: "16 Pears")])
    }
}



