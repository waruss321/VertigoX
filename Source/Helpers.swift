//
//  Helpers.swift
//  VertigoX
//
//  Created by Russell Warwick on 24/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import Signals

public enum ActionResult {
    case success
    case error(Error)
    case empty
    case update
    case failed(String)
}

public enum RequestResponse {
    case started(message: String)
    case success(message: String?)
    case failed(error: String)
}

public typealias ResultSignal = Signal<ActionResult>
public typealias VoidSignal = Signal<Void>
public typealias JSON = [String: Any]
