//
//  CollectionViewModel.swift
//  VertigoX
//
//  Created by Russell Warwick on 25/01/2020.
//

import Signals

public protocol CollectionViewModel {
    var sections: [Section] { get }
}
