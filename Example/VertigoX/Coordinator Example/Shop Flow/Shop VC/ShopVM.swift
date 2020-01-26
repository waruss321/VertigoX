//
//  ShopVM.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 25/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX

class ShopVM: CollectionViewModel {
    
    //MARK: - Sections
    
    var sections: [Section] {
        return [fruitSection, techSection, signleSection]
    }
    
    
    
    var fruitSection: SectionController {
        return TestSection(items: [ShopItemModel(title: "Apples"), ShopItemModel(title: "Bananas"), ShopItemModel(title: "Carrots"), ShopItemModel(title: "Leeks"), ShopItemModel(title: "Melons"), ShopItemModel(title: "Pears"), ShopItemModel(title: "Apples"), ShopItemModel(title: "Bananas"), ShopItemModel(title: "Carrots"), ShopItemModel(title: "Leeks"), ShopItemModel(title: "Melons"), ShopItemModel(title: "Pears")])
    }
    
    var techSection: TestSection {
        return TestSection(items: [ShopItemModel(title: "0 Android"), ShopItemModel(title: "1 CPU"), ShopItemModel(title: "2 iPhone"), ShopItemModel(title: "3 Laptop"), ShopItemModel(title: "4 Xbox"), ShopItemModel(title: "5 Apples"), ShopItemModel(title: "6 Bananas"), ShopItemModel(title: "7 Carrots"), ShopItemModel(title: "8 Leeks"), ShopItemModel(title: "9 Melons"), ShopItemModel(title: "10 Pears"), ShopItemModel(title: "11 Apples"), ShopItemModel(title: "12 Bananas"), ShopItemModel(title: "13 Carrots"), ShopItemModel(title: "14 Leeks"), ShopItemModel(title: "15 Melons"), ShopItemModel(title: "16 Pears")])
    }
    
    var signleSection: TestSection {
        return TestSection(items: [ShopItemModel(title: "Android")])
    }

}
