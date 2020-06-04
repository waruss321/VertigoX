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
}

class ShopVM: ShopVMType {
    
    //MARK: - ShopVMType
        
    var sections: [Section] {
        return [topSection, pictures, header, articleSection, largePictures, bottomSection2]
    }
    
    private var topSection: VerticalSection {
        let items = [ExerciseItem(title: "Exercise 1"), ExerciseItem(title: "Exercise 2"), ExerciseItem(title: "Exercise 3")]
        
        return VerticalSection(items: items)
    }

    private var pictures: VerticalSection {
        
        let hItems = [ImageItem(title: "1"), ImageItem(title: "2"), ImageItem(title: "3"), ImageItem(title: "4"), ImageItem(title: "5"), ImageItem(title: "6")]
        
        
        let loader = HCollectionViewItem(items: hItems)
        
        loader.didChangePage = { page in
            print(page)
        }
        
        loader.didSelectAtIndex = { index in
            print(index)
        }
        
        return VerticalSection(items: [loader])
    }
    
    private var largePictures: VerticalSection {
        
        let hItems = [LargeImageItem(title: "1"), LargeImageItem(title: "2"), LargeImageItem(title: "3"), LargeImageItem(title: "4"), LargeImageItem(title: "5"), LargeImageItem(title: "6")]
        
        
        let loader = HCollectionViewItem(items: hItems)
        
        return VerticalSection(items: [loader])
    }
    
    private var header: VerticalSection {
        let items = [HeaderItem(title: "This is a header")]
        
        return VerticalSection(items: items)
    }
    
    private var articleSection: VerticalSection {
        let items = [ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article"), ExerciseItem(title: "article")]
        
        return VerticalSection(items: items)
    }
   
    
    private var bottomSection2: VerticalSection {
        let items = [ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: ""), ExerciseItem(title: "The End")]
        
        return VerticalSection(items: items)
    }


}

