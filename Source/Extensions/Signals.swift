//
//  Signals.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 19/04/2020.
//

import Signals

public extension Signal {
    @discardableResult
    func newSubscribe(with observer: AnyObject, callback: @escaping SignalCallback) -> SignalSubscription<T> {
        cancelAllSubscriptions()
        return subscribe(with: observer, callback: callback)
    }
}
