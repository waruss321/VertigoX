//
//  Bundle.swift
//  RussTools
//
//  Created by Russell Warwick on 01/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Foundation

public extension Bundle {
    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
    
    var appVersion: String? {
        guard let release = releaseVersionNumber, let build = buildVersionNumber else { return nil }
        return "\(release) (\(build))"
    }
}
