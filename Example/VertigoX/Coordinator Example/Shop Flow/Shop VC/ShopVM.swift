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
            return [fruitSection]
        }
        
    }
    
    var test: Bool = false

    //MARK: - Sections
    
    private var fruitSection: HorizontalSection {

        let itemsTest: [HorizontalItem] = [TestHItem(text: "1"), TestHItem(text: "2"), TestHItem(text: "2"), TestHItem(text: "3"), TestHItem(text: "4"), TestHItem(text: "5")]

        let section = HorizontalSection(items: itemsTest, itemSpacing: 50, pagingEnabled: true, padding: .padding(left: 25, right: 25), topSpacing: 30)
        
        section.didChangePage = { [weak self] index in
            print("Did change page \(index)")
        }
        
        return section
     }
    
    
    private var fruitSection2: VerticalSection {

        let itemsTest = [TestHItem(text: "1"), TestHItem(text: "2"), TestHItem(text: "3"), TestHItem(text: "4"), TestHItem(text: "5")]
        
        
        var horizontalItem = HorizontalLoaderItem(items: itemsTest, itemSpacing: 20, padding: .padding(left: 24, right: 24))
        
   
        
        
        return VerticalSection(items: [horizontalItem])
    }
    
    
    private var fruitSection3: VerticalSection {

         let itemsTest = [TestHItem2(text: "1"), TestHItem2(text: "2"), TestHItem2(text: "3"), TestHItem2(text: "4"), TestHItem2(text: "5")]
         
         
         var horizontalItem = HorizontalLoaderItem(items: itemsTest, itemSpacing: 20, padding: .padding(left: 24, right: 24))
         
    
         
         
         return VerticalSection(items: [horizontalItem])
     }
    
    private var techSection: TestSection {
        let section = TestSection(items: [ShopItemModel(title: "0 Android"), ShopItemModel(title: "1 CPU"), ShopItemModel(title: "2 iPhone"), ShopItemModel(title: "3 Laptop"), ShopItemModel(title: "4 Xbox"), ShopItemModel(title: "5 Apples"), ShopItemModel(title: "6 Bananas"), ShopItemModel(title: "7 Carrots"), ShopItemModel(title: "8 Leeks"), ShopItemModel(title: "9 Melons"), ShopItemModel(title: "10 Pears"), ShopItemModel(title: "11 Apples"), ShopItemModel(title: "12 Bananas"), ShopItemModel(title: "13 Carrots"), ShopItemModel(title: "14 Leeks"), ShopItemModel(title: "15 Melons"), ShopItemModel(title: "16 Pears")])
        
        section.didSelectItem = { item in
            print(item)
        }
        
        return section
    }
}



struct DiscoveryHeaderItem: HorizontalItem {
    
    let category: Category
    
    //MARK: - HorizontalItem
    
    var size: CGSize {
        return .square(110)
    }
    
    var cellType: AnyClass {
        return DiscoveryHeaderCell.self
    }
}


fileprivate class DiscoveryHeaderCell: HorizontalCell {
    
    //MARK: - UI
    
    private let titleLabel = UILabel(text: "Discover")
    private let allButton = UIButton(text: "All")
    
    //MARK: - View
    
    override func setConstraints(frame: CGRect) {
        hstack(allButton, titleLabel, distribution: .fillEqually)
    }
    
    //MARK: - Bind

    override func bindViewModel() {
        guard let item = item as? DiscoveryHeaderItem else { return }

    }
    
}


