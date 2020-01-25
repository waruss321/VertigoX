//
//  DateExtensions.swift
//  VertigoX
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

public extension DateFormatter {
    func parseStringToDate(_ stringDate : String?) -> Date {
        guard let stringDate = stringDate else { return Date() }
        self.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return self.date(from: stringDate) ?? Date()
    }
}

public extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

public extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

public extension String {
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}

public extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
