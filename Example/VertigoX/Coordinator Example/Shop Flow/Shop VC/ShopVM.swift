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
        return SectionController(items: [ShopItemModel(title: "Apples"), ShopItemModel(title: "Bananas"), ShopItemModel(title: "Carrots"), ShopItemModel(title: "Leeks"), ShopItemModel(title: "Melons"), ShopItemModel(title: "Pears")])
    }
    
    var techSection: TestSection {
        return TestSection(items: [ShopItemModel(title: "Android"), ShopItemModel(title: "CPU"), ShopItemModel(title: "iPhone"), ShopItemModel(title: "Laptop"), ShopItemModel(title: "Xbox")])
    }
    
    var signleSection: TestSection {
        return TestSection(items: [ShopItemModel(title: "Android")])
    }

}
