//
//  Dates.swift
//  RussTools
//
//  Created by Russell Warwick on 01/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static func custom(_ format: String, date: Date, locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
