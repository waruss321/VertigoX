//
//  WorkoutViewVM.swift
//  WorkoutApp
//
//  Created by Russell Warwick on 28/01/2020.
//  Copyright © 2020 Russell Warwick. All rights reserved.
//

import VertigoX
import Signals

protocol WorkoutViewVMProtocol: CollectionViewModel {
}

final class WorkoutViewVM: WorkoutViewVMProtocol {
    
    private let headerHeight: CGFloat
    
    init(headerHeight: CGFloat) {
        self.headerHeight = headerHeight
    }

    //MARK: - WorkoutViewVMProtocol
    
    var updateSections = Signal<[Section]>() //Because all of the network requests are within the viewmodel, when we want to add new data just call update sections.fire(sections) //Maybe should change to sell or some sort of call back??
    
    var sections: [Section] {
        return []
    }
    
    //MARK: - Sections

    
  
}
