//
//  Cancellable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public protocol Cancellable {
    var isCancelled: Bool { get set }
    mutating func cancel()
}

extension Cancellable {
    public mutating func cancel() {
        self.isCancelled = true
    }
}
