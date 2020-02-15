//
//  StringHelpers.swift
//  VertigoX
//
//  Created by Russell Warwick on 15/02/2020.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        if(isEmpty) { return true }
        return trimmingCharacters(in: .whitespaces) == ""
    }
}
