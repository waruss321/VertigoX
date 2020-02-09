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
        return [exericsesSection]
    }
    
    //MARK: - Sections

    
    private var exericsesSection: TestSection {
        return TestSection(items: [ExerciseModel(test: "oijuiy7guftyhgvjbkjnl1"), ExerciseModel(test: "2"), ExerciseModel(test: "44"), ExerciseModel(test: "2"), ExerciseModel(test: "2"), ExerciseModel(test: "ojiu") , ExerciseModel(test: "2"), ExerciseModel(test: "fgfgda"), ExerciseModel(test: "2oijn g kff") ,ExerciseModel(test: "2") , ExerciseModel(test: "264rfgf"), ExerciseModel(test: "m;jiohugiyfutcyfhgvygi78t6ftu")])
    }
}
